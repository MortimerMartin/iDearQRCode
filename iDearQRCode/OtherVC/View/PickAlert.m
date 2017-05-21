//
//  PickAlert.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/19.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickAlert.h"
#import "UIView+MJExtension.h"
@interface PickAlert ()
{
    UIView * V_line;
    UIView * contentView;
}
@property (nonatomic , strong) NSArray * actions;
@property (nonatomic , copy) NSString * title;

@end
@implementation PickAlert

-(instancetype)initWithPickTitle:(NSString *)title AlertAction:(NSArray *)actions Complete:(void (^)(NSInteger))complete{
    if (self = [super init]) {
        self.frame = CGRectMake(0, (kScreen_height-64)/2, kScreen_width, 1);
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.actions = actions;
        self.title = title;
        [self setupAlertView];
        if (complete) {
            self.clickBtn = ^(NSInteger index){
                complete(index);
            };
        }
    }

    return self;
}

-(void)setupAlertView{
    UIView * centerView = [UIView new];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self addSubview:centerView];

    UILabel * title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = self.title;
    title.font = kFont_16;
    title.textColor = text_Color1;
    [centerView addSubview:title];


    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreen_width-66);
    }];
    contentView = centerView;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(centerView);
        make.centerY.equalTo(centerView).offset(-20);
//        make.height.mas_equalTo(40);
        make.left.right.equalTo(centerView);
    }];

    V_line = [UIView new];
    V_line.backgroundColor = line_Color;
    [centerView addSubview:V_line];

    [V_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(centerView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(centerView).offset(-40);
    }];

    for (int i = 0; i<self.actions.count; i++) {
//        [H_line removeFromSuperview];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.actions[i] forState:UIControlStateNormal];
        [btn setTitleColor:i == 0 ? text_Color1 : [UIColor greenColor] forState:UIControlStateNormal];
        btn.tag = 205 + i;
        [btn addTarget:self action:@selector(clickAlertBtn:) forControlEvents:UIControlEventTouchUpInside];
        [centerView addSubview:btn];
        CGFloat kWidth = 0;
        if (i == 1){
            kWidth = (kScreen_width - 0.5)/i;
        }else{
            kWidth = kScreen_width;
        }

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i>1) {
                make.top.equalTo(centerView).offset(209.5+(i * 40.5));
            }else{
                make.top.equalTo(V_line.mas_bottom);
            }
            if (self.actions.count == 2) {
                make.width.mas_equalTo((kScreen_width - 66 - 0.5)/2);
                make.left.mas_equalTo(i*((kScreen_width - 66 - 0.5)/2));
            }else{
                make.left.right.equalTo(centerView);
            }

            make.height.mas_equalTo(40);
            if (i == self.actions.count  - 1) {
                make.bottom.equalTo(centerView);
            }
        }];

        UIView * new = [UIView new];
        new.backgroundColor = line_Color;
        [centerView addSubview:new];
        if (self.actions.count == 2) {
            if (i ==0) {
                [new removeFromSuperview];
            }else{
                [new mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(40);
                    make.bottom.equalTo(centerView);
                    make.width.mas_equalTo(0.5);
                    make.centerX.equalTo(centerView);
                }];
            }


        }else if (self.actions.count == 1){
            [new removeFromSuperview];
        }else{
            [new mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(250+i*40);
                make.height.mas_equalTo(0.5);
                make.left.right.equalTo(centerView);
            }];
        }

    }
}

-(void)clickAlertBtn:(UIButton *)sender{
    if (self.clickBtn) {
        _clickBtn(sender.tag - 205);
    }
    [self dismiss];
}

-(void)showAlert{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.mj_y = 64;
        self.mj_h = kScreen_height - 64;


    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{

            [contentView mas_updateConstraints:^(MASConstraintMaker *make) {

                make.height.mas_equalTo(160);
            }];
        }];
    }];
}

-(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.mj_y = kScreen_height-264;
        self.mj_h = 1;
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
        }];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

-(void)remove{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
