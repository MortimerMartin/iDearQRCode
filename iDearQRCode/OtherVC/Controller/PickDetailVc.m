//
//  PickDetailVc.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/20.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickDetailVc.h"
#import "PickDetailView.h"
#import "PickDetailFootView.h"
#import "QRCodeVC.h"
@interface PickDetailVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) PickDetailView * DetailView;
@property (nonatomic , strong) PickDetailFootView * DetailFootView;


@property (nonatomic , assign) CGFloat Headheigit;//headView高度
@property (nonatomic , assign) CGFloat FootHeight;


@end

@implementation PickDetailVc
   static NSString * identifier = @"UITableViewCell" ;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"领料";

    [self setupRightItem:@"添加"];

    [self setupDetailView];

    [self loadDetailData];
    
    // Do any additional setup after loading the view.
}


-(void)setupDetailView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

-(void)loadDetailData{

    NSArray *namesArray = @[@"老板",
                            @"经理",
                            @"总裁",
                            @"董事长",
                            @"其他"];

    NSArray *textArray = @[@"生产一组",
                           @"生产二组",
                           @"生产三组",
                           @"生产四组",
                           @"生产五组"
                           ];

    NSArray *commentsArray = @[@"2017-12-21",
                               @"2017-2-7",
                               @"2017-12-00",
                               @"2017-11-00",
                               @"2017-12-04",
                               @"2017-7-14",
                               @"2017-2-05"];

    NSArray *picImageNamesArray = @[ @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"http://file06.16sucai.com/2016/0303/567565d0e78a7e51b6c38f07e7be06ac.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084431319&di=6ee6bcce85550898fa42c8e86ace9f79&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F6b7f7a3c5ccbe9900094add1d8b5cbc8.jpg",
                                     @"http://file06.16sucai.com/2016/0303/3d9ef7096c8c540064f6c4eb8877a929.jpg",
                                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3219125739,1362099777&fm=23&gp=0.jpg"

                                     ];


    NSArray * Array1 = @[@"滤水器内芯（110224244）",
                               @"滤水器内芯 （33325523434）",
                               @"滤水器外壳 （33325523434）",
                               @"滤水器塑胶管 （33325523434）"];

    NSArray * Array2 = @[@"30000",
                               @"60000",
                               @"888",
                               @"666"];

    NSArray * Array3 = @[@"领料时间：2017-12-21",
                               @"领料时间：2017-2-7",
                               @"领料时间：2017-12-00",
                               @"领料时间：2017-11-00"];


    int count = arc4random_uniform(4);
    if (count == 0) {
        count = 1;
    }


    self.Headheigit = 20;
    self.FootHeight = 30;
    for (int i = 0; i<count; i++) {
        int nameIndex = arc4random_uniform(5);
        int doIndex = arc4random_uniform(5);
        int timeIndex = arc4random_uniform(7);
        int iconIndex = arc4random_uniform(6);


        int labelIndex = arc4random_uniform(4);


        self.Headheigit += 50;
        self.FootHeight += 10;

        NSMutableArray * tempArray = [NSMutableArray array];
        for (int j = 0; j < labelIndex; j++) {

            self.Headheigit += 40;
            

            [tempArray addObject:@[Array1[labelIndex],Array2[labelIndex],Array3[labelIndex]]];
        }


        NSArray * top = @[@[picImageNamesArray[iconIndex],namesArray[nameIndex],textArray[doIndex],commentsArray[timeIndex]],tempArray];

        self.Headheigit += 10;
        self.FootHeight += 10;

        [self.dataSource addObject:top];

    }



    [self.DetailView UPDetailView:self.dataSource];
    [self.tableView reloadData];


}

-(void)change{
    QRCodeVC * qrcode = [[QRCodeVC alloc] init];
    [self.navigationController pushViewController:qrcode animated:YES];
}

#pragma mark  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.DetailView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return self.DetailFootView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return _FootHeight ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return _Headheigit ;
}


#pragma mark - Getters

/**
 *  懒加载
 *
 */

- (PickDetailView * )DetailView{

    if (!_DetailView){

        _DetailView = [[PickDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, _Headheigit)];
        _DetailFootView = [[PickDetailFootView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, _FootHeight)];

    }

    return _DetailView;
    
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
