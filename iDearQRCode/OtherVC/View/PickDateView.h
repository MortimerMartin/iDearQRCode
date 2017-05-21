//
//  PickDateView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/20.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickDateView : UIView
-(instancetype)initWithScreenDate:(void(^)(NSString * state, NSString * end,NSInteger cancel))screen;
@property (nonatomic , copy) void(^didSelectCell)(NSString * pickId);

-(void)show;
@end
