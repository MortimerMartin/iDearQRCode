//
//  personViewController.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "personViewController.h"
#import "PersonTableViewCell.h"
#import "PersonHeadView.h"
#import "AlertManager.h"
#import "UIView+Toast.h"

@interface personViewController ()<UITableViewDelegate , UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIView * alphaView;
}
@end

@implementation personViewController
static NSString * identifier = @"PersonTableViewCell" ;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupRightItem:@"更换头像"];
    [self setupTableView];

}

-(void)setupTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(-64, 0, 0, 0));
    }];
//    self.tableView.sd_layout.topSpaceToView(self.view,-64).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    self.tableView.sectionFooterHeight = 0.01f;
    self.tableView.scrollEnabled = NO;
    self.dataSource = [NSMutableArray arrayWithArray:@[@[@"部门",@"职位",@"入职时间"],@[@"生产二部",@"组长",@"2014-06-12"]]];
}

#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    PersonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if(cell==nil){
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.dataSource[0][indexPath.row];
    cell.content = self.dataSource[1][indexPath.row];
    cell.isLast = (indexPath.row == 2) ? YES : NO;

    return cell;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PersonHeadView * head = [[PersonHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 300)];
    head.backgroundColor = [UIColor grayColor];
    head.name = @"Mortimer";
    head.doing = @"Martin";
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300.0f;
};




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WeakObj(self);
    [UIView animateWithDuration:0.25 animations:^{
        [selfWeak.navigationController.navigationBar.subviews[0] setAlpha:0];
    }];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    WeakObj(self);
    [UIView animateWithDuration:0.25 animations:^{
        [selfWeak.navigationController.navigationBar.subviews[0] setAlpha:1];
    }];

}

-(void)change{
    [AlertManager ask:^(NSInteger answer) {
        switch (answer) {
            case 1:
            {//判断是否可以打开相机,模拟器无法使用此功能

                if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {

                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

                    picker.delegate = self;

                    picker.allowsEditing = YES; //是否可编辑

                    //摄像头

                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

                    [self presentViewController:picker animated:YES completion:nil];
                    
                }else
                    
                {
                    //如果没有提示用户
                    [self.view makeToast:@"您没有摄像头" duration:1 position:CSToastPositionCenter];

                }

            }
                break;
            case 2:
            {
                //相册是可以用模拟器打开的

                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {

                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

                    picker.delegate = self;

                    picker.allowsEditing = YES;

                    //打开相册选择照片

                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    [self presentViewController:picker animated:YES completion:nil];
                    
                }else
                    
                {
                    
                    //如果没有提示用户
                    [self.view makeToast:@"请开启APP相册权限" duration:1 position:CSToastPositionCenter];
                    
                }
            }
                break;
            default:
                break;
        }
    } question:@"更换头像" withCancel:@"取消" withButtons:@[@"相机",@"相册"]];
    
};

//拍摄完成后要执行的方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

    NSData *imageData = UIImageJPEGRepresentation(image,0.5);

    [self dismissViewControllerAnimated:YES completion:nil];

}

//点击Cancel按钮后执行方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 300;
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
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
