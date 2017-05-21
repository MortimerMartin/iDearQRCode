//
//  PickingFootView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/18.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickingFootView.h"
#import "UIView+MJExtension.h"
#import "UIView+Controller.h"
@interface PickingFootView ()

@property (nonatomic , strong) UIButton * deleteBtn;
//@property (nonatomic , strong) UIImageView * leftImage;
//@property (nonatomic , strong) UILabel * leftLabel;

@property (nonatomic , strong) UIButton * selectAllBtn;

@property (nonatomic , strong) UIButton * combineBtn;

@property (nonatomic , strong) UIView * combineView;

@end
@implementation PickingFootView
-(instancetype)initWithPickAction:(void(^)(PickModelType ))pick{
    if (self = [super init]) {
        self.frame = CGRectMake(0, kScreen_height, kScreen_width, 60);
        self.backgroundColor = [UIColor whiteColor];
        [self setupFootView];
        if (pick) {
            self.pickAction = ^(PickModelType type){
                pick(type);
            };
        }
    }
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
//        [self setupFootView];
//    }
//
//    return self;
//}

-(void)setupFootView{

    UIButton *  (^creatBtn)(NSString * ,NSString *) = ^(NSString * normal,NSString * hlight){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:hlight] forState:UIControlStateHighlighted];
        return btn;
    };


    [self addSubview:self.deleteBtn = creatBtn(@"btn_delete_Normal",@"btn_delete_Helight")];
    [self addSubview:self.combineBtn = creatBtn(@"btn_combine_Normal",@"btn_combine_Helight")];
    [self addSubview:self.selectAllBtn = creatBtn(@"btn_select_normal",@"btn_select_hlight")];
    [self.selectAllBtn setTitle:@"选择今天所有配件" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:text_Color1 forState:UIControlStateNormal];

    [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.combineBtn addTarget:self action:@selector(combineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn addTarget:self action:@selector(selectAllAction:) forControlEvents:UIControlEventTouchUpInside];


    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(4, 4, 4, 4));
    }];


    [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(8);
    }];

    [_combineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-8);
    }];
}


-(void)selectAllAction:(UIButton *)sender{

    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setImage:[UIImage imageNamed:@"btn_select_hlight"] forState:UIControlStateNormal];
        if (self.pickAction) {
            self.pickAction(PickModelSelectAll);
        }
    }else{
        [sender setImage:[UIImage imageNamed:@"btn_select_normal"] forState:UIControlStateNormal];
        if (self.pickAction) {
            self.pickAction(PickModelNormal);
        }
    }

}

-(void)combineAction:(UIButton *)sender{
    if (self.pickAction) {
        self.pickAction(PickModelCombine);
    }
}

-(void)deleteAction:(UIButton *)sender{
    
    if (self.pickAction) {
        self.pickAction(PickModelDelete);
    }
}

-(void)show:(PickModelType)type{

//    [self remove];
//    [[self viewController].view addSubview:self];
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (type == PickModelDelete) {
        self.deleteBtn.hidden = NO;
        self.selectAllBtn.hidden = YES;
        self.combineBtn.hidden = YES;
    }else if (type == PickModelCombine){
        self.deleteBtn.hidden = YES;
        self.selectAllBtn.hidden = NO;
        self.combineBtn.hidden = NO;
    }else{

    }

    [UIView animateWithDuration:0.5 animations:^{
        self.mj_y = kScreen_height - 124;
    }];
}



-(void)dismiss{
    _selectAllBtn.selected = NO;
    _deleteBtn.selected = NO;
    _combineBtn.selected = NO;
    [_selectAllBtn setImage:[UIImage imageNamed:@"btn_select_normal"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        self.mj_y = kScreen_height;
    }];

}

-(void)remove{
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
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
