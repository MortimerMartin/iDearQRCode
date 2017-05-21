//
//  ViewModelClass.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/21.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ViewModelClass.h"
//#import "RTNetworking.h"
@implementation ViewModelClass

#pragma 接收传过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
}

@end
