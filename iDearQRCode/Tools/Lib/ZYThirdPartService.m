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
@implementation ZYThirdPartService

+(void)load{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        [[self class] initCoredata];

        [[self class] ls_setKeyBord];

        [[self class] ls_testReachableStaus];
    });
}
#pragma mark - 初始化coredata
+ (void)initCoredata {

    [RTNetworking updateBaseUrl:@"https://api.shunliandongli.com"];
    [RTNetworking enableInterfaceDebug:YES]; //default  NO

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

@end
