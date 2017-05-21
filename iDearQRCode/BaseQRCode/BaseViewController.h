//
//  BaseViewController.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/15.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * dataSource;
@property (nonatomic , strong) UISearchController * searchView;

-(void)setupRightItem:(NSString *)titile;
-(void)removeRightItem;
@end
