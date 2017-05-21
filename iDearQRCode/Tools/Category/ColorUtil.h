//
//  ColorUtil.h
//  lfys
//
//  Created by tao on 15/6/15.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * 颜色转换的工具类
 */
@interface ColorUtil : NSObject

//16进制颜色转UIColor
+(UIColor *)getUIColorByHex:(NSString*) hexStr;

//UIColor转UIImage
+ (UIImage *)getUIImageByUIColor:(UIColor*) color;

//单例
+(ColorUtil *) getInstance;

//获取首字母,如果是中文,并把中文转为字母,根据首字母改变背景色
+(UIColor *)changeColor:(NSString *)str;


+ (UIColor *) colorWithHexString: (NSString *)color;
@end

//全局变量
static ColorUtil *instance = nil;
