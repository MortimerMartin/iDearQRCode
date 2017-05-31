//
//  PickDetailView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickDetailView.h"
#import "UIImageView+WebCache.h"

@interface PickDetailView ()
{
    UIView * _topView;
}
@property (nonatomic , strong) UIView * backView;
@property (nonatomic , strong) UIView * bottomView;


@property (nonatomic , assign) CGFloat lastHeight;

@end
@implementation PickDetailView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupDefaultView];
    }
    return self;
}

-(void)setupDefaultView{
    _backView = [UIView new];
    _backView.layer.cornerRadius = 4;
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderWidth = 0.6;
    _backView.layer.borderColor = line_Color.CGColor;
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];


    _topView = [UIView new];
    _topView.backgroundColor = [UIColor greenColor];
    [_backView addSubview:_topView];

    _bottomView = [UIView new];
    [_backView addSubview:_bottomView];

    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
    }];

    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_backView);
        make.height.mas_equalTo(8);
    }];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.right.bottom.equalTo(_backView);
    }];

    _lastHeight = 0;
}

-(void)UPDetailView:(NSMutableArray *)data{


    for (UIView * view in _bottomView.subviews) {
        [view removeFromSuperview];
    }

    for (int i = 0; i<data.count; i++) {
        NSArray * array = data[i];
        NSArray * labelArray =array[1];
        UIView * view = [self topView:array[0]];
        [_bottomView addSubview:view];

        _lastHeight += 10;//头视图margin＋10
        [view mas_updateConstraints:^(MASConstraintMaker *make) {


            make.top.mas_equalTo(_lastHeight);
            make.left.right.equalTo(_bottomView);
        }];

        _lastHeight += 35;//加上头视图大小

        for (int j = 0; j< labelArray.count; j++) {
            NSArray * temp = labelArray[j];
            UIView * labelView = [self labelView:temp];

            [_bottomView addSubview:labelView];
            [labelView mas_updateConstraints:^(MASConstraintMaker *make) {


                make.top.mas_equalTo(_lastHeight);
                make.left.right.equalTo(_bottomView);
                if (i == data.count-1 && j == labelArray.count - 1) {
                   make.bottom.mas_equalTo(-8).priorityHigh();
                }
            }];
            _lastHeight +=   42 ;//加上一个labelview的大小
        }

        _lastHeight +=10;//lineview 的 margin；
        if (data.count != 1) {
            if (i != data.count - 1) {
                UIView * line = [UIView new];
                line.backgroundColor = line_Color;
                [_bottomView addSubview:line];

                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_lastHeight);
                    make.left.equalTo(_bottomView).offset(4);
                    make.right.equalTo(_bottomView);
                    make.height.mas_equalTo(0.5);
                }];
            }

        }

    }


}

//-(void)setDetailModel:(UIDatePickerMode *)DetailModel{
//
//}

-(UIView *)topView:(NSArray *)personInfo{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView * image = [[UIImageView alloc] init];
    image.layer.cornerRadius = 15.0f;
    image.layer.masksToBounds = YES;
    [view addSubview:image];
    [image sd_setImageWithURL:[NSURL URLWithString:personInfo[0]] placeholderImage:[UIImage imageNamed:@""]];

    UILabel * title = [self creatLabel:personInfo[1] TextColor:text_Color2 Font:nil];
    [view addSubview:title];

    UILabel * detail = [self creatLabel:personInfo[2] TextColor:text_Color2 Font:nil];
    [view addSubview:detail];

    UILabel * time = [self creatLabel:personInfo[3] TextColor:text_Color3 Font:nil];;
    [view addSubview:time];

    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(6);
        make.top.equalTo(view);
        make.height.width.mas_equalTo(30);
    }];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(8);
        make.centerY.equalTo(image).offset(-8);
    }];

    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(6);
        make.centerY.equalTo(title);
    }];

    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title);
        make.centerY.equalTo(image).offset(8);
    }];

    return view;
}

-(UIView *)labelView:(NSArray *)content{

    UIView * labelView = [UIView new];
    labelView.backgroundColor = [UIColor whiteColor];

    UILabel * name = [self creatLabel:[NSString stringWithFormat:@"X %@",content[0]] TextColor:text_Color1 Font:nil];
    [labelView addSubview:name];

    UILabel * num = [self creatLabel:[NSString stringWithFormat:@"X %@",content[1]] TextColor:text_Color2 Font:nil];
    [labelView addSubview:num];

    UILabel * time = [self creatLabel:[NSString stringWithFormat:@"X %@",content[2]] TextColor:text_Color2 Font:nil];
    [labelView addSubview:time];

    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(labelView).offset(6);
        make.width.mas_equalTo((kScreen_width -20)*3/4);
    }];

    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(name);
        make.right.equalTo(labelView).offset(-6);
    }];

    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name);
        make.top.equalTo(name.mas_bottom).offset(6);
    }];

    return labelView;
}


-(UILabel *)creatLabel:(NSString *)text TextColor:(UIColor *)color Font:(UIFont *)font{
    UILabel * label = [UILabel new];
    if (!font) {
        font = kFont_14;
    }
    label.font = font;
    label.text = text;
    label.textColor = color;
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
