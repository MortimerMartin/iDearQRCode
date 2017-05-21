//
//  NSString+dateString.h
//  LJBiddingPlatform
//
//  Created by suxx on 16/2/2.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (dateString)
//yyyy-MM-dd HH:mm:ss -》yyyy-MM-dd
-(NSString*)dateString;

//日期转字符串（只保留年月日）
+(NSString *)timeStringFromDate:(NSDate *)date;

//日期转字符串（只保留时分秒）
+(NSString *)dateStringFromDate:(NSDate *)date;

//带汉字年月的字符串
- (NSString *)formateDateString;


@end
