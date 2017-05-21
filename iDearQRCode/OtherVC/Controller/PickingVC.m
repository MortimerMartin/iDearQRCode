//
//  PickingVC.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/17.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickingVC.h"
#import "PickingCell.h"
#import "PickingHeadView.h"
#import "PickingModel.h"
#import "PickingFootView.h"
#import "PickAlert.h"
#import "ResultDisplayController.h"
#import "PickDateView.h"
#import "PickDetailVc.h"
#import "PickingViewModel.h"
@interface PickingVC ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , assign) UPViewtype  type;
@property (nonatomic , strong) PickingHeadView * pickHead;
@property (nonatomic , strong) PickingFootView * pickFoot;

@property (nonatomic , assign) NSInteger changeRightItem;

@property (nonatomic , strong) NSMutableArray * tempArray;
@property (nonatomic , strong) NSMutableArray * selectArray;
@property (nonatomic , strong) PickAlert * pickAlert;



@end

@implementation PickingVC
static NSString * identifier = @"PickingCell" ;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"领料";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.type = selectCellNormal;
    [self setupRightItem:@"添加"];
    [self setupHeadView];
    [self setupUI];
    [self loadViewData];
    [self setupFootView];
    [self setupSearchView];
    // Do any additional setup after loading the view.
}

-(void)setupSearchView{
    ResultDisplayController * result = [[ResultDisplayController alloc] init];
    WeakObj(self);
    result.upPickStatusStytle=^{
        selfWeak.statusStytle = NO;
        [selfWeak setNeedsStatusBarAppearanceUpdate];
    };
    self.searchView = [[UISearchController alloc] initWithSearchResultsController:result];
    self.searchView.searchResultsUpdater = result;
    result.datas = [self.dataSource mutableCopy];

    self.searchView.hidesNavigationBarDuringPresentation = NO;
    self.searchView.searchBar.placeholder = @"搜索";

    self.searchView.searchBar.tintColor = text_Color1;
    self.searchView.searchBar.barTintColor = [UIColor whiteColor];

    UIView *searchTextField = nil;

    if (iOS7) {
        searchTextField = [[[self.searchView.searchBar.subviews firstObject] subviews] lastObject];
    }else{
        for (UIView * subView in self.searchView.searchBar.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                        searchTextField = subView;
            }
        }
    }
    searchTextField.backgroundColor = back_Color;

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
//    self.pickHead.sd_layout.topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(40);
//    self.tableView.sd_layout.topSpaceToView(self.pickHead,0).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    self.tableView.sectionFooterHeight = 0.01f;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 110;
    [self.tableView registerClass:[PickingCell class] forCellReuseIdentifier:identifier];



    
}

-(void)loadViewData{

    self.type = selectCellNormal;//设置选择状态

    PickingViewModel * model = [[PickingViewModel alloc] init];
    [model setBlockWithReturnBlock:^(id returnValue) {
        self.dataSource = returnValue;
        for (int i = 0; i < self.dataSource.count; i++) {
             [self.tempArray addObject:@{@"State" : @0}];
        }
        [self.tableView reloadData];
    } WithErrorBlock:^(id errorCode) {

    }];

    [model fetchPickingList];
}

#pragma mark  UITableViewDataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[PickingCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


        cell.pickModel = self.dataSource[indexPath.row];

        cell.selectType = (selectCellType)[[self.tempArray[indexPath.row] valueForKey:@"state"] integerValue];

        cell.state = _changeRightItem;
        cell.index = indexPath.row;
        cell.isLastCell = (indexPath.row == self.dataSource.count - 1) ? YES : NO;
        WeakObj(self);
        cell.selectCellAction = ^(PickingModel * model,BOOL select,selectCellType type,NSUInteger index){
            NSMutableArray * newArray = [selfWeak.tempArray mutableCopy];
            [newArray replaceObjectAtIndex:index withObject:@{@"state" : @(type)}];
            selfWeak.tempArray = newArray;
            if (select == YES) {
                [selfWeak.selectArray addObject:model.pickId];
            }else{
                [selfWeak deleteObjc:model.pickId];
            }
            
            
            [selfWeak.tableView reloadData];
            
        };


    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PickingModel * pick = self.dataSource[indexPath.row];
    PickingViewModel * View =[[PickingViewModel alloc] init];
    [View pushDetailWithVC:self didSelectRowAtPickId:pick.pickId];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PickingModel * pick = self.dataSource[indexPath.row];

    return pick.height;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}

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

