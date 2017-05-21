//
//  LBAlert.h
//  SHUFEAlarm
//
//  Created by suxx on 15/10/22.
//  Copyright © 2015年 suxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertManager : NSObject

/**
 *	@brief	默认标题
 *
 *	@return	默认标题
 */
+ (NSString*)defaultTitle;
/**
 *	@brief	设置默认标题
 *
 *	@param 	title 	默认标题
 */
+ (void)setDefaultTitle:(NSString*)title;

/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	view 	自定义视图
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
 */
//+ (void)ask:(void(^)(UIView *customizeView,NSUInteger answer))block title:(NSString *)title customizeView:(UIView*(^)(CGFloat width))view withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray *)buttons;

/**
 *	@brief	询问框
 *
 *	@param 	question 	描述
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
 */
+ (void)ask:(void(^)(NSInteger answer))block question:(NSString *)question withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray*)buttons;
/**
 *	@brief	提示框
 *
 *	@param 	formatstring 	描述
 */
+ (void)say:(id)formatstring,...;
/**
 *	@brief	提示框
 *
 *	@param 	formatstring 	描述
 */
+ (void)say:(void(^)())block message: (id)formatstring,...;
/**
 *	@brief	询问框
 *
 *	@param 	formatstring 	描述
 */
+ (void)ask:(void(^)(BOOL answer))block question:(id)formatstring,...;
/**
 *	@brief	确认框
 *
 *	@param 	formatstring 	描述
 */
+ (void)confirm:(void(^)())block question:(id)formatstring,...;

/**
 *	@brief  输入框
 *
 *	@param 	title 	标题
 *	@param 	prompt  输入框占位符
 */
+ (void)ask:(void(^)(NSString * answer))block title:(NSString*)title withTextPrompt: (NSString *) prompt;
/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	question 	描述
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
 */
+ (void)ask:(void(^)(NSInteger answer))block title:(NSString*)title question:(NSString *)question withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray*)buttons;
/**
 *	@brief	提醒框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)say:(void(^)())block title:(NSString*)title message: (id)formatstring,...;
/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)ask:(void(^)(BOOL answer))block title:(NSString*)title question:(id)formatstring,...;
/**
 *	@brief	确认框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)confirm:(void(^)())block title:(NSString*)title question:(id)formatstring,...;

/**
 *	@brief	选择框
 *
 *	@param 	title 	标题
 *	@param 	datas 	二维数组@[@[r1,r2,r3],@[r1,r2],@[r1]],第一维是component,第二维是row,只能字符串
 *	@param 	indexs  选中的索引跟datas第一维个数一致,如@[@(0),@(1),@(0)],则默认选中r1,r2,r1
 */
//+ (void)pick:(void(^)(NSArray *selectedIndexs))block title:(NSString*)title datas:(NSArray*)datas selectedIndexs:(NSArray*)indexs;

/**
 *	@brief	提醒框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 *	@param 	vc 	控制器
 */
+ (void)sayIn:(__kindof UIViewController *)vc Block:(void(^)())block title:(NSString*)title message: (id)formatstring,...;
@end
