//
//  KeyManager.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/27.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kKeyPassword = @"kPassword";

@interface KeyManager : NSObject

+ (void)saveData:(NSString *)service data:(id)data;
+ (id)loadData:(NSString *)service;
+ (void)deleteData:(NSString *)service;

@end
