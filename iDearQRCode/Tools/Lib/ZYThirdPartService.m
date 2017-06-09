//
//  ZYThirdPartService.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/21.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ZYThirdPartService.h"
#import "IQKeyboardManager.h"
#import "RTNetworking.h"
#import "UserModel.h"
#import "UserManager.h"
@implementation ZYThirdPartService

+(void)load{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        [[self class] initCoredata];

        [[self class] ls_setKeyBord];

        [[self class] ls_testReachableStaus];

        [[self class]  setUserData];
    });
}
#pragma mark - 初始化coredata
+ (void)initCoredata {

    [RTNetworking updateBaseUrl:@"http://image.degjsm.cn/EHome/services/api/mobileManager/"];
    [RTNetworking enableInterfaceDebug:NO]; //default  NO

    [RTNetworking configRequestType:kRTRequestTypeJSON
                           responseType:RTResponseTypeData
                    shouldAutoEncodeUrl:YES
                callbackOnCancelRequest:NO];

}

#pragma mark - 键盘回收相关
+ (void)ls_setKeyBord {

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; //控制整个功能
    manager.shouldResignOnTouchOutside = YES; //控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES; //控制键盘上的工具条文字颜色是否用户自定义。

    manager.enableAutoToolbar = YES; //控制是否显示键盘上的工具条。
}

#pragma mark － 检测网络相关
+ (void)ls_testReachableStaus {

}


#pragma mark - 保存用户信息

+ (void)setUserData{

    UserModel * user = [[UserModel alloc] init];
    user.username = @"Mortimer";
    user.userId = @"007";
    user.avatar = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=720891101,4253860064&fm=23&gp=0.jpg";
    user.nickname = @"没心没肺，没血没泪";
    user.password = @"mmddd";
    
    [UserManager sharedInstance].userData = user;
    [UserManager saveLocalUserLoginInfo];
}

@end
