//
//  PreloadDetailView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/24.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreloadDetailView : UIView

@property (nonatomic , assign) NSInteger isFirst;

-(void)uploadDetailHeadView:(NSArray *)data;
@end
