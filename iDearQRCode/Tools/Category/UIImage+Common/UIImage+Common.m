//
//  UIImage+Common.m
//  FrameworkSuxx
//
//  Created by suxx on 16/5/26.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)imageWithName:(NSString *)name withType:(NSString *)type{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

- (UIImage *)circleImage {

    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);

    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);

    // 裁剪
    CGContextClip(ctx);

    // 将原照片画到图形上下文
    [self drawInRect:rect];

    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
