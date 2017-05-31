//
//  NewPartNumberView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPartNumberView : UIView


/**
 初始化numberView

 @param complete 获取数量的blcok
 @return 返回view
 */
-(instancetype)initWithComplete:(void(^)(NSInteger index))complete;

-(void)show;

-(void)dissMiss;
@end
