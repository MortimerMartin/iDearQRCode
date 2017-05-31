//
//  PartSearchView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/26.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartSearchView : UIView


-(instancetype)initWithPartSearchView:(void(^)(NSString * part))complete;

-(void)show;
@end
