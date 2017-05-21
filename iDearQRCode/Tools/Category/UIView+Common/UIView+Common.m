//
//  UIView+Common.m
//  FrameworkSuxx
//
//  Created by suxx on 16/5/26.
//  Copyright © 2016年 suxx. All rights reserved.
//

#import "UIView+Common.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (Common)

-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
-(void)setCornerRadius:(CGFloat)corner{
    if (corner < 0) {
        corner = MIN(self.frame.size.width,self.frame.size.height) / 2;
    }
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}
-(UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
    if (self.layer.borderWidth == 0) {
        self.layer.borderWidth = 1;
    }
}
-(CGFloat)borderWidth{
    return self.layer.borderWidth;
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

-(void)addMultiConstraints:(NSArray<NSString*>*)visualFormatStrings views:(NSDictionary<NSString*,id>*)views{
    for (NSString *vs in visualFormatStrings) {
        [self addConstraints:vs views:views];
    }
}
-(void)addConstraints:(NSString*)hVisualFormatString v:(NSString*)vVisualFormatString views:(NSDictionary*)views{
    [self addConstraints:hVisualFormatString views:views];
    [self addConstraints:vVisualFormatString views:views];
}
-(void)addConstraints:(NSString*)visualFormatString views:(NSDictionary<NSString*,id>*)views{
    NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormatString options:0 metrics:nil views:views];
    [self addConstraints:constraints];
}
-(void)addCenterXConstraint:(UIView*)view{
    [self addCenterXConstraint:view offset:0];
}
-(void)addCenterXConstraint:(UIView*)view offset:(CGFloat)offset{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset]];
}
-(void)addCenterYConstraint:(UIView*)view{
    [self addCenterYConstraint:view offset:0];
}
-(void)addCenterYConstraint:(UIView*)view offset:(CGFloat)offset{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:offset]];
}
-(void)addHeightConstraint:(CGFloat)height{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height]];
}
-(void)addWidthConstraint:(CGFloat)width{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width]];
}
-(void)addHeightConstraint:(CGFloat)height equalTo:(UIView*)to{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:to attribute:NSLayoutAttributeHeight multiplier:1 constant:height]];
}
-(void)addWidthConstraint:(CGFloat)width equalTo:(UIView*)to{
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:to attribute:NSLayoutAttributeWidth multiplier:1 constant:width]];
}
-(void)addSizeConstraint:(CGSize)size{
    [self addWidthConstraint:size.width];
    [self addHeightConstraint:size.height];
}
-(void)addConstraintsToFillFirstSubview{
    [self addConstraints:@"|[v]|" v:@"V:|[v]|" views:@{@"v":self.subviews.firstObject}];
}
-(void)addConstraintsToFillWithSubview:(UIView *)view{
    [self addConstraints:@"|[v]|" v:@"V:|[v]|" views:@{@"v":view}];
}
-(void)addConstraintsToFillWithSubview:(UIView *)view edge:(UIEdgeInsets)edge{
    [self addConstraints:[NSString stringWithFormat:@"|-(%f)-[v]-(%f)-|",edge.left,edge.right]
                       v:[NSString stringWithFormat:@"V:|-(%f)-[v]-(%f)-|",edge.top,edge.bottom] views:@{@"v":view}];
}
-(void)addSubviewAndFillConstraints:(UIView *)view{
    [self addSubviewAndFillConstraints:view edge:UIEdgeInsetsZero];
}
-(void)addSubviewAndFillConstraints:(UIView *)view edge:(UIEdgeInsets)edge{
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSString stringWithFormat:@"|-(%f)-[v]-(%f)-|",edge.left,edge.right]
                       v:[NSString stringWithFormat:@"V:|-(%f)-[v]-(%f)-|",edge.top,edge.bottom] views:@{@"v":view}];
}
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal{
    [self addConstraintsToEquallySubviewInHorizontal:horizontal size:0 relation:NSLayoutRelationEqual space:CGPointZero];
}
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size{
    [self addConstraintsToEquallySubviewInHorizontal:horizontal size:size relation:NSLayoutRelationEqual space:CGPointZero];
}
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size space:(CGPoint)space{
    [self addConstraintsToEquallySubviewInHorizontal:horizontal size:size relation:NSLayoutRelationEqual space:space];
}
-(void)addConstraintsToEquallySubviewInHorizontal:(BOOL)horizontal size:(CGFloat)size relation:(NSLayoutRelation)relation space:(CGPoint)space{
    NSString *v1 = horizontal ? @"H:" : @"V:";
    NSString *v2 = horizontal ? @"V:" : @"H:";
    CGFloat space1 = horizontal ? space.x : space.y;
    CGFloat space2 = horizontal ? space.y : space.x;
    NSLayoutAttribute sizeAttribute = horizontal ? NSLayoutAttributeWidth : NSLayoutAttributeHeight;
    UIView *last = nil;
    for (UIView *view in self.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        if (last) {
            [self addConstraints:[NSString stringWithFormat:@"%@[l]-(%f)-[i(l)]",v1,space1]
                               v:[NSString stringWithFormat:@"%@|-(%f)-[i]-(%f)-|",v2,space2,space2]
                           views:@{@"i":view,@"l":last}];
        }else{
            [self addConstraints:[NSString stringWithFormat:@"%@|-(%f)-[i]",v1,space1]
                               v:[NSString stringWithFormat:@"%@|-(%f)-[i]-(%f)-|",v2,space2,space2]
                           views:@{@"i":view}];
            if (size > 0) {
                NSLayoutConstraint *sizeConstraint = [NSLayoutConstraint constraintWithItem:view attribute:sizeAttribute relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size];
                [view addConstraint:sizeConstraint];
                if (relation != NSLayoutRelationEqual) {
                    NSLayoutConstraint *sizeConstraint2 = [NSLayoutConstraint constraintWithItem:view attribute:sizeAttribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size];
                    sizeConstraint2.priority = UILayoutPriorityDefaultLow;
                    [view addConstraint:sizeConstraint2];
                }
            }
        }
        last = view;
    }
    if (last){
        [self addConstraints:[NSString stringWithFormat:@"%@[l]-(%f)-|",v1,space1] views:@{@"l":last}];
    }
}
-(void)addConstraintsToFillSubviewsInHorizontal:(BOOL)horizontal{
    [self addConstraintsToEquallySubviewSpaceInHorizontal:horizontal space:CGPointZero relation:NSLayoutRelationEqual];
}
-(void)addConstraintsToEquallySubviewSpaceInHorizontal:(BOOL)horizontal space:(CGPoint)space relation:(NSLayoutRelation)relation{
    NSString *v1 = horizontal ? @"H:" : @"V:";
    NSString *v2 = horizontal ? @"V:" : @"H:";
    CGFloat space1 = horizontal ? space.x : space.y;
    CGFloat space2 = horizontal ? space.y : space.x;
    NSString *rlt;
    switch (relation) {
        case NSLayoutRelationLessThanOrEqual:
            rlt = @"<=";
            break;
        case NSLayoutRelationGreaterThanOrEqual:
            rlt = @">=";
            break;
        default:
            rlt = @"==";
            break;
    }
    UIView *last = nil;
    for (UIView *view in self.subviews) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        if (last) {
            [self addConstraints:[NSString stringWithFormat:@"%@[l]-(%@%f)-[i]",v1,rlt,space1]
                               v:[NSString stringWithFormat:@"%@|-(%@%f)-[i]-(%@%f)-|",v2,rlt,space2,rlt,space2]
                           views:@{@"i":view,@"l":last}];
        }else{
            [self addConstraints:[NSString stringWithFormat:@"%@|-(%@%f)-[i]",v1,rlt,space1]
                               v:[NSString stringWithFormat:@"%@|-(%@%f)-[i]-(%@%f)-|",v2,rlt,space2,rlt,space2]
                           views:@{@"i":view}];
        }
        last = view;
    }
    if (last){
        [self addConstraints:[NSString stringWithFormat:@"%@[l]-(%@%f)-|",v1,rlt,space1] views:@{@"l":last}];
    }
}

