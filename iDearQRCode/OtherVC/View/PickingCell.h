//
//  PickingCell.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/17.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PickingModel;

typedef enum {
    selectCellNormal = 0,
    selectCellDelete,
    selectCellCombine,
    selectCellError
} selectCellType;
@interface PickingCell : UITableViewCell

@property (nonatomic , strong) PickingModel * pickModel;


@property (nonatomic , assign) NSInteger state;
@property (nonatomic , assign) NSUInteger index;

@property (nonatomic , assign) selectCellType selectType;

@property (nonatomic , copy) void (^selectCellAction)(PickingModel * ,BOOL ,selectCellType,NSUInteger) ;



@end
