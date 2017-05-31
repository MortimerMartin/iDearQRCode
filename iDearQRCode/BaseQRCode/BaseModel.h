//
//  BaseModel.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic , copy) NSString * URL;
@property (nonatomic , copy) NSString * name;
@property (nonatomic , copy) NSString * doSometing;
@property (nonatomic , copy) NSString * join_time;

@property (nonatomic , assign) NSInteger count;
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , copy) NSString * pickId;

@end
