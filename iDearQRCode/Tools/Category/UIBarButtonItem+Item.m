//
//  UIBarButtonItem+Item.m
//  GaoS
//
//  Created by 刘 on 16/11/7.
//  Copyright © 2016年 LiuH. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightLighted:(UIImage *)heightImage addTarget:(id)target action:(SEL)action{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn setImage:heightImage forState:UIControlStateHighlighted];
    [leftBtn sizeToFit];
    
    UIView *containView = [[UIView alloc]initWithFrame:leftBtn.bounds];
    [containView addSubview:leftBtn];
    //直接方btn可能使按钮点击范围变大
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.leftBarButtonItem =
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
}

@end
