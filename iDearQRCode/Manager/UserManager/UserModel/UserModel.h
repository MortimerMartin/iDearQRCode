//
//  UserModel.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/27.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , copy) NSString * username;
@property (nonatomic , copy) NSString * password;
@property (nonatomic , copy) NSString * userId;
@property (nonatomic , copy) NSString * avatar; //头像
@property (nonatomic , copy) NSString * creattime;
@property (nonatomic , copy) NSString * nickname;

@end
