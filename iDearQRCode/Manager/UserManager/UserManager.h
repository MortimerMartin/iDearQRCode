//
//  UserManager.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/27.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface UserManager : NSObject

+ (instancetype)sharedInstance;

+ (BOOL)isLogin;

+ (void)saveLocalUserLoginInfo;

+ (void)removeLocalUserLoginInfo;



-(void)updatePassword:(NSString *)password;

@property (nonatomic , strong) UserModel * userData;

@property (nonatomic , copy) NSString * password;
@property (nonatomic , copy) NSString * userId;
@property (nonatomic , copy) NSString * avater;
@property (nonatomic , copy) NSString * username;


@end
