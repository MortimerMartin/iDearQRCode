//
//  QRCodeResultView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRCodeResultView.h"
#import "NSString+Validate.h"
#import "UIView+Toast.h"
@interface QRCodeResultView ()

@property (nonatomic , copy) void(^didSelectHandle)(NSDictionary * data,NSInteger index);

@property (nonatomic , strong) UILabel * qrcode_num;

@property (nonatomic , strong) UITextField * count;
@property (nonatomic , strong) UITextField * name;

@end
@implementation QRCodeResultView

-(instancetype)initWithResultViewCompleteData:(void (^)(NSDictionary *, NSInteger))complete{

    self = [super init];

    if (self) {
        self.frame = CGRectMake(20, (kScreen_height - 266)/2, kScreen_width - 40, 266);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setupDefaultResultView];
        if (complete) {
            self.didSelectHandle = ^(NSDictionary * data, NSInteger index){
                complete(data,index);
            };
        }
    }
    return self;
}

-(void)setupDefaultResultView{

    UILabel * (^creatLabel)(NSString * text , UIColor * textColor) = ^(NSString * text , UIColor * textColor){
        UILabel * label = [UILabel new];
        label.font = kFont_14;
        label.text = text;
        label.textColor = textColor;
        return label;
    };

    UILabel * qrcodeLabel = creatLabel(@"条形码 :",topView_Color);
    self.qrcode_num = creatLabel(@"",text_Color1);
    UILabel * qrcodeNum = creatLabel(@"领料数量",topView_Color);
    UILabel * qrcodeName = creatLabel(@"领料名称",topView_Color);

    [self addSubview:qrcodeLabel];
    [self addSubview:self.qrcode_num];
    [self addSubview:qrcodeNum];
    [self addSubview:qrcodeName];

    UITextField *(^creatTextField)()= ^{
        UITextField * textField = [[UITextField alloc] init];
        textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleNone;
        textField.font = kFont_14;
        textField.textColor = text_Color1;
        return textField;
    };
    [self addSubview:self.count = creatTextField()];
     self.count.keyboardType = UIKeyboardTypeNumberPad;

    [self addSubview:self.name = creatTextField()];
    self.name.keyboardType = UIKeyboardTypeDefault;

    UIView * (^creatLine)() = ^{
        UIView * view = [UIView new];
        view.backgroundColor = line_Color;
        return view;
    };

    UIView * countLine = creatLine();
    UIView * nameLine = creatLine();
    UIView * topLine = creatLine();
    UIView * HLine = creatLine();

    [self addSubview:countLine];
    [self addSubview:nameLine];
    [self addSubview:topLine];
    [self addSubview:HLine];

    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:text_Color1 forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(disMissView:) forControlEvents:UIControlEventTouchUpInside];
    cancel.tag = 24;
    [self addSubview:cancel];

    UIButton * sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [sure setTitle:@"导入" forState:UIControlStateNormal];
    [sure setTitleColor:topView_Color forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(disMissView:) forControlEvents:UIControlEventTouchUpInside];
    sure.tag = 25;
    [self addSubview:sure];


    [qrcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(15);
    }];

    [self.qrcode_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qrcodeLabel);
        make.top.equalTo(qrcodeLabel.mas_bottom).offset(4);
    }];

    [qrcodeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qrcodeLabel);
        make.top.equalTo(self.qrcode_num.mas_bottom).offset(15);
    }];

    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qrcodeNum.mas_bottom);
        make.left.equalTo(qrcodeLabel);
        make.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];

    [countLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.count);
        make.height.mas_equalTo(0.6);
        make.top.equalTo(self.count.mas_bottom);
    }];

    [qrcodeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countLine.mas_bottom).offset(15);
        make.left.equalTo(qrcodeLabel);
    }];

    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qrcodeLabel);
        make.top.equalTo(qrcodeName.mas_bottom);
        make.right.height.equalTo(self.count);
    }];

    [nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(countLine);
        make.top.equalTo(self.name.mas_bottom);
    }];

    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(0.6);
        make.bottom.equalTo(cancel.mas_top);
    }];

    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_equalTo((kScreen_width -40.6)/2);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(50);
    }];


    [HLine mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(cancel);
        make.width.mas_equalTo(0.6);
        make.centerX.equalTo(self);
        make.centerY.equalTo(cancel);
    }];

    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.height.width.bottom.equalTo(cancel);
    }];

}

-(void)setQrcode:(NSString *)qrcode{
    _qrcode = qrcode;
    _qrcode_num.text = qrcode;
}
-(void)disMissView:(UIButton *)sender{

    NSInteger  selectIndex = 0;
    NSDictionary * data = [[NSDictionary alloc] init];
    if (sender.tag == 24) {
        selectIndex = 0;
    }else{
        selectIndex = 1;
        NSString * count = _count.text;
        if ([count emptyOrNull]) {
            [self makeToast:@"请输入数量" duration:0.2 position:CSToastPositionTop];
//            [self makeToast:@"请输入数量" ];
            return;
        }

        if (![count validateOnlyNumber]) {
            [self makeToast:@"请输入纯数字" duration:0.2 position:CSToastPositionTop];
//            [self makeToast:@"请输入纯数字"];
            return;
        }

        NSString * name = _name.text;
        if ([name emptyOrNull]) {
            [self makeToast:@"请输入物料名称" duration:0.2 position:CSToastPositionTop];
//            [self makeToast:@"请输入物料名称"];
            return;
        }

        data = @{ @"qrcode" : self.qrcode,
                  @"qrcodeNum" : self.count.text,
                  @"qrcodeName" : self.name.text
                };
    }

    if (self.didSelectHandle) {
        self.didSelectHandle(data,selectIndex);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
