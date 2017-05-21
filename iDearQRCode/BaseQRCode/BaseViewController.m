//
//  BaseViewController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/15.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDelegate , UITableViewDataSource>


@end

@implementation BaseViewController
    static NSString * identifier = @"UITableViewCell" ;
- (void)viewDidLoad {
    [super viewDidLoad];

//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Getters

/**
 *  懒加载
 *
 */

- (UITableView * )tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        // 4.设置我们分割线颜色(clearColor相当于取消系统分割线)
        //    self.tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#eff4f4"];
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
