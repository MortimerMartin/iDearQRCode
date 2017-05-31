//
//  PreloadNewView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadNewView.h"

@interface PreloadNewView ()



@end

@implementation PreloadNewView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupDefaultView];
    }
    return self;
}


-(void)setupDefaultView{

    UILabel * (^creatLabel)(NSString * text , UIColor * textColor) = ^(NSString * text , UIColor * textColor){
        UILabel * label = [UILabel new];
        label.font = kFont_14;
        label.text = text;
        label.textColor = textColor;
        return label;
    };

    UILabel * nameL = creatLabel(@"配件名称 :",topView_Color);
    UILabel * numberL = creatLabel(@"配件编号 :",topView_Color);
    UILabel * countL = creatLabel(@"预装数量 :",topView_Color);
    [self addSubview:nameL];
    [self addSubview:numberL];
    [self addSubview:countL];
    UIView * (^creatView)() = ^{
        UIView * view = [UIView new];
        view.backgroundColor = line_Color;
        return view;
    };

    UIView * nameV = creatView();
    UIView * numberV = creatView();
    UIView * countV = creatView();
    [self addSubview:nameV];
    [self addSubview:numberV];
    [self addSubview:countV];
    UITextField * (^creatTextField)()= ^{
        UITextField * textField = [[UITextField alloc] init];
//        textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleNone;
        textField.font = kFont_16;
        textField.textColor = text_Color1;
        return textField;
    };

    UITextField * nameT = creatTextField();
    _nameText = nameT;
    UITextField * numberT = creatTextField();
    _numberText = numberT;
    UITextField * countT = creatTextField();
    _countText = countT;
    [self addSubview:nameT];
    [self addSubview:numberT];
    [self addSubview:countT];
//    _nameText.text = self.partname;
//    _numberText.text = self.partnumber;
//    _countText.text = self.partcount;

    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(6);
        make.top.equalTo(self).offset(10);
    }];

    [nameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameL.mas_bottom);
        make.left.equalTo(nameL);
        make.right.equalTo(self).offset(-6);
        make.height.mas_equalTo(30);
    }];

    [nameV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(nameT);
        make.top.equalTo(nameT.mas_bottom);
        make.height.mas_equalTo(0.6);
    }];

    [numberL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameV.mas_bottom).offset(15);
        make.left.equalTo(nameL);
    }];

    [numberT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberL.mas_bottom);
        make.left.right.height.equalTo(nameT);
    }];

    [numberV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(nameV);
        make.top.equalTo(numberT.mas_bottom);
    }];

    [countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberV.mas_bottom).offset(15);
        make.left.equalTo(nameL);
    }];

    [countT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(numberT);
        make.top.equalTo(countL.mas_bottom);
    }];

    [countV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(numberV);
        make.top.equalTo(countT.mas_bottom);
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
