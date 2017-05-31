//
//  PersonHeadView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PersonHeadView.h"
#import "UserModel.h"
@interface PersonHeadView ()

@property (nonatomic , strong) UIImageView * backView;
@property (nonatomic , strong) UIImageView * headView;
@property (nonatomic , strong) UILabel * name_label;
@property (nonatomic , strong) UILabel * do_label;

@end
@implementation PersonHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupHeadUI];
    }
    return self;
}


-(void)setupHeadUI{
    _backView = [[UIImageView alloc] init];
    [self addSubview:_backView];

    _headView = [[UIImageView alloc] init];
    _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = 30;
    [self.backView addSubview:_headView];

    _name_label = [UILabel new];
    _name_label.font = [UIFont systemFontOfSize:18];
    _name_label.textColor = [UIColor whiteColor];
    _name_label.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:_name_label];

    _do_label = [UILabel new];
    _do_label.font = [UIFont systemFontOfSize:14];
    _do_label.textAlignment = NSTextAlignmentCenter;
    _do_label.textColor = do_Color;
    [self.backView addSubview:_do_label];
}


-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
   _name_label.text = userModel.username;
    [_headView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:[UIImage imageNamed:@""]];
    _do_label.text =  userModel.userId;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];

    [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.centerY.equalTo(_backView).offset(32);
        make.height.width.mas_equalTo(60);
    }];

    [_name_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headView);
        make.top.equalTo(_headView.mas_bottom).offset(12);
    }];

    [_do_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_name_label);
        make.top.equalTo(_name_label.mas_bottom).offset(8);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
