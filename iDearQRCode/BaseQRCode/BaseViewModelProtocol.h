//
//  BaseViewModelProtocol.h
//  iDearQRCode
//
//  Created by Mortimer on 17/6/7.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQNetworking.h"
@protocol BaseViewModelProtocol <NSObject>

@optional
-(instancetype)initWithModel:(id)model;

@property (strong,nonatomic)YQNetworking * request;


/**
 * 初始化
 */
-(void)initialize;
@end
