//
//  PersonTableViewCell.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * content;
@property (nonatomic , assign) BOOL isLast;

@end
