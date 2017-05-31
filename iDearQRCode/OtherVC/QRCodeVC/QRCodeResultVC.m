//
//  QRCodeResultVC.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/23.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "QRCodeResultVC.h"
#import "QRCodeResultView.h"
@interface QRCodeResultVC ()

@end

@implementation QRCodeResultVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBA(0, 0, 0, 0.4);
    WeakObj(self);
    QRCodeResultView * result = [[QRCodeResultView alloc] initWithResultViewCompleteData:^(NSDictionary *data, NSInteger index) {
        if (index == 1) {




        }
        if (_restQRCode) {
            _restQRCode();
        }
        [selfWeak dismissViewControllerAnimated:NO completion:nil];
    }];

    result.qrcode = self.qrcode;
    [self.view addSubview:result];
    // Do any additional setup after loading the view.
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
