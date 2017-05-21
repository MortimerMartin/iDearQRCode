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

#import "PickingCell.h"
#import "PickingModel.h"

@interface PickDateView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    BOOL canTouch;
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

    [self.topView addSubview:self.startBtn = creatBtn([[NSDate dateYesterday] stringWithFormat:@"yyyy-MM-dd"],back_Color,text_Color2,123)];

    [self.topView addSubview:self.endBtn = creatBtn([[NSDate date] stringWithFormat:@"yyyy-MM-dd"],back_Color,text_Color2,124)];
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

        }
            break;
        case 1:
        {

        }
            break;
        case 2:
        {
            NSArray *namesArray = @[@"Mortimer",
                                    @"Martin",
                                    @"chaowei",
                                    @"leigai",
                                    @"Hello Kitty"];

            NSArray *textArray = @[@"马面",
                                   @"鹿角",
                                   @"蛇身",
                                   @"鱼鳞",
                                   @"牛脚"
                                   ];

            NSArray *commentsArray = @[@"2017-12-33",
                                       @"2017-12-30",
                                       @"2017-12-00",
                                       @"有意思",
                                       @"你瞅啥？",
                                       @"瞅你咋地？？？！！！",
                                       @"hello，看我",
                                       @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                                       @"人艰不拆",
                                       @"咯咯哒",
                                       @"呵呵~~~~~~~~",
                                       @"我勒个去，啥世道啊",
                                       @"真有意思啊你💢💢💢"];

            NSArray *picImageNamesArray = @[ @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                             @"http://file06.16sucai.com/2016/0303/567565d0e78a7e51b6c38f07e7be06ac.jpg",
                                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084431319&di=6ee6bcce85550898fa42c8e86ace9f79&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F6b7f7a3c5ccbe9900094add1d8b5cbc8.jpg",
                                             @"http://file06.16sucai.com/2016/0303/3d9ef7096c8c540064f6c4eb8877a929.jpg",
                                             @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3219125739,1362099777&fm=23&gp=0.jpg"
                                             
                                             ];

            int count = arc4random_uniform(4);
            [self.screenArray removeAllObjects];
            for (int i = 0; i< count; i++) {

                int nameIndex = arc4random_uniform(5);
                int doIndex = arc4random_uniform(5);
                int timeIndex = arc4random_uniform(13);
                int iconIndex = arc4random_uniform(6);
                int countIndex = arc4random_uniform(5);



                PickingModel * model = [PickingModel new];
                model.URL = picImageNamesArray[iconIndex];
                //        model.name = namesArray[nameIndex];
                model.doSometing = textArray[doIndex];
                model.join_time = commentsArray[timeIndex];
                model.count = countIndex;
                model.pickId = [NSString stringWithFormat:@"%d",i];

                model.height = 78 + countIndex * 24;
                model.name = [NSString stringWithFormat:@"%@___height:%f___count:%d____",namesArray[nameIndex],model.height,countIndex];
                [self.screenArray addObject:model];
            }
            [self.tableView reloadData];
            [UIView animateWithDuration:0.4 animations:^{
                _bottomView.mj_y = kScreen_height ;

            } ];
        }
            break;
        case 3:
        {
            if (self.clickBtn) {
                _clickBtn(@"",@"",0);
            }
            [self dismiss:0.4];
        }
            break;
        case 4:
        {

        }
            break;

        default:
            break;
    }
};

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[self viewController] setNeedsStatusBarAppearanceUpdate];
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
    cell.isLastCell = self.screenArray.count - 1 == indexPath.row ? YES : NO;

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
