//
//  QRCodeResultView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeResultView : UIView

-(instancetype)initWithResultViewCompleteData:(void(^)(NSDictionary * data,NSInteger index))complete;

@property (nonatomic , copy) NSString * qrcode;


@end
