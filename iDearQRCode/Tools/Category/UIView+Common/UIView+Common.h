//
//  UIView+Common.h
//  FrameworkSuxx
//
//  Created by suxx on 16/5/26.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

/**
 *	@brief  圆角值，小于0则为高(宽)度的一半
 */
@property (assign,nonatomic) IBInspectable CGFloat cornerRadius;
/**
 *	@brief  边框颜色，（若设置了则边框宽度默认为1）
 */
@property (strong,nonatomic) IBInspectable UIColor *borderColor;
/**
 *	@brief  边框宽度
 */
@property (assign,nonatomic) IBInspectable CGFloat borderWidth;


///AutoLayout辅助
-(void)addMultiConstraints:(NSArray<NSString *>*)visualFormatStrings views:(NSDictionary<NSString*,id>*)views;
-(void)addConstraints:(NSString*)hVisualFormatString v:(NSString*)vVisualFormatString views:(NSDictionary*)views;
-(void)addConstraints:(NSString*)visualFormatString views:(NSDictionary<NSString*,id>*)views;
-(void)addCenterXConstraint:(UIView*)view;
-(void)addCenterXConstraint:(UIView*)view offset:(CGFloat)offset;
-(void)addCenterYConstraint:(UIView*)view;
-(void)addCenterYConstraint:(UIView*)view offset:(CGFloat)offset;
-(void)addHeightConstraint:(CGFloat)height;
-(void)addWidthConstraint:(CGFloat)width;
-(void)addHeightConstraint:(CGFloat)height equalTo:(UIView*)to;
-(void)addWidthConstraint:(CGFloat)width equalTo:(UIView*)to;
-(void)addSizeConstraint:(CGSize)size;
-(void)addConstraintsToFillFirstSubview;
-(void)addConstraintsToFillWithSubview:(UIView*)view;
-(void)addConstraintsToFillWithSubview:(UIView*)view edge:(UIEdgeInsets)edge;
-(void)addSubviewAndFillConstraints:(UIView *)view;
-(void)addSubviewAndFillConstraints:(UIView *)view edge:(UIEdgeInsets)edge;

///大小相等地排列SubView
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal;
///大小相等地排列SubView
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size;
///大小相等地排列SubView
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size space:(CGPoint)space;
///大小相等地排列SubView
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size relation:(NSLayoutRelation)relation space:(CGPoint)space;
///间距相等地排列SubView
-(void)addConstraintsToFillSubviewsInHorizontal:(BOOL)horizontal;
///间距相等地排列SubView
-(void)addConstraintsToEquallySubviewSpaceInHorizontal:(BOOL)horizontal space:(CGPoint)space relation:(NSLayoutRelation)relation;

@end


@interface UITextField (Common)

///获得焦点后边框颜色，（若设置了则边框宽度默认为1）
@property (strong,nonatomic) IBInspectable UIColor *focusBorderColor;
///获得焦点后边框宽度
@property (assign,nonatomic) IBInspectable CGFloat focusBorderWidth;

@end

@interface UITableView (Common)

///显示没有记录
-(void)noticeNoData;
-(void)noticeNoData:(NSString *)notice;
///去掉没有记录的显示
-(void)resetNoData;

@end

@interface UISearchBar (Common)

///允许空字符搜索
@property (assign,nonatomic) IBInspectable BOOL allowEmptySearch;

@end
