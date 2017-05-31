//
//  PickDateView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/20.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickDateView.h"
#import "NSDate+Extension.h"
#import "UIView+MJExtension.h"
#import "UIView+Controller.h"
#import "PickingVC.h"
#import "PickingCell.h"
#import "PickingModel.h"
#import "PickingViewModel.h"
#import "UIView+Toast.h"
@interface PickDateView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    BOOL canTouch;
    CGFloat beginContentY;
    CGFloat endContentY;
    int selectDate;
    NSString * start_date;
    NSString * end_date;
}
@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UIButton * startBtn;
@property (nonatomic , strong) UIButton * endBtn;
@property (nonatomic , strong) UIButton * screenBtn;

@property (nonatomic , strong) UIView * bottomView;
@property (nonatomic , strong) UIButton * cancel;
@property (nonatomic , strong) UIButton * sure;
@property (nonatomic , strong) UIDatePicker * pick;

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * screenArray;

@property (nonatomic , copy) void(^clickBtn)(NSString *,NSString *,NSInteger);

@end
@implementation PickDateView
static NSString * identifier = @"PickingDateCell" ;

-(instancetype)initWithScreenDate:(void(^)(NSString * , NSString *, NSInteger))screen{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self setupDefaultView];
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        selectDate = 0;

        if (screen) {
            self.clickBtn = ^(NSString * state,NSString * end,NSInteger index){
                screen(state,end,index);
            };
        }
    }
    return self;
}

-(void)setupDefaultView{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];

    [self addSubview:self.tableView];

    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = text_Color3;
    [self addSubview:_bottomView];

    _topView.frame = CGRectMake(0, -64, kScreen_width, 64);
    _bottomView.frame = CGRectMake(0, kScreen_height, kScreen_width, 250);



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
        [btn addTarget:self action:@selector(PickDateClickAction:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    };

    start_date = [[NSDate dateYesterday] stringWithFormat:@"yyyy-MM-dd"];
    [self.topView addSubview:self.startBtn = creatBtn(start_date,back_Color,text_Color2,123)];
    end_date = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
    [self.topView addSubview:self.endBtn = creatBtn(end_date,back_Color,text_Color2,124)];
    [self.topView addSubview:self.screenBtn = creatBtn(@"筛选",nil,text_Color2,125)];

    UIView * line = [UIView new];
    line.backgroundColor = line_Color;
    [self.topView addSubview:line];

    [self.bottomView addSubview:self.cancel = creatBtn(@"取消",nil,[UIColor blueColor],126)];
    [self.bottomView addSubview:self.sure = creatBtn(@"确定",nil,[UIColor blueColor],127)];

    UILabel * promit = [UILabel new];
    promit.text = @"请选择日期";
    [self.bottomView addSubview:promit];

    self.pick = [UIDatePicker new];
    self.pick.backgroundColor = [UIColor whiteColor];
    self.pick.datePickerMode = UIDatePickerModeDate;
    [self.pick setMaximumDate:[NSDate date]];
    [self.bottomView addSubview:self.pick];


    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(8);
        make.bottom.equalTo(self.topView).offset(-4);
        make.right.equalTo(line.mas_left).offset(-2);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(_startBtn);
        make.right.equalTo(_endBtn.mas_left).offset(-2);
    }];

    [_endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_startBtn);
        make.width.equalTo(_startBtn);
        make.right.equalTo(_screenBtn.mas_left);
    }];

    [_screenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(66);
        make.centerY.equalTo(_startBtn);
        make.right.equalTo(_topView);
    }];

    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView).offset(8);
        make.height.mas_equalTo(40);
    }];

    [promit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cancel);
        make.centerX.equalTo(_bottomView);
    }];

    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cancel);
        make.right.equalTo(_bottomView).offset(-8);
    }];

    [_pick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bottomView);
        make.top.equalTo(_cancel.mas_bottom);
    }];
}


