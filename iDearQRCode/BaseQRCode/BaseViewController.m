//
//  BaseViewController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/15.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "BaseViewController.h"
#import "ResultDisplayController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "PickDetailVc.h"
#import "PreloadDetailVC.h"
@interface BaseViewController ()<UITableViewDelegate , UITableViewDataSource ,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,ResultDisplayControllerDelegate>

@property (nonatomic, assign) BOOL statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic , strong) ResultDisplayController * resultVC;

@end

@implementation BaseViewController
    static NSString * identifier = @"UITableViewCell" ;
- (void)viewDidLoad {
    [super viewDidLoad];

        [self setIsExtendLayout:NO];
    
        [self yd_removeNavgationBarLine];


        if ([self isKindOfClass:NSClassFromString(@"PickingVC")] || [self isKindOfClass:NSClassFromString(@"PreloadViewController")]) {
            [self setupSearchView];
        }


        self.view.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupSearchView{
    ResultDisplayController * result = [[ResultDisplayController alloc] init];
    result.delegate = self;
//    result.Classtitle = title;
    _resultVC = result;
    WeakObj(self);
    result.upPickStatusStytle=^{
        __strong typeof(self) strongSelf = selfWeak;
        [strongSelf changeStatusBarStyle:NO statusBarHidden:NO changeStatusBarAnimated:NO];
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

-(void)upResultViewData{
    [_resultVC.datas removeAllObjects];
    _resultVC.datas = [self.dataSource mutableCopy];
}

#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)setupRightItem:(NSString *)title{
    [self removeRightItem];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];

    UIView *containView = [[UIView alloc]initWithFrame:rightBtn.bounds];
    [containView addSubview:rightBtn];
    //直接方btn可能使按钮点击范围变大
    [rightBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightBtn] animated:YES];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containView];
}

-(void)removeRightItem{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}


-(void)change{


}

#pragma mark ResultDisplayDelegate
-(void)didSelectRow:(NSIndexPath *)indexPath{

    [self dismissViewControllerAnimated:NO completion:nil];
    if ([self isKindOfClass:NSClassFromString(@"PickingVC")] ) {

        PickDetailVc * detail = [[PickDetailVc alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }else if ([self isKindOfClass:NSClassFromString(@"PreloadViewController")]){
        PreloadDetailVC * detail = [[PreloadDetailVC alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
    }

}

#pragma mark DZNEmptyDataSetSource
//返回图片
//-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//
//}
//返回标题文字
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"没有数据";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName: text_Color1};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}
//空白区域点击事件
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{

}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{

    return back_Color;
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)yd_removeNavgationBarLine {

    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){

        NSArray *list=self.navigationController.navigationBar.subviews;

        for (id obj in list) {

            if ([obj isKindOfClass:[UIImageView class]]) {

                UIImageView *imageView=(UIImageView *)obj;

                NSArray *list2=imageView.subviews;

                for (id obj2 in list2) {

                    if ([obj2 isKindOfClass:[UIImageView class]]) {

                        UIImageView *imageView2=(UIImageView *)obj2;

                        imageView2.hidden=YES;

                    }
                }
            }
        }
    }
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {

    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {

    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(BOOL)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {

    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{

    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {

    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

#pragma mark - Getters

/**
 *  懒加载
 *
 */

- (UITableView * )tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] init];//WithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        // 4.设置我们分割线颜色(clearColor相当于取消系统分割线)
        //    self.tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
//        self.tableView.sectionFooterHeight = 0.01f;
        _tableView.showsVerticalScrollIndicator = NO;
        // 5.设置分割线样式
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    return _tableView;
    
}
#pragma mark - Getters

- (NSMutableArray * )dataSource{
    if (!_dataSource){
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - system

- (UIStatusBarStyle)preferredStatusBarStyle {

  return  self.statusBarStyle == YES ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {

    return self.statusBarHidden;
}

-(void)dealloc{
    _resultVC.delegate = nil;
    NSLog(@"%@",[self class]);
}
//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
