//
//  NewPreloadVC.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "NewPreloadVC.h"
#import "PreloadNewView.h"
#import "NewPartCell.h"
#import "NewPartNumberView.h"
#import "PartSearchView.h"
@interface NewPreloadVC ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) NewPartNumberView * partNumber;

@property (nonatomic , strong) PreloadNewView * preloadView;
@property (nonatomic , strong) UIView * head;
@property (nonatomic , strong) UITableView * partTableView;
@property (nonatomic , strong) NSMutableArray * partdata;
@property (nonatomic , assign) NSInteger indexrow;


@end

@implementation NewPreloadVC

static NSString *  identifier = @"NewPartCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新增预装";
    [self setupRightItem:@"保存"];
    [self setupNewPreloadView];
    [self setupTableHeadView];
    [self setupTableView];

    self.indexrow = 0;
    // Do any additional setup after loading the view.
}



-(void)setupTableView{
    _partTableView = [[UITableView alloc] init];
    _partTableView.delegate = self;
    _partTableView.dataSource = self;
    _partTableView.tableFooterView = [UIView new];
    _partTableView.rowHeight = 50;
//    _partTableView.estimatedRowHeight = 50;
    _partTableView.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
    _partTableView.showsVerticalScrollIndicator = NO;
    // 5.设置分割线样式
    _partTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.partTableView];
    [self.partTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_head.mas_bottom);
    }];
    [self.partTableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.partdata.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewPartCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.partdata.count>0) {
        cell.partName = [NSString stringWithFormat:@"%@",[self.partdata[indexPath.row] valueForKey:@"partname"]];
        cell.number = [NSString stringWithFormat:@"%ld",[[self.partdata[indexPath.row] valueForKey:@"partnumber"]integerValue]];
        cell.index = indexPath.row;
        if (self.partdata.count - 1 == indexPath.row) {
            cell.isLastCell = YES;
        }else if (self.partdata.count == 1){
            cell.isLastCell = YES;
        }else{
            cell.isLastCell = NO;
        }
    }

    WeakObj(self);
    cell.didSelectHandle = ^(NSInteger index , NSInteger row){

        if (index == 11) {
            [selfWeak deleteCell:row];
        }else{
            self.indexrow = row;
            [selfWeak selectNumber];
        }
    };

    return cell;
}


-(void)setupNewPreloadView{
    PreloadNewView * view = [[PreloadNewView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 300)];
//    view.nameText.text = self.partname;
//    view.numberText.text = self.partnumber;
//    view.countText.text = self.partcount;
    [self.view addSubview:view];
    _preloadView = view;
    [_preloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}



-(void)change{

    NSLog(@"%@\n,%@\n%@\n",self.preloadView.numberText.text,self.preloadView.nameText.text,self.preloadView.countText.text);
}



-(void)setupTableHeadView{

    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    _head = view;

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
        make.top.equalTo(_preloadView.mas_bottom).offset(10);
    }];

    UILabel * head = [UILabel new];
    head.text = @"零件 :";
    head.textColor = topView_Color;
    head.font = kFont_14;
    [view addSubview:head];

    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(6);
        make.centerY.equalTo(view);
    }];

    UIButton * add = [UIButton buttonWithType:UIButtonTypeCustom];
    [add setImage:[UIImage imageNamed:@"btn_addCell"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addCell) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:add];

    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-6);
        make.centerY.equalTo(view);
    }];
    UIView * line = [UIView new];
    line.backgroundColor = line_Color;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(0.6);
    }];
}




-(void)selectNumber{

    WeakObj(self);
    NewPartNumberView * number = [[NewPartNumberView alloc] initWithComplete:^(NSInteger index) {

        NSMutableArray * newArray = [self.partdata mutableCopy];
        NSString * partname = [self.partdata[self.indexrow] valueForKey:@"partname"];
        [newArray replaceObjectAtIndex:self.indexrow withObject:@{@"partname" : partname, @"partnumber" : @(index)}];
        self.partdata = newArray;
        [selfWeak.partTableView reloadData];
    }];

    [number show];
    _partNumber = number;
}


-(void)addCell{


    
    [self changeStatusBarStyle:YES statusBarHidden:NO changeStatusBarAnimated:NO];
    WeakObj(self);
    PartSearchView * search = [[PartSearchView alloc] initWithPartSearchView:^(NSString *part) {
                [selfWeak changeStatusBarStyle:NO statusBarHidden:NO changeStatusBarAnimated:NO];
        if (part && ![part isEqualToString:@"-1"]) {

            [selfWeak.partTableView beginUpdates];
            [selfWeak.partdata addObject:@{@"partname" : part ,@"partnumber" : @0}];
            NSIndexPath * indexPath ;
            if (selfWeak.partdata.count == 0) {
                indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [selfWeak.partTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }else{
                indexPath = [NSIndexPath indexPathForRow:self.partdata.count - 1 inSection:0];
                [selfWeak.partTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }

            [selfWeak.partTableView endUpdates];
            [selfWeak.partTableView reloadData];
            [selfWeak.partTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }

    }];

    [search show];



}

-(void)deleteCell:(NSInteger)index{
     [self.partTableView beginUpdates];
    [self.partdata removeObjectAtIndex:index];
    [self.partTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    [self.partTableView endUpdates];
    [self.partTableView reloadData];
}

-(NSMutableArray *)partdata{

    if (!_partdata) {
        _partdata = [NSMutableArray array];
    }
    return _partdata;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_partNumber removeFromSuperview];
}
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