-(void)PickDateClickAction:(UIButton *)sender{
    switch (sender.tag - 123) {
        case 0:
        {
            selectDate = 0;

            [UIView animateWithDuration:0.4 animations:^{
                _bottomView.mj_y = kScreen_height -250;

            } ];
        }
            break;
        case 1:
        {

            selectDate = 1;

            [UIView animateWithDuration:0.4 animations:^{
                _bottomView.mj_y = kScreen_height - 250;

            } ];
        }
            break;
        case 2:
        {

            NSDate * start = [NSDate date:start_date WithFormat:@"yyyy-MM-dd"];
            NSDate * end  = [NSDate date:end_date WithFormat:@"yyyy-MM-dd"];
            if ([start isLaterThanDate:end]) {
                [self makeToast:@"请输入合理的区间" duration:0.5 position:CSToastPositionCenter];
                return;
            }

            PickingViewModel * model = [[PickingViewModel alloc] init];
            [model setBlockWithReturnBlock:^(id returnValue) {
                self.screenArray = returnValue;

                CGFloat heigh = 64.0;
                for (int i = 0; i<self.screenArray.count; i++) {
                    PickingModel * model = self.screenArray[i];
                    heigh+=model.height;
                }

                if (heigh>=kScreen_height - 10) {
                    self.backgroundColor = back_Color;
                }else{
                    self.backgroundColor = RGBA(0, 0, 0, 0.4);
                }
                [self.tableView reloadData];
            } WithErrorBlock:^(id errorCode) {
                
            }];
            
            [model fetchPickingList:1];




            [UIView animateWithDuration:0.4 animations:^{
                _bottomView.mj_y = kScreen_height ;

            } ];
        }
            break;
        case 3:
        {

            [self dismiss:0.4];
        }
            break;
        case 4:
        {
            [self upTextfrom:selectDate];
        }
            break;

        default:
            break;
    }
};

-(void)upTextfrom:(int)select{

    NSDate * date = self.pick.date;

    if (select == 0) {
        selectDate = 1;
        start_date = [date stringWithFormat:@"yyyy-MM-dd"];
        [_startBtn setTitle:start_date forState:UIControlStateNormal];
    }else{
         selectDate = 0;
        end_date = [date stringWithFormat:@"yyyy-MM-dd"];
        [_endBtn setTitle:end_date forState:UIControlStateNormal];
    }

    [UIView animateWithDuration:0.4 animations:^{
        _bottomView.mj_y = kScreen_height ;

    } ];
}

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    [[self viewController] setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.4 animations:^{
        _topView.mj_y = 0;
        _bottomView.mj_y = kScreen_height - 250;

    } completion:^(BOOL finished) {
        canTouch = YES;
    }];
}

-(void)dismiss:(NSTimeInterval)duration{

    if (!duration) {
        duration = 0.3;
    }
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
        _topView.mj_y = -64;
        _bottomView.mj_y = kScreen_height ;
    } completion:^(BOOL finished) {
        if (self.clickBtn) {
            _clickBtn(@"",@"",0);
        }
        [self removeFromSuperview];
    }];
}


#pragma mark UITapGestureRecognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{



    if (!canTouch) {
        return NO;
    }

//    CGPoint point =  [gestureRecognizer locationInView:self];
    CGPoint y = [touch locationInView:self];

    CGFloat height = 64.0f;

    for (int i = 0 ; i<self.screenArray.count; i++) {
        if (height>kScreen_height) {
            height= kScreen_height ;
            break ;
        }
        PickingModel * model = self.screenArray[i];
        height +=model.height;
    }

    if (y.y <height) {
        return NO;
    }

    return YES;

}

#pragma mark UITableViewDelegate && UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.screenArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[PickingCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    cell.pickModel = self.screenArray[indexPath.row];
//    cell.isLastCell = self.screenArray.count - 1 == indexPath.row ? YES : NO;

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PickingModel * pick = self.screenArray[indexPath.row];
    if (self.didSelectCell) {
        _didSelectCell(pick.pickId);
    }
    [self dismiss:0.2];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PickingModel * pick = self.screenArray[indexPath.row];


    return pick.height;
}



// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //获取开始位置
    beginContentY = scrollView.contentOffset.y;
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //获取结束位置
    endContentY = scrollView.contentOffset.y;
    if(endContentY-beginContentY > 20)
    {
        if (_bottomView.frame.origin.y < kScreen_height) {
            [UIView animateWithDuration:0.25 animations:^{
                _bottomView.mj_y = kScreen_height;
            }];
        }


    }

}
#pragma mark - Getters

/**
 *  懒加载
 *
 */

- (UITableView * )tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_width, kScreen_height - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionFooterHeight = 0.01f;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[PickingCell class] forCellReuseIdentifier:identifier];
//        _tableView.alpha = 0.5;
        _tableView.backgroundColor = RGBA(0, 0, 0, 0.3);
//        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.estimatedRowHeight = 110;
        // 5.设置分割线样式
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _screenArray = [NSMutableArray arrayWithCapacity:0];
    }

    return _tableView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
