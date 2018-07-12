# RAC-MVVM
RAC的基本使用以及使用RAC来搭建MVVM框架

## 一、设计模式

#####一直想要寻求个完美的设计模式来搭建一个好的项目框架。现在MVC依然是目前主流客户端编程框架，但是其带来的问题一直不能被忽略：

* 厚重的ViewController
* 遗失的网络逻辑

#####为了避免和解决上述问题，MVVM应运而生。MVVM的主要目的是为了分离View和Model。

###1、MVC（Model View Controller）

#####典型的MVC：view将用户交互通知给Controller，Controller通过更新model来反应状态的改变，model通知Controller来更新他们负责的view。

##### 但是现在我们用的MVC并不符合典型的MVC设计模式，现在是view直接调用model，所以事实上典型的MVC原则已经违背。如果严格遵守MVC的话，会把view的设置放在Controller中，不向view传递一个model对象，这样会大大增加Controller的体积。

### 2、MVVM(Model View View-Model)

##### `View <-> C <-> ViewModel <-> Model`，所以`使用MVVM之后，就不需要Controller`的说法是不正确的。严格来说`MVVM`其实是`MVCVM`。Controller夹在View和ViewModel之间做的其中一个主要事情就是将View和ViewModel进行绑定。在逻辑上，Controller知道应当展示哪个View，Controller也知道应当使用哪个ViewModel，然而View和ViewModel它们之间是互相不知道的，所以Controller就负责控制他们的绑定关系，所以叫`Controller/控制器`就是这个原因。

#####`在MVC的基础上，把C拆出一个ViewModel专门负责数据处理的事情，就是MVVM。`然后，为了让View和ViewModel之间能够有比较松散的绑定关系，于是我们使用ReactiveCocoa，因为苹果本身并没有提供一个比较适合这种情况的绑定方法。iOS领域里KVO，Notification，block，delegate和target-action都可以用来做数据通信，从而来实现绑定，但都不如ReactiveCocoa提供的RACSignal来的优雅，如果不用ReactiveCocoa，绑定关系可能就做不到那么松散那么好，但并不影响它还是MVVM。

###二、ReactiveCocoa

#####ReactiveCocoa（简称为RAC）,是由Github开源的一个应用于iOS和OS开发的新框架。RAC结合了函数式编程（Functional Programming）和响应式编程（React Programming）的框架，也可称其为函数响应式编程（FRP）框架 。