@end

@implementation UITextField (Common)

static char textFieldFocusBorderColorKey;
-(UIColor *)focusBorderColor{
    if (self.isFirstResponder) {
        return [UIColor colorWithCGColor:self.layer.borderColor];
    }else{
        return objc_getAssociatedObject(self, &textFieldFocusBorderColorKey);
    }
}
-(void)setFocusBorderColor:(UIColor *)focusBorderColor{
    objc_setAssociatedObject(self, &textFieldFocusBorderColorKey, focusBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addListenerForFocus];
}
static char textFieldFocusBorderWidthKey;
-(CGFloat)focusBorderWidth{
    if (self.isFirstResponder) {
        return self.layer.borderWidth;
    }else{
        return [objc_getAssociatedObject(self, &textFieldFocusBorderWidthKey) floatValue];
    }
}
-(void)setFocusBorderWidth:(CGFloat)focusBorderWidth{
    objc_setAssociatedObject(self, &textFieldFocusBorderWidthKey, @(focusBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addListenerForFocus];
}
-(void)addListenerForFocus{
    static BOOL added = NO;
    //    @synchronized(self){
    if (!added) {
        [self addTarget:self action:@selector(changeEditingForFocus) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(changeEditingForFocus) forControlEvents:UIControlEventEditingDidEnd];
        added = YES;
    }
    //    }
}
-(void)changeEditingForFocus{
    UIColor *color = objc_getAssociatedObject(self, &textFieldFocusBorderColorKey);
    if (color) {
        objc_setAssociatedObject(self, &textFieldFocusBorderColorKey, [UIColor colorWithCGColor:self.layer.borderColor], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.layer.borderColor = color.CGColor;
    }
    NSNumber *width = objc_getAssociatedObject(self, &textFieldFocusBorderWidthKey);
    if (width) {
        objc_setAssociatedObject(self, &textFieldFocusBorderWidthKey, @(self.layer.borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.layer.borderWidth = width.floatValue;
    }
}

@end

@implementation UITableView (Common)

-(void)noticeNoData{
    UILabel *label = (UILabel*)[self.superview viewWithTag:9999];
    if (label) {
        label.hidden = NO;
    }else{
        label = [[UILabel alloc] init];
        label.tag = 9999;
        label.backgroundColor = UIColor.clearColor;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor colorWithWhite:0.25882353 alpha:1];
        label.text = @"暂无记录";
        [self.superview addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-20]];
    }
}

-(void)noticeNoData:(NSString *)notice{
    UILabel *label = (UILabel*)[self.superview viewWithTag:9999];
    if (label) {
        label.hidden = NO;
    }else{
        label = [[UILabel alloc] init];
        label.tag = 9999;
        label.backgroundColor = UIColor.clearColor;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textColor = [UIColor colorWithWhite:0.25882353 alpha:1];
        label.text = notice;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.superview addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-20]];
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
        
    }
}
-(void)resetNoData{
    UIView *label = [self.superview viewWithTag:9999];
    if (label) {
        label.hidden = YES;
    }
}

@end

@implementation UISearchBar (Common)

-(BOOL)allowEmptySearch{
    UITextField *searchBarTextField = nil;
    NSArray *views = ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) ? self.subviews : [[self.subviews objectAtIndex:0] subviews];
    for (UIView *subview in views)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchBarTextField = (UITextField *)subview;
            break;
        }
    }
    return !searchBarTextField.enablesReturnKeyAutomatically;
}
-(void)setAllowEmptySearch:(BOOL)allowEmptySearch{
    UITextField *searchBarTextField = nil;
    NSArray *views = ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) ? self.subviews : [[self.subviews objectAtIndex:0] subviews];
    for (UIView *subview in views)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchBarTextField = (UITextField *)subview;
            break;
        }
    }
    searchBarTextField.enablesReturnKeyAutomatically = !allowEmptySearch;
}

@end
