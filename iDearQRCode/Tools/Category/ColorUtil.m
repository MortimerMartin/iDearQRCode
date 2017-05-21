//
//  ColorUtil.m
//  lfys
//
//  Created by tao on 15/6/15.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil

/*
 * 单例方法
 */
+ (ColorUtil *) getInstance {
    if (!instance)
    {
        instance = [[super alloc] init];
    }
    return instance;
}

/*
 * 16进制颜色转UIColor
 */
+(UIColor *)getUIColorByHex:(NSString*) hexStr{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

/*
 * UIColor转UIImage
 */
+(UIImage *)getUIImageByUIColor:(UIColor*) color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获取首字母,如果是中文,并把中文转为字母,根据首字母改变背景色
+(UIColor *)changeColor:(NSString *)str
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
    
    NSArray *pyArray = [ms componentsSeparatedByString:@" "];
    if(pyArray && pyArray.count > 0){
        ms = [[NSMutableString alloc] init];
        for (NSMutableString *strTemp in pyArray) {
            ms = [ms stringByAppendingString:[strTemp substringToIndex:1]];
        }
    }
    
    str = [ms uppercaseString];
    
    if ([str isEqualToString:@"A"] || [str isEqualToString:@"B"])
        
    {
        return  [ColorUtil getUIColorByHex:@"f65e8d"];
    }
    
    if ([str isEqualToString:@"C"] || [str isEqualToString:@"D"])
    {
        return [ColorUtil getUIColorByHex:@"ff8e6b"];
        
    }
    
    if ([str isEqualToString:@"E"] || [str isEqualToString:@"F"])
    {
        return [ColorUtil getUIColorByHex:@"5ec9f6"];
        
    }
    
    if ([str isEqualToString:@"G"] || [str isEqualToString:@"H"])
    {
        return [ColorUtil getUIColorByHex:@"3bc2b5"];
        
    }
    
    if ([str isEqualToString:@"I"] || [str isEqualToString:@"J"])
    {
        return [ColorUtil getUIColorByHex:@"78919d"];
        
    }
    
    if ([str isEqualToString:@"K"] || [str isEqualToString:@"L"])
    {
        return [ColorUtil getUIColorByHex:@"78c06e"];
        
    }
    
    if ([str isEqualToString:@"M"] || [str isEqualToString:@"N"])
    {
        return  [ColorUtil getUIColorByHex:@"ff943e"];
        
    }
    
    if ([str isEqualToString:@"O"] || [str isEqualToString:@"P"])
    {
        return [ColorUtil getUIColorByHex:@"bd84cd"];
        
    }
    
    if ([str isEqualToString:@"Q"] || [str isEqualToString:@"R"])
    {
        return [ColorUtil getUIColorByHex:@"a1887f"];
        
    }
    
    if ([str isEqualToString:@"S"] || [str isEqualToString:@"T"])
    {
        return  [ColorUtil getUIColorByHex:@"38acff"];
        
    }
    
    if ([str isEqualToString:@"U"] || [str isEqualToString:@"V"] || [str isEqualToString:@"W"])
    {
        return [ColorUtil getUIColorByHex:@"5c6bc0"];
        
    }
    
    if ([str isEqualToString:@"X"] || [str isEqualToString:@"Y"] || [str isEqualToString:@"Z"])
    {
        return [ColorUtil getUIColorByHex:@"f6bf26"];
        
    }
    
    return [ColorUtil getUIColorByHex:@"f65e8d"];
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
@end
