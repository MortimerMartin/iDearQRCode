//
//  PreloadDetailCell.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/24.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreloadDetailCell : UITableViewCell

@property (nonatomic , assign) BOOL shouldMove;


@property (nonatomic , strong) NSArray * data;

@property (nonatomic , copy) void (^didCopyHandle)(NSArray * data);

@end
