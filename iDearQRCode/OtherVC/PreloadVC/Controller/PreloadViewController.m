//
//  PreloadViewController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadViewController.h"
#import "PrereloadCell.h"
#import "PickingHeadView.h"
#import "PickingModel.h"
#import "PickingFootView.h"
#import "PickAlert.h"
#import "PreloadDetailVC.h"
#import "PickDateView.h"
#import "PrereloadCellModel.h"
#import "PreloadViewModel.h"
#import "MJRefresh.h"

@interface PreloadViewController ()<UITableViewDelegate , UITableViewDataSource ,pickingFootViewDelegate,PickingHeadViewDelegate>

@property (nonatomic , assign) UPViewtype  type;
@property (nonatomic , strong) PickingHeadView * pickHead;
@property (nonatomic , strong) PickingFootView * pickFoot;

@property (nonatomic , assign) NSInteger changeRightItem;

@property (nonatomic , strong) NSMutableArray * tempArray;
@property (nonatomic , strong) NSMutableArray * selectArray;
@property (nonatomic , strong) PickAlert * pickAlert;


@property (nonatomic , strong) PreloadViewModel * DataManager;

@property (nonatomic , assign) NSInteger page;
@end

@implementation PreloadViewController

static NSString * identifier = @"PrereloadCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"预装";
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.type = selectCellNormal;
    [self setupRightItem:@"添加"];
    [self setupPickingHeadView];
    [self setupUI];
    [self setupPickFootView];
    [self loadData];

    // Do any additional setup after loading the view.
}

-(void)setupUI{
    [self.view addSubview:self.tableView];
    [self.pickHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickHead.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];


    [self.tableView registerClass:[PrereloadCell class] forCellReuseIdentifier:identifier];

    self.type = selectCellNormal;//设置选择状态

    __unsafe_unretained UITableView *tableView = self.tableView;
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    //
    self.page = 1;
    
    
}

//空白区域点击事件
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self loadData];
}



-(void)loadData{
    __unsafe_unretained UITableView *tableView = self.tableView;
    if (self.type == selectCellNormal) {
        PreloadViewModel * model = [[PreloadViewModel alloc] init];


        [model setBlockWithReturnBlock:^(id returnValue) {


            self.dataSource = returnValue;
            [self.tempArray removeAllObjects];
            for (int i = 0; i < self.dataSource.count; i++) {
                [self.tempArray addObject:@{@"State" : @0}];
            }

            [self.tableView reloadData];
        } WithErrorBlock:^(id errorCode) {
            
        }];
        
        
        
        [model loadPreViewData:1];
    }else{
        [tableView.mj_header endRefreshing];
    }


}

-(void)loadMoreData{
    __unsafe_unretained UITableView *tableView = self.tableView;

    if (self.type == selectCellNormal) {
        PreloadViewModel * model = [[PreloadViewModel alloc] init];
        [model setBlockWithReturnBlock:^(id returnValue) {
            NSArray * tempArray = returnValue;
            [self.dataSource addObjectsFromArray:returnValue];
            for (int i = 0; i < tempArray.count; i++) {
                [self.tempArray addObject:@{@"State" : @0}];
            }
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            [tableView reloadData];
        } WithErrorBlock:^(id errorCode) {
            if (self.page<=1) {
                self.page = 1;
            }else{
                self.page--;
            }
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        }];

        self.page++;
        [model loadPreViewData:self.page];
    }else{
        // 结束刷新
        [tableView.mj_footer endRefreshing];

    }
}

