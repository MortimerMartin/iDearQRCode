//
//  UIColor+HexString.h
//  control
//
//  Created by pro on 17/2/9.
//  Copyright © 2017年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

//将HEX格式的颜色转化为RGB颜色的格式
+(UIColor *)colorWithHexString:(NSString *)color;


//另一种HEX 格式的颜色 ，例如：绿色 0xff00ff00
+(UIColor *)colorWithARGB:(NSInteger)ARGBValue;

+ (UIColor *) colorWithHex:(int)color;

+ (UIColor *)colorWithHexCColor:(NSString *)hexString;
@end
