//
//  PickingViewModel.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/21.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ViewModelClass.h"

@interface PickingViewModel : ViewModelClass

// 获取商品列表
- (void)fetchPickingList;
// 跳转到商品详情页
- (void)pushDetailWithVC:(UIViewController *)vc didSelectRowAtPickId:(NSString *)pickId;

@end
