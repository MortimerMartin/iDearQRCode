//
//  BaseViewModel.m
//  iDearQRCode
//
//  Created by Mortimer on 17/6/7.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

@synthesize request = _request;
+(instancetype)alloc{
    BaseViewModel * viewModel = [super alloc];
    if (viewModel) {
        [self initialize];
    }

    return viewModel;
}

-(instancetype)initWithModel:(id)model{
    self = [super init];
    if (self) {

    }
    return self;
}

- (YQNetworking * )request{

    if (!_request){
        _request = [[YQNetworking alloc] init];
    }

    return _request;
    
}

-(void)initialize{

}
@end
