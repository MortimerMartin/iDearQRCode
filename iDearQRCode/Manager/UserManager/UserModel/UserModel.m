//
//  UserModel.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/27.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "UserModel.h"
#import "YYModel.h"
@implementation UserModel

-(id)copyWithZone:(NSZone *)zone{
    return [self yy_modelCopy];
}

-(instancetype)init{
    if (self = [super init]) {
        _username = @"";
        _password = @"";

        _userId = @"";
        _avatar = @"";
        _creattime = @"";
        _nickname = @"";
    }
    return self;
}

+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id"};
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [self yy_modelInitWithCoder:aDecoder];
    }

    return self;
}

@end
