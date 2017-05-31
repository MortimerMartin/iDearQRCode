//
//  QRCodeResultVC.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeResultVC : UIViewController
@property (nonatomic , copy) NSString * qrcode;
@property (nonatomic , copy) void(^restQRCode)();

@end
