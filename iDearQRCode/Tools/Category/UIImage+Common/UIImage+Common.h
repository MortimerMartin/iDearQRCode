//
//  UIImage+Common.h
//  FrameworkSuxx
//
//  Created by suxx on 16/5/26.
//  Copyright © 2016年 suxx. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Common)

/**
 *  用color生成image
 *
 *  @param color 生成的image的颜色
 *  @param size  生成的image的大小
 *
 *  @return 生成的image
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  如果图片不需要一直显示或者图片很大（比如启动页）时，用这种方法，因为这种方法是不会放在缓存里面的
 *
 *  @param name 图片的名字
 *  @param type 图片的类型，如果png
 *
 *  @return 返回图片
 */
+(UIImage *)imageWithName:(NSString *)name withType:(NSString *)type;

@end
