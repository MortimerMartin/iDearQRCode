//
//  QRCViewController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/15.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRCViewController.h"
#import "SheetView.h"
#import "personViewController.h"
#import "UIImage+Normalimage.h"

#import "PickingVC.h"
@interface QRCViewController ()
{
   UIView *_autoMarginViews;
}
@property (nonatomic , strong) SheetView * sheetView;

@end

@implementation QRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationController.navigationBar.translucent = NO;
    //设置左上角Item
    [self setLeftNavigationItem];
    [self setupAutoMarginViewsWithCount:4 itemWidth:kScreen_width/2];
    [self setupAddBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置底部添加按钮
-(void)setupAddBtn{
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"add_Btn"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(showFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];

    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-30);
        make.height.width.mas_equalTo(60);
        make.centerX.equalTo(self.view);
    }];

}

// 设置固定宽度自动间距子view
-(void)setupAutoMarginViewsWithCount:(NSInteger)count itemWidth:(CGFloat)itemWidth{
    _autoMarginViews = [UIView new];
    _autoMarginViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_autoMarginViews];

    [_autoMarginViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(280);
    }];

//    NSMutableArray * temp = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake((i == 0) | (i == 2)? 0 : itemWidth , i<2 ? 0 : 140  , itemWidth, 140)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",i]] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage creatImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage creatImageWithColor:[UIColor colorWithHexString:@"#fafafa"]] forState:UIControlStateHighlighted];
        [btn setTitle:i == 0 ? @"领料": i == 1  ? @"预装" : i == 2 ? @"总装":@"打包" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor colorWithHexString:@"#565c5c"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height-15, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height + 15, -btn.currentImage.size.width, 0, 0)];
        btn.tag = 207 + i;
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_autoMarginViews addSubview:btn];

    }


}

-(void)setLeftNavigationItem{
    //左上角的返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [backButton setImage:[UIImage imageNamed:@"btn_list"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
//    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); //这里微调返回键的位置
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.title = @"首页";

}

-(void)menu{
    [_sheetView remove];
    personViewController * person = [[personViewController alloc] init];
    [self.navigationController pushViewController:person animated:YES];
}

-(void)clickAction:(UIButton *)sender{
    switch (sender.tag - 207) {
        case 0:
        {
            PickingVC * pick = [[PickingVC alloc] init];
            [self.navigationController pushViewController:pick animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"1");
        }
            break;
        case 2:
        {
            NSLog(@"2");
        }
            break;
        case 3:
        {
            NSLog(@"3");
        }
            break;

        default:
            break;
    }

}

-(void)showFunction{
    SheetView * sheet = [[SheetView alloc] initWithMenuArray:@[@"新增领料",@"新增预装",@"新增总装",@"新增打包",@"取消"] CompleteBlock:^(NSInteger  index) {
        switch (index) {
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

            }
                break;
            case 3:
            {

            }
                break;
            default:
                break;
        }
    }];

    [sheet show];
    _sheetView = sheet;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
