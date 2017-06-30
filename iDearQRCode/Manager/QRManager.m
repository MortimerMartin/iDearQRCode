//
//  QRManager.m
//  iDearQRCode
//
//  Created by Mortimer on 17/6/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRManager.h"

@interface QRManager ()

@property (nonatomic , strong) NSMutableArray * data;
@property (nonatomic , strong) NSMutableArray * selectData;

@property (nonatomic , strong) UITableView * tableView;

@end
@implementation QRManager
static QRManager * manager;
+(instancetype)sharedInstance{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        manager = [[self alloc] init];
    });

    return manager;
}


-(void)setViews:(NSArray *)views{
    self.tableView = views[0];
}

-(void)setManagerData:(NSMutableArray *)data{
    self.data = data;
}

-(void)setManagerSelectData:(NSMutableArray *)data{
    self.selectData = data ;
}

-(void)setDeleteState{

}

-(void)setCombineState{

}


-(void)reloadData{
    [self.tableView reloadData];
}

@end
