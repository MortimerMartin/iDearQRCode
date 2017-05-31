//
//  NewPartCell.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPartCell : UITableViewCell

@property (nonatomic , copy) void(^didSelectHandle)(NSInteger  select,NSInteger row);

@property (nonatomic , copy) NSString * number;

@property (nonatomic , assign) BOOL isLastCell;

@property (nonatomic , copy) NSString * partName;

@property (nonatomic , assign) NSInteger index;

@end
