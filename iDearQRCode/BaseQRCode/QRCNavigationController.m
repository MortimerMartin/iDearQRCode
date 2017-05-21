//
//  QRCNavigationController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/15.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRCNavigationController.h"

@interface QRCNavigationController ()

@end

@implementation QRCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"#5dc7cc"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]};
    //设置手势代理
//    self.interactivePopGestureRecognizer.delegate = self;

    //若需在某一个页面取消事件，只需要引入UINavigationController+FDFullscreenPopGesture.h文件，然后在viewDidLoad方法中设置self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO,并在上一个页面的viewWillAppear方法中设置self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES,就可自如地控制各个页面的右滑返回效果实现与否。
    // Do any additional setup after loading the view.
}


/**
 拦截push进来的所有子控件

 @param viewController 每一个push的子控件
 @param animated 有无动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //左上角的返回键
    //注意：第一个控制器不需要返回键
    //if不是第一个push进来的子控件
    if (self.childViewControllers.count >= 1) {
        //左上角的返回按钮
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"backBtnImg"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
         [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0); //这里微调返回键的位置
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;

    }

    [super pushViewController:viewController animated:animated];
}

-(void)back{
     [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
  return   self.topViewController;
};

//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    //这里设置边界的右滑手势
//    //如果当前显示的事第一个子控制器，则禁止返回手势
//    return self.childViewControllers.count>1;
//};
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
