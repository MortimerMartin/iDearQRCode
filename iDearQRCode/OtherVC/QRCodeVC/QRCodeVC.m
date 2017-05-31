//
//  QRCodeVC.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRCodeVC.h"
#import "LBXAlertAction.h"
#import "LBXScanVideoZoomView.h"
#import "LBXScanWrapper.h"
#import "LBXScanResult.h"
#import "QRCodeResultVC.h"
@interface QRCodeVC ()
@property (nonatomic, strong) LBXScanVideoZoomView *zoomView;
@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"扫描";
    //创建参数对象
    LBXScanViewStyle * style = [[LBXScanViewStyle alloc] init];
    //矩形区域中心上移，默认中心为屏幕中心点
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型，设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    //扫码框内，动画类型 －－线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];

    self.style = style;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {

        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.view.backgroundColor = [UIColor blackColor];

    //设置扫码后需要扫码图像
//    self.isNeedScanImage = YES;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self drawBottomItems];
    [self drawTitle];
    [self.view bringSubviewToFront:_topTitle];
}
//绘制扫描区域
-(void)drawTitle{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);

        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }

        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
}

- (void)drawBottomItems
{
    if (_bottomItemsView) {

        return;
    }

    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                   CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    [self.view addSubview:_bottomItemsView];

    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/3, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];

    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)*2/3, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];

//    self.btnMyQR = [[UIButton alloc]init];
//    _btnMyQR.bounds = _btnFlash.bounds;
//    _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
//    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
//    [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
//    [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];

    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
//    [_bottomItemsView addSubview:_btnMyQR];

}

//- (void)cameraInitOver
//{
//    if (self.isVideoZoom) {
//        [self zoomView];
//    }
//}

//- (LBXScanVideoZoomView*)zoomView
//{
//    if (!_zoomView)
//    {
//
//        CGRect frame = self.view.frame;
//
//        int XRetangleLeft = self.style.xScanRetangleOffset;
//
//        CGSize sizeRetangle = CGSizeMake(frame.size.width - XRetangleLeft*2, frame.size.width - XRetangleLeft*2);
//
//        if (self.style.whRatio != 1)
//        {
//            CGFloat w = sizeRetangle.width;
//            CGFloat h = w / self.style.whRatio;
//
//            NSInteger hInt = (NSInteger)h;
//            h  = hInt;
//
//            sizeRetangle = CGSizeMake(w, h);
//        }
//
//        CGFloat videoMaxScale = [self.scanObj getVideoMaxScale];
//
//        //扫码区域Y轴最小坐标
//        CGFloat YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height/2.0 - self.style.centerUpOffset;
//        CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
//
//        CGFloat zoomw = sizeRetangle.width + 40;
//        _zoomView = [[LBXScanVideoZoomView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-zoomw)/2, YMaxRetangle + 40, zoomw, 18)];
//
//        [_zoomView setMaximunValue:videoMaxScale/4];
//
//
//        __weak __typeof(self) weakSelf = self;
//        _zoomView.block= ^(float value)
//        {
//            [weakSelf.scanObj setVideoScale:value];
//        };
//        [self.view addSubview:_zoomView];
//
////        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
////        [self.view addGestureRecognizer:tap];
//    }
//
//    return _zoomView;
//
//}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{

    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];

        return;
    }

    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {

        NSLog(@"scanResult:%@",result.strScanned);
    }

    LBXScanResult *scanResult = array[0];

    NSString*strResult = scanResult.strScanned;

    self.scanImage = scanResult.imgScanned;

    if (!strResult) {

        [self popAlertMsgWithScanResult:nil];

        return;
    }

    //震动提醒
//    [LBXScanWrapper systemVibrate];
    //声音提醒
//    [LBXScanWrapper systemSound];


    [self showNextVCWithScanResult:scanResult];

}

-(void)showNextVCWithScanResult:(LBXScanResult*)result{
    QRCodeResultVC * vc = [[QRCodeResultVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    __weak __typeof(self) weakSelf = self;
    vc.restQRCode = ^{
        [weakSelf reStartDevice];
    };
    vc.qrcode = result.strScanned;
    [self presentViewController:vc animated:NO completion:nil];

}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {

        strResult = @"识别失败";
    }

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:strResult preferredStyle:UIAlertControllerStyleAlert];
    __weak __typeof(self) weakSelf = self;
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [weakSelf reStartDevice];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)showError:(NSString*)str
{


}

#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    if ([LBXScanWrapper isGetPhotoPermission])
        [self openLocalPhoto];
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请到设置->隐私中开启本程序相册权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//开关闪光灯
- (void)openOrCloseFlash
{

    [super openOrCloseFlash];


    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
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
