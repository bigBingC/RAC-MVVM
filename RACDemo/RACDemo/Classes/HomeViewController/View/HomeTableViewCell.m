//
//  HomeTableViewCell.m
//  RACDemo
//
//  Created by 崔冰1 on 2018/7/11.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ivHeadIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setListInfo:(TopicList *)listInfo {
    _listInfo = listInfo;
    [self.ivHeadIcon sd_setImageWithURL:[NSURL URLWithString:listInfo.profile_image]];
    self.lblName.text = listInfo.name;
    self.lblTime.text = listInfo.created_at;
    self.lblContent.text = listInfo.text;

}
@end
