//
//  ResultDisplayController.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/20.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ResultDisplayControllerDelegate <NSObject>

@optional
-(void)didSelectRow:(NSIndexPath *)indexPath;

@end
@interface ResultDisplayController : UITableViewController<UISearchResultsUpdating>


@property (nonatomic , weak) id<ResultDisplayControllerDelegate>  delegate;


@property (nonatomic , strong) NSMutableArray * datas;
@property (nonatomic , copy) void(^upPickStatusStytle)(void);
@property (nonatomic , copy) NSString * Classtitle;

@end
