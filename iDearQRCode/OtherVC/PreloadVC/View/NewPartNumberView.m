//
//  NewPartNumberView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "NewPartNumberView.h"
#import "UIView+MJExtension.h"
@interface NewPartNumberView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,copy) void(^didClickHandle)(NSInteger number);
@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIPickerView * pick;
@property (nonatomic , strong) NSMutableArray * number;


@end
@implementation NewPartNumberView

-(instancetype)initWithComplete:(void (^)(NSInteger))complete{
    if (self = [super init]) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.frame = CGRectMake(0, 128, kScreen_width, kScreen_height - 64);
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissMiss)]];
        [self loadData];
        [self setupPartNumberView];
        if (complete) {
            self.didClickHandle = ^(NSInteger number){
                complete(number);
            };
        }
    }
    return self;
}


-(void)loadData{
    self.number = [NSMutableArray arrayWithCapacity:100];
    for (int i = 1; i< 501; i++) {
        [self.number addObject:@(i)];
    }
}

-(void)setupPartNumberView{

    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor grayColor];
    [self addSubview:_bottomView];

    UIButton * (^creatBtn)(NSString *,UIColor *,UIColor *,NSInteger )= ^(NSString * title,UIColor * backColor,UIColor * titleColor,NSInteger tag){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        if (backColor) {
            btn.backgroundColor = backColor;
            btn.layer.cornerRadius = 4;
            btn.layer.masksToBounds = YES;
        }
        if (titleColor) {
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
        }
        btn.tag = tag;
        [btn addTarget:self action:@selector(PickNumberClickAction:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };

    UIButton * cancel = creatBtn(@"取消",nil,[UIColor blueColor],30);
    UIButton * sure = creatBtn(@"确定",nil,[UIColor blueColor],31);


    [self.bottomView addSubview:cancel ];
    [self.bottomView addSubview:sure ];

    UILabel * promit = [UILabel new];
    promit.text = @"请选择数量";
    promit.textColor = text_Color1;
    [self.bottomView addSubview:promit];

    self.pick = [UIPickerView new];
    [self.bottomView addSubview:self.pick];
    self.pick.backgroundColor = [UIColor whiteColor];
//    self.pick.showsSelectionIndicator = YES;
    self.pick.delegate = self;
    self.pick.dataSource = self;



    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(240);
    }];
    [self.pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.bottomView);
        make.height.mas_equalTo(200);
    }];

    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(6);
        make.bottom.equalTo(self.pick.mas_top).offset(-4);
    }];

    [promit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cancel);
        make.centerX.equalTo(self.bottomView);
    }];
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cancel);
        make.right.equalTo(self.bottomView).offset(-6);
    }];

    if (IOS_SYSTEM_VERSION > 10) {
        UIView * topL = [UIView new];
        topL.backgroundColor = line_Color;
        [_pick addSubview:topL];

        UIView * bottomL = [UIView new];
        bottomL.backgroundColor = line_Color;
        [_pick addSubview:bottomL];

        [topL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_pick);
            make.height.mas_equalTo(0.6);
            make.centerY.equalTo(_pick).offset(-15);
        }];

        [bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(topL);
            make.centerY.equalTo(_pick).offset(15);
        }];
    }

}

#pragma mark UIPickView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return self.number.count;
}

#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [NSString stringWithFormat:@"%d", [self.number[row] intValue]];
}

-(void)PickNumberClickAction:(UIButton *)sender{

    if (sender.tag == 31) {
        NSInteger index = [[self.number objectAtIndex:[self.pick selectedRowInComponent:0]] integerValue];

        if (index) {
            if (self.didClickHandle) {
                _didClickHandle(index);
            }
        }

    }else{

    }
    [self dissMiss];
}

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:0.4 animations:^{
        self.mj_y = 64;
        self.alpha = 1;
    } ];

}

-(void)dissMiss{

    [UIView animateWithDuration:0.4 animations:^{
        self.mj_y = 128;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
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