-(void)setupHeadView{

        PickingHeadView * pick = [[PickingHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 40)];
        [self.view addSubview:pick];
        __weak typeof(self.tableView) weakSelfTableView = self.tableView;
        pick.didClickHandler = ^(UPViewtype type,BOOL isSelect){
            switch (type) {
                case UPViewSearchType:
                {

                    if (self.type == UPViewDeleteType || self.type == UPViewCombineType) {
                        return ;
                    }
                    self.statusStytle = YES;
                    [self setNeedsStatusBarAppearanceUpdate];
                    [self presentViewController:self.searchView animated:YES completion:^{

                    }];
                }
                    break;
                case UPViewScreenType:
                {
                    if (self.type == UPViewDeleteType || self.type == UPViewCombineType) {
                        return ;
                    }
                    self.statusStytle = YES;
                    [self setNeedsStatusBarAppearanceUpdate];
                    WeakObj(self);
                    PickDateView * date = [[PickDateView alloc] initWithScreenDate:^(NSString * state, NSString * end,NSInteger index) {
                        switch (index) {
                            case 0:
                                {   selfWeak.statusStytle = NO;
                                    [selfWeak setNeedsStatusBarAppearanceUpdate];
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
                        PickDetailVc * detial = [[PickDetailVc alloc] init];
                        [selfWeak.navigationController pushViewController:detial animated:YES];
                    };
                    [date show];

                }
                    break;
                case UPViewDeleteType:
                {
                    if (self.type == UPViewDeleteType) {
                        return ;
                    }

                    self.changeRightItem = 1;
                    self.type = UPViewDeleteType;
                    [self setupRightItem:@"取消"];
                    [self setCellState:selectCellNormal];
                    [_pickFoot show:PickModelDelete];
                    [weakSelfTableView reloadData];
                }
                    break;
                case UPViewCombineType:
                {
                    if (self.type == UPViewCombineType) {
                        return ;
                    }

                    self.type = UPViewCombineType;
                     [self setupRightItem:@"取消"];
                    self.changeRightItem = 2;
                    [self setCellState:selectCellNormal];
                     [_pickFoot show:PickModelCombine];
                    [weakSelfTableView reloadData];
                }
                    break;

                case UPViewNormal:
                {
                    [self setCellState:selectCellNormal];
                    [_pickFoot dismiss];
                    [weakSelfTableView reloadData];
                }
                    break;
                default:
                    break;
            }

        };
    _pickHead = pick;

}

-(void)setupFootView{

//    WeakObj(self);
    PickingFootView * pick = [[PickingFootView alloc] initWithPickAction:^(PickModelType type) {
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
                PickAlert * alert = [[PickAlert alloc] initWithPickTitle:[NSString stringWithFormat:@"是否确定删除这%ld项",self.selectArray.count] AlertAction:@[@"取消",@"确定"] Complete:^(NSInteger index) {
                    if (index == 1) {

                        if (self.selectArray.count>0) {
                            for (int j = 0; j <self.selectArray.count; j++) {
                                for (int i = 0; i<self.dataSource.count; i++) {
                                    PickingModel * pick = self.dataSource[i];
                                    if ([pick.pickId isEqualToString:self.selectArray[j]]) {
                                        [self.dataSource removeObjectAtIndex:i];
                                        NSLog(@"%d",j);
                                    }
                                }
                            }
                            [self resetDefaultSeting];
                        }


                    }
                }];

                [alert showAlert];
                _pickAlert = alert;
            }
                break;
            case PickModelCombine:
            {
                PickAlert * alert = [[PickAlert alloc] initWithPickTitle:self.dataSource.count == self.selectArray.count ? [NSString stringWithFormat:@"是否确定合并全部%ld项",self.selectArray.count] : [NSString stringWithFormat:@"是否确定合并这%ld项",self.selectArray.count] AlertAction:@[@"取消",@"确定"] Complete:^(NSInteger index) {
                    if (index == 1) {

                        if (self.selectArray.count>0) {
                            for (int j = 0; j <self.selectArray.count; j++) {
                                for (int i = 0; i<self.dataSource.count; i++) {
                                    PickingModel * pick = self.dataSource[i];
                                    if ([pick.pickId isEqualToString:self.selectArray[j]]) {
                                        [self.dataSource removeObjectAtIndex:i];
                                        NSLog(@"%d",j);
                                    }
                                }
                            }
                            [self resetDefaultSeting];
                        }


                    }
                }];

                [alert showAlert];
                _pickAlert = alert;
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
    }];
    [self.view addSubview:pick];
    _pickFoot = pick;

}



-(void)setCellState:(selectCellType)type{
    NSMutableArray * newArray = [self.tempArray mutableCopy];
    for (int i = 0; i<self.dataSource.count; i++) {
         [newArray replaceObjectAtIndex:i withObject:@{@"state" : @(type)}];
    }
    self.tempArray = newArray;
}

-(void)deleteObjc:(NSString *)pickId{
    for (int i = 0; i< self.selectArray.count; i++) {
        if ([pickId isEqualToString:self.selectArray[i]]) {
            [self.selectArray removeObjectAtIndex:i];
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return _statusStytle == YES ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
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
