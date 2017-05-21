//
//  PickAlert.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/19.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickAlert : UIView

-(instancetype)initWithPickTitle:(NSString *)title AlertAction:(NSArray *)actions Complete:(void(^)(NSInteger index))complete;

@property (nonatomic , copy) void(^clickBtn)(NSInteger index);

-(void)showAlert;

-(void)dismiss;

-(void)remove;
@end
