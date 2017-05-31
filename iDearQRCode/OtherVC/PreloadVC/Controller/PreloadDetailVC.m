//
//  PreloadDetailVC.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadDetailVC.h"
#import "PreloadDetailCell.h"
#import "PreloadDetailView.h"
#import "PrereloadCellModel.h"
#import "NewPreloadVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface PreloadDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView * backView;
//@property (nonatomic , strong) UITableView * currentView;

@end

@implementation PreloadDetailVC

static NSString * identifier = @"PreloadDetailCell" ;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"预装";
    [self setupRightItem:@"添加"];
    [self setupTableView];
    // Do any additional setup after loading the view.
}

-(void)change{

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.fd_interactivePopDisabled = NO;
}
-(void)setupTableView{
    _backView = [UIView new];
//    _backView.layer.cornerRadius = 5;
//    _backView.layer.masksToBounds = YES;
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    [_backView addSubview:self.tableView];

    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.bottom.equalTo(self.view);
        make.right.equalTo(self.view).offset(-10);;
    }];
    [self.tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(_backView);

    }];

//    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 0) {
        return 2;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [UIView new];
    }
    PreloadDetailView * view = [[PreloadDetailView alloc] init];
    if (section == 1) {
        view.isFirst = YES;
    }
    [view uploadDetailHeadView:@[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3219125739,1362099777&fm=23&gp=0.jpg",@"测试",@"九把刀",@"无用"]];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 2) {
        UIView * foot = [UIView new];
        // 获取一条曲线。曲线路径为(0,0,96,50).圆角位置为右上和右下，圆角大小为25
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreen_width - 20, 20) byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(5, 5)];

        // 初始化一个CAShapeLayer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, kScreen_width - 20, 20);
        // 将曲线路径设置为layer的路径
        maskLayer.path = path.CGPath;

        // 设置控件的mask为CAShapeLayer
        foot.layer.mask = maskLayer;

        foot.backgroundColor = [UIColor whiteColor];
        UIView * line = [UIView new];
        line.frame =CGRectMake(0, 0, _backView.frame.size.width, 0.6);
        line.backgroundColor = line_Color;
        [foot addSubview:line];

        UILabel * label = [UILabel new];
        label.frame = CGRectMake(0, 1, kScreen_width-20-6, 20);
        label.text = @"共 14 件";
        label.textAlignment = NSTextAlignmentRight;
        [foot addSubview:label];

        return foot;
    }
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PreloadDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shouldMove = indexPath.row == 0 ? YES : NO;
    cell.data = @[@[@"滤水器",@"滤水器",@"滤水器"],@[@"1",@"1",@"1"]];

    WeakObj(self);
    cell.didCopyHandle = ^(NSArray * data){

        NewPreloadVC * new = [[NewPreloadVC alloc] init];
        [selfWeak.navigationController pushViewController:new animated:YES];
    };
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 75;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 2) {
        return 20;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 10;
    if (section == 1) {
        return 50;
    }

    return 40;
}



//#pragma mark - Getters
//
///**
// *  懒加载
// *
// */
//
//- (UITableView * )tableView{
//    if (!_tableView){
//        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableFooterView = [UIView new];
//        // 4.设置我们分割线颜色(clearColor相当于取消系统分割线)
//        //    self.tableView.separatorColor = [UIColor clearColor];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
//        _tableView.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
//        self.tableView.emptyDataSetSource = self;
//        self.tableView.emptyDataSetDelegate = self;
//        //        self.tableView.sectionFooterHeight = 0.01f;
//        self.tableView.showsVerticalScrollIndicator = NO;
//        // 5.设置分割线样式
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//
//    return _tableView;
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
