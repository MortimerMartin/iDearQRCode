//
//  UserManager.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/27.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "UserManager.h"
#import "UserModel.h"
#import "KeyManager.h"
#define USER_Data @"User_Data"
@implementation UserManager


+(instancetype)sharedInstance{
    static UserManager * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(instancetype)init{
    if (self = [super init]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _userData  =  [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:USER_Data]];
        _userId = _userData.userId;
        _username = _userData.username;
        _avater = _userData.avatar;
    }
    return self;
}


-(void)updatePassword:(NSString *)password{
    if (!password.length) {
        return;
    }

    [KeyManager saveData:kKeyPassword data:password];
}

+(void)saveLocalUserLoginInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[UserManager sharedInstance].userData];
    [userDefaults setObject:data forKey:USER_Data];
    [userDefaults synchronize];
}

+ (void)removeLocalUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_Data];
    [userDefaults synchronize];
}

-(UserModel *)loadLocalUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:USER_Data]];
}

+(BOOL)isLogin{
    return [UserManager sharedInstance].userData.userId.length > 0;
}

- (NSString *)password {
    return safeString([KeyManager loadData:kKeyPassword]);
}

NSString* safeString(id obj) {
    return [obj isKindOfClass:[NSObject class]]?[NSString stringWithFormat:@"%@",obj]:@"";
}

@end