#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrereloadCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[PrereloadCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    cell.preModel = self.dataSource[indexPath.row];

    cell.selectType = (selectCellType)[[self.tempArray[indexPath.row] valueForKey:@"state"] integerValue];

    cell.state = _changeRightItem;
    cell.index = indexPath.row;

    WeakObj(self);
    cell.selectCellAction = ^(PrereloadCellModel * model,BOOL select,selectCellType type,NSUInteger index){
        NSMutableArray * newArray = [selfWeak.tempArray mutableCopy];
        [newArray replaceObjectAtIndex:index withObject:@{@"state" : @(type)}];
        selfWeak.tempArray = newArray;
        if (select == YES) {
            [selfWeak.selectArray addObject:model.pickId];
        }else{
            [selfWeak deleteObjc:model.pickId];
        }

        if (self.type == PickModelCombine) {
            if (selfWeak.selectArray.count == selfWeak.dataSource.count) {
                selfWeak.pickFoot.selectAllState = YES;
            }else{
                selfWeak.pickFoot.selectAllState = NO;
            }

        }
        [selfWeak.tableView reloadData];

    };


    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == selectCellNormal) {
        PickingModel * pick = self.dataSource[indexPath.row];
        PreloadViewModel * View =[[PreloadViewModel alloc] init];
        [View pushDetailWithVC:self didSelectRowAtPickId:pick.pickId];
    }


}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    PickingModel * pick = self.dataSource[indexPath.row];
    return pick.height;
}




#pragma mark RightItemAction

-(void)change{
    switch (self.type) {
        case UPViewNormal:
        {

        }
            break;

        case UPViewDeleteType:
        {
            [self resetDefaultSeting];
        }
            break;
        case UPViewCombineType:
        {
            [self resetDefaultSeting];

        }
            break;

        default:
            break;
    }

}
#pragma mark 设置头视图以及各个功能

-(void)setupPickingHeadView{
    PickingHeadView * pick = [[PickingHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 40)];
    pick.delegate = self;
    [self.view addSubview:pick];
    _pickHead = pick;
}

