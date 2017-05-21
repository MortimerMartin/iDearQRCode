//
//  NSString+dateString.m
//  LJBiddingPlatform
//
//  Created by 献华 付 on 16/2/2.
//  Copyright © 2016年 Do1. All rights reserved.
//

#import "NSString+dateString.h"

@implementation NSString (dateString)
#pragma mark -----日期字符转换
-(NSString*)dateString{
    if (!self.length) {
        return @"";
    }
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:self];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *formatdateString = [dateFormat stringFromDate:fromDate];
    return formatdateString;
    
}

//日期转字符串（只保留时分秒）
+(NSString *)dateStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    return [formatter stringFromDate:date];
}
//日期转字符串（只保留年月日）
+(NSString *)timeStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    return [formatter stringFromDate:date];
}
- (NSString *)formateDateString
{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:self];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日HH:mm";
    NSString *formatdateString = [formatter stringFromDate:fromDate];
    return formatdateString;
}
@end
