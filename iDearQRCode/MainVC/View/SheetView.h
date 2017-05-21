//
//  SheetView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetView : UIView

-(instancetype)initWithMenuArray:(NSArray *)menu CompleteBlock:(void(^)(NSInteger))selectBlock;

-(void)show;

-(void)remove;
@end
