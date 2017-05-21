//
//  UIImage+Normalimage.m
//  SHUFEAlarm
//
//  Created by 刘 on 16/11/24.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import "UIImage+Normalimage.h"

@implementation UIImage (Normalimage)
+ (UIImage *)getNormalImage:(NSString *)imageStr{
    
    UIImage *image = [UIImage imageNamed:imageStr];
    // 设置左边端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5;
    // 设置上边端盖高度
    NSInteger topCapHeight = image.size.height * 0.5;
    
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return newImage;

}
@end
