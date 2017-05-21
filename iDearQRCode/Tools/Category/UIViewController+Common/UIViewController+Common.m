//
//  UIViewController+Common.m
//  SHUFEAlarm
//
//  Created by suxx on 16/7/8.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

-(void)jumpToViewControllerWithStoryboardName:(NSString *)sbName withStoryboardID:(NSString *)sbId{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:sbId];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIViewController *)getViewControllerWithStoryboardName:(NSString *)sbName withStoryboardID:(NSString *)sbId{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbId];
}

@end
