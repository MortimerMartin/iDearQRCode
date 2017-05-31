//
//  PickDetailFootView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickDetailFootView.h"

@interface PickDetailFootView ()

@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIView * bottomView;

@end
@implementation PickDetailFootView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultFootView];
    }
    return self;
}


-(void)setupDefaultFootView{

    _backView = [UIView new];
    _backView.layer.cornerRadius = 4;
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderWidth = 0.6;
    _backView.layer.borderColor = line_Color.CGColor;
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];


    UILabel * nameLabel = [UILabel new];
    nameLabel.font = kFont_14;
    nameLabel.text = @"领料明细:";
    [_backView addSubview:nameLabel];


    UIView * line = [UIView new];
    line.backgroundColor = line_Color;
    [_backView addSubview:line];

    _bottomView = [UIView new];
    [_backView addSubview:_bottomView];

    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.right.bottom.equalTo(self).offset(-10);
    }];

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).offset(6);
        make.top.equalTo(_backView).offset(4);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(4);
        make.left.right.equalTo(_backView);
        make.height.mas_equalTo(0.6);
    }];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.right.bottom.equalTo(_backView);
    }];
}

-(void)UPDetailFootView:(NSMutableArray *)data{

    UILabel * (^creatLabel)(NSString * text , UIColor * textColor) = ^(NSString * text , UIColor * textColor){
        UILabel * label = [UILabel new];
        label.font = kFont_14;
        label.text = text;
        label.textColor = textColor;
        return label;
    };



}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
