//
//  UIViewController+Common.h
//  SHUFEAlarm
//
//  Created by suxx on 16/7/8.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)

/**
 *  根据storyboardName和storyboardID跳转到相应的视图控制器
 *
 *  @param sbName storyboardName
 *  @param sbId   storyboardID
 */
-(void)jumpToViewControllerWithStoryboardName:(NSString *)sbName withStoryboardID:(NSString *)sbId;

/**
 *  根据storyboardName和storyboardID获取相应的视图控制器
 *
 *  @param sbName storyboardName
 *  @param sbId   storyboardID
 *
 *  @return 相应的视图控制器
 */
-(UIViewController *)getViewControllerWithStoryboardName:(NSString *)sbName withStoryboardID:(NSString *)sbId;

@end