#pragma mark PickingHeadViewDelegae
-(void)didClick:(UPViewtype)type WithSelect:(BOOL)select{
    switch (type) {
        case UPViewSearchType:
        {

            if (self.type == UPViewDeleteType || self.type == UPViewCombineType) {
                return ;
            }
            [self upResultViewData];
            [self changeStatusBarStyle:YES statusBarHidden:NO changeStatusBarAnimated:NO];
            [self presentViewController:self.searchView animated:YES completion:nil];
        }
            break;
        case UPViewScreenType:
        {
            if (self.type == UPViewDeleteType || self.type == UPViewCombineType) {
                return ;
            }

            [self changeStatusBarStyle:YES statusBarHidden:NO changeStatusBarAnimated:NO];


            PickDateView * date = [[PickDateView alloc] initWithScreenDate:^(NSString * state, NSString * end,NSInteger index) {
                switch (index) {
                    case 0:
                    {
                        [self changeStatusBarStyle:NO statusBarHidden:NO changeStatusBarAnimated:YES];
                    }
                        break;
                    case 1:
                    {

                    }
                        break;
                    default:
                        break;
                }
            }];
            date.didSelectCell = ^(NSString * pickId){
                PreloadDetailVC * detial = [[PreloadDetailVC alloc] init];
                [self.navigationController pushViewController:detial animated:YES];
            };
            [date show];

        }
            break;
        case UPViewDeleteType:
        {
            if (self.type == UPViewDeleteType || self.type == UPViewCombineType) {
                return ;
            }

            self.changeRightItem = 1;
            self.type = UPViewDeleteType;
            [self setupRightItem:@"取消"];
            [self setCellState:selectCellNormal];
            [self.pickFoot show:PickModelDelete];
            [self.tableView reloadData];
        }
            break;
        case UPViewCombineType:
        {
            if (self.type == UPViewCombineType || self.type == UPViewDeleteType ) {
                return ;
            }

            self.type = UPViewCombineType;
            [self setupRightItem:@"取消"];
            self.changeRightItem = 2;
            [self setCellState:selectCellNormal];
            [self.pickFoot show:PickModelCombine];
            [self.tableView reloadData];
        }
            break;

        case UPViewNormal:
        {
            [self setCellState:selectCellNormal];
            [self.pickFoot dismiss];
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }

}

#pragma mark 设置footView及各项功能

-(void)setupPickFootView{
    PickingFootView * pickFoot = [[PickingFootView alloc] initWithFrame:CGRectMake(0, kScreen_height, kScreen_width, 60)];
    pickFoot.delegate = self;
    [self.view addSubview:pickFoot];
    _pickFoot = pickFoot;
}
#pragma mark PickingFootViewDelegate

-(void)didHandelAction:(PickModelType)type{

    switch (type) {
        case PickModelNormal:
        {
            [self.selectArray removeAllObjects];
            [self setCellState:selectCellNormal];
            [self.tableView reloadData];
        }
            break;
        case PickModelDelete:
        {
            if (self.selectArray.count>0) {
                PickAlert * alert = [[PickAlert alloc] initWithPickTitle:[NSString stringWithFormat:@"是否确定删除这%ld项",self.selectArray.count] AlertAction:@[@"取消",@"确定"] Complete:^(NSInteger index) {
                    if (index == 1) {


                        for (int j = 0; j <self.selectArray.count; j++) {
                            for (int i = 0; i<self.dataSource.count; i++) {
                                PickingModel * pick = self.dataSource[i];
                                if ([pick.pickId isEqualToString:self.selectArray[j]]) {
                                    [self.dataSource removeObjectAtIndex:i];

                                }
                            }
                        }
                        [self resetDefaultSeting];



                    }
                }];

                [alert showAlert];
                _pickAlert = alert;
            }
        }
            break;
        case PickModelCombine:
        {
            if (self.selectArray.count>0) {
                PickAlert * alert = [[PickAlert alloc] initWithPickTitle:self.dataSource.count == self.selectArray.count ? [NSString stringWithFormat:@"是否确定合并全部%ld项",self.selectArray.count] : [NSString stringWithFormat:@"是否确定合并这%ld项",self.selectArray.count] AlertAction:@[@"取消",@"确定"] Complete:^(NSInteger index) {
                    if (index == 1) {


                        for (int j = 0; j <self.selectArray.count; j++) {
                            for (int i = 0; i<self.dataSource.count; i++) {
                                PickingModel * pick = self.dataSource[i];
                                if ([pick.pickId isEqualToString:self.selectArray[j]]) {
                                    [self.dataSource removeObjectAtIndex:i];

                                }
                            }
                        }
                        [self resetDefaultSeting];
                    }



                }];

                [alert showAlert];
                _pickAlert = alert;
            }
        }
            break;
        case PickModelSelectAll:
        {
            [self.selectArray removeAllObjects];
            for (int i = 0; i<self.dataSource.count; i++) {
                PickingModel * model = self.dataSource[i];
                [self.selectArray addObject:model.pickId];
            }
            [self setCellState:selectCellCombine];
            [self.tableView reloadData];
            
        }
            break;
        default:
            break;
    }
    
}



//设置cell的选中状态
-(void)setCellState:(selectCellType)type{
    NSMutableArray * newArray = [self.tempArray mutableCopy];
    for (int i = 0; i<self.dataSource.count; i++) {
        [newArray replaceObjectAtIndex:i withObject:@{@"state" : @(type)}];
    }
    self.tempArray = newArray;
}
//删除选中数组里面的取消的
-(void)deleteObjc:(NSString *)pickId{
    for (int i = 0; i< self.selectArray.count; i++) {
        if ([pickId isEqualToString:self.selectArray[i]]) {
            [self.selectArray removeObjectAtIndex:i];
            break;
        }
    }
}
#pragma mark - Getters
- (NSMutableArray * )tempArray{
    if (!_tempArray){
        _tempArray = [[NSMutableArray alloc] init];
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;

}

#pragma mark default

-(void)resetDefaultSeting{
    [self.selectArray removeAllObjects];
    self.changeRightItem = 0;
    self.type = selectCellNormal;
    [self setupRightItem:@"添加"];
    [self setCellState:selectCellNormal];
    [self.pickFoot dismiss];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_pickAlert remove];
    
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
