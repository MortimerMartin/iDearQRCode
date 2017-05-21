//
//  UIBarButtonItem+Item.h
//  GaoS
//
//  Created by 刘 on 16/11/7.
//  Copyright © 2016年 LiuH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightLighted:(UIImage *)heightImage addTarget:(id)target action:(SEL)action;

@end
