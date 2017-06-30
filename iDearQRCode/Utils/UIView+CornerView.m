//
//  UIView+CornerView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/6/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "UIView+CornerView.h"

@implementation UIView (CornerView)

-(CALayer *)getCornerView{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    return  maskLayer;
}
@end
