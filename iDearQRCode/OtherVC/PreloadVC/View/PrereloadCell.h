//
//  PrereloadCell.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "BaseTableViewCell.h"
@class PrereloadCellModel;
@interface PrereloadCell : BaseTableViewCell

@property (nonatomic ,strong) PrereloadCellModel * preModel;


@property (nonatomic , assign) NSInteger state;
@property (nonatomic , assign) NSUInteger index;

@property (nonatomic , assign) selectCellType selectType;

@property (nonatomic , assign) selectCellType selectCell;


//@property (nonatomic , assign) BOOL senderSelect;


@property (nonatomic , copy) void (^selectCellAction)(PrereloadCellModel * ,BOOL ,selectCellType,NSUInteger) ;
@end
