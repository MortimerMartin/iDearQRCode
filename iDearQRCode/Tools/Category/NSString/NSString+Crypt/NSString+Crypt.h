//
//  NSString+Crypt.h
//  SHUFEAlarm
//
//  Created by suxx on 16/7/11.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>


@interface NSString (Crypt)


// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

+ (NSString *)buildJson:(NSDictionary *)dic;

//生成UUID(16进制表示,UTF8)
+ (NSString*)uuid;



@end
