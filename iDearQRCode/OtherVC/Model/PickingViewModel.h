//
//  PickingViewModel.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/21.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ViewModelClass.h"


/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, PickingRefreshState) {
    /** 普通闲置状态 */
    PickingHeadRefresh = 1,
    /** 松开就可以进行刷新的状态 */
    PickingFootRefresh
};
@interface PickingViewModel : ViewModelClass

// 获取商品列表
- (void)fetchPickingList:(NSInteger)page;
// 跳转到商品详情页
- (void)pushDetailWithVC:(UIViewController *)vc didSelectRowAtPickId:(NSString *)pickId;

@end
