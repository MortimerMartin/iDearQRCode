//
//  Tools.h
//  MVVMDemo
//
//  Created by Mortimer on 17/5/4.
//  Copyright © 2017年 pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject


+(NSString *)getTimes;
/**
 时间戳转date

 @param cTime 时间戳
 @param format 格式
 @return date
 */
+(NSDate *)dateFromTimes:(long)cTime forMormat:(NSString *)format;


/**
 手机号验证

 @param number 手机号
 @return 是否是正确的手机号
 */
+ (BOOL) isValidateNumber:(NSString *)number;


/**
 裁剪图片

 @param image 原始图片
 @param asize 大小
 @return 裁剪过的图片
 */
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


/**
 验证码倒计时

 @param btn 倒计时button
 */
+(void)receiveCheckNumButtonWithBtn:(UIButton *)btn;

@end
