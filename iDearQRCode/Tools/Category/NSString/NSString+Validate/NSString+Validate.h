//
//  NSString+Validate.h
//  FrameworkSuxx
//
//  Created by suxx on 16/6/16.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

/**
 *  NSString 为空(nil)的验证
 *
 *  @return YES OR NO
 */
-(BOOL)emptyOrNull;

/**
 *  验证邮箱格式是否正确
 *
 *  @return YES OR NO
 */
-(BOOL)validateEmail;

/**
 *  验证电话号码格式是否正确
 *
 *  @return YES OR NO
 */
-(BOOL)validateMobileNumber;

/**
 *  验证身份证格式是否正确
 *
 *  @return YES OR NO
 */
//  4.身份证验证
-(BOOL)validateIdentityCard;

/**
 *  验证用户名或者密码
 *
 *  @return YES OR NO
 */
-(BOOL)validateUserNameOrPassword;

/**
 *  验证字符串只有数字和字母
 *
 *  @return YES OR NO
 */
-(BOOL)validateMakeUpOfNumberAndLetter;

/**
 *  验证是否只有数字
 *
 *  @return YES OR NO
 */
-(BOOL)validateOnlyNumber;

/**
 *  验证是否只有counter位数字
 *
 *  @param counter 数字的个数
 *
 *  @return YES OR NO
 */
-(BOOL)validatelOnlyNumberWithCounter:(NSUInteger)counter;

/**
 *  验证是否是min~max位的数字
 *
 *  @param min 数字最小位数
 *  @param max 数字最大位数
 *
 *  @return YES OR NO
 */
-(BOOL)validatelOnlyNumberWithMinBit:(NSUInteger)min withMaxBit:(NSUInteger)max;

/**
 *  验证至少是min位的数字
 *
 *  @param min 数字的最少位数
 *
 *  @return YES OR NO
 */
-(BOOL)validateOnlyNumberMinBit:(NSUInteger)min;

/**
 *  验证URL是否合法
 *
 *  @return YES OR NO
 */
-(BOOL)validateURL;

/**
 *  验证是否只有中文
 *
 *  @return YES OR NO
 */
-(BOOL)validateChinese;

@end
