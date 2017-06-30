//
//  SheetView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "SheetView.h"
#import "SheetViewCell.h"
#import "UIView+MJExtension.h"
@interface SheetView ()<UITableViewDelegate , UITableViewDataSource,UIGestureRecognizerDelegate,CAAnimationDelegate>

@property (nonatomic , copy) void(^clickCell)(NSInteger);
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSArray * menuArray;

@end
@implementation SheetView
 static NSString * identifier = @"menuCell" ;
-(instancetype)initWithMenuArray:(NSArray *)menu CompleteBlock:(void (^)(NSInteger  index))selectBlock{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 128, kScreen_width, kScreen_height-64);
        self.menuArray = menu;
        [self setupSheetViewUI];
        if (selectBlock) {
            self.clickCell = ^(NSInteger index){
                selectBlock(index);
            };
        }
    }
    return self;
}

-(void)setupSheetViewUI{

    //点击背景是否影藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];

    [self addSubview:self.tableView];
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);

        make.height.mas_equalTo(250);
    }];
}


#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SheetViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[SheetViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
    }
    cell.title = _menuArray[indexPath.row];
    cell.color = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
#pragma mark  UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    __weak typeof(self) weakSelf = self;
    if (_clickCell) {
        _clickCell(indexPath.row);
    }

    if (indexPath.row == 4) {
        [self dismiss];
    }else{
        [self remove];
    }


}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }
    return YES;
}
#pragma mark - Action
-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.mj_y = 64;
    }];
}

-(void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.mj_y = 128;
        self.backgroundColor = RGBA(0, 0, 0, 0);
//        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
           [self remove];
    }];
}

-(void)remove{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}


#pragma mark - CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self remove];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame ];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        // 4.设置我们分割线颜色(clearColor相当于取消系统分割线)
        //    self.tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SheetViewCell class] forCellReuseIdentifier:identifier];
        _tableView.backgroundColor = [UIColor whiteColor];

        // 5.设置分割线样式
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;


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
