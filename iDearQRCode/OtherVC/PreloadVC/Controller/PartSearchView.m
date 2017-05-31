//
//  PartSearchView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/26.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PartSearchView.h"
#import "UIView+MJExtension.h"

@interface PartSearchView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , strong) UITextField * searchView;
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UIPickerView * searchPick;
@property (nonatomic , strong) NSMutableArray * searchData;
@property (nonatomic , strong) NSMutableArray * resultData;

//@property (nonatomic , assign) NSInteger row;

@property (nonatomic , copy) void(^didSelectRow)(NSString * partname);

@end
@implementation PartSearchView

-(instancetype)initWithPartSearchView:(void (^)(NSString *))complete{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self setupPartSearchView];
        if (complete) {
            self.didSelectRow = ^(NSString * partname){
                complete(partname);
            };
        }
    }
    return self;
}


-(void)setupPartSearchView{

    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    _topView = view;
    UITextField * textField = [[UITextField alloc] init];
    textField.backgroundColor = back_Color;
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = kFont_16;
    textField.textColor = text_Color1;
    _searchView = textField;
    [textField addTarget:self action:@selector(searchData:) forControlEvents:UIControlEventEditingChanged];
    [_topView addSubview:textField];

    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:text_Color1 forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:cancel];

    UIView * line = [UIView new];
    line.backgroundColor = line_Color;
    [_topView addSubview:line];


    self.searchPick = [UIPickerView new];
    [self.topView addSubview:self.searchPick];
    self.searchPick.backgroundColor = [UIColor whiteColor];
    //    self.pick.showsSelectionIndicator = YES;
    self.searchPick.delegate = self;
    self.searchPick.dataSource = self;
    [_topView addSubview:self.searchPick];

    _topView.frame = CGRectMake(0, -64, kScreen_width, 264);
//    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(self);
//        make.height.mas_offset(264);
//    }];

    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(6);
        make.top.equalTo(self).offset(26);
        make.height.mas_equalTo(30);
        make.right.equalTo(cancel.mas_left).offset(-8);
    }];

    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_searchView);
        make.right.equalTo(_topView).offset(-6);
        make.width.mas_equalTo(50);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_topView);
        make.height.mas_equalTo(0.6);
        make.top.equalTo(_topView).offset(63);
    }];

    [_searchPick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.right.bottom.equalTo(_topView);
    }];
    _resultData = [NSMutableArray array];

}



#pragma mark UIPickView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if(self.resultData.count >0) return self.resultData.count;

    return  self.searchData.count;
}

#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (self.resultData.count > 0) {
        return  self.resultData[row];
    }
    return self.searchData[row] ;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{



//    self.row = row;
    [self dissMiss:row];
}

-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:0.4 animations:^{
        _topView.mj_y = 0;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [_searchView becomeFirstResponder];
    }];
}

-(void)dissMiss:(NSInteger)row{


        if (self.didSelectRow) {
            if (self.resultData.count>0) {
                self.didSelectRow(self.resultData[row]);
            }else{
                self.didSelectRow(self.searchData[row]);
            }

        }




    [UIView animateWithDuration:0.4 animations:^{
        _topView.mj_y = -64;
        self.alpha = 0;
        [_searchView resignFirstResponder];
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}

-(void)dissMiss{


    if (self.didSelectRow) {
        self.didSelectRow(@"-1");
    }

    [UIView animateWithDuration:0.4 animations:^{
        _topView.mj_y = -64;
        self.alpha = 0;
        [_searchView resignFirstResponder];
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}

-(void)upPartView:(NSMutableArray *)data{
    self.searchData = [data mutableCopy];
    [self.searchPick reloadAllComponents];

}

-(void)searchData:(UITextField *)search{

    if (self.resultData.count>0) {
        [self.resultData removeAllObjects];
    }

    for (NSString * part in self.searchData) {
        if ([part.lowercaseString rangeOfString:search.text.lowercaseString].location != NSNotFound) {

            [self.resultData addObject:part];
        }
    }

    [self.searchPick reloadAllComponents];

}

-(NSMutableArray *)searchData{
    if (!_searchData) {
        _searchData = [NSMutableArray array];

        for (int i = 0; i< 30; i++) {
            [_searchData addObject:[NSString stringWithFormat:@"滤水器内芯 (123%d)",i]];
        }
    }
    return _searchData;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
