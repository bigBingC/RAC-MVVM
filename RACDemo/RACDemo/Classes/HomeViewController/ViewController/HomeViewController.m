//
//  HomeViewController.m
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/10.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HomeViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createBaseView];
    [self registerCell];
}

- (void)createBaseView {
    self.title = @"RAC+MVVM";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.viewModel = [[HomeViewModel alloc] init];
    @weakify(self);
//    [self.viewModel sendRequest:^(id result) {
//        @strongify(self);
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        NSLog(@"请求失败");
//    }];
    [[self.viewModel fetchBaseData] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    } error:^(NSError *error) {
         NSLog(@"请求失败");
    }];
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:HomeTableViewCellID bundle:nil] forCellReuseIdentifier:HomeTableViewCellID];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    CGFloat height = [tableView fd_heightForCellWithIdentifier:HomeTableViewCellID cacheByIndexPath:indexPath configuration:^(HomeTableViewCell *cell) {
        cell.listInfo = weakSelf.viewModel.listArray[indexPath.row];
    }];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeTableViewCellID];
    cell.listInfo = [self.viewModel.listArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
