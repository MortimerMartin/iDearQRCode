//
//  PreloadViewModel.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "ViewModelClass.h"

@interface PreloadViewModel : ViewModelClass


/**
 获取view的数据
 */
-(void)loadPreViewData:(NSInteger)page;
/**
 跳转到详情页

 @param vc 当前view的控制器
 @param pickId 选中的cell的model的物件的id
 */
- (void)pushDetailWithVC:(UIViewController *)vc didSelectRowAtPickId:(NSString *)pickId;

///**
// 设置tableView
//
// @param manager 当前控制器的tableview；
// */
//-(void)loadDataManager:(UITableView *)manager;
@end
