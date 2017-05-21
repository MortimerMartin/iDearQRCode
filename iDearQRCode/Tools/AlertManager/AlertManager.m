//
//  LBAlert.m
// SHUFEAlarm
//
//  Created by suxx on 15/10/22.
//  Copyright © 2015年 suxx. All rights reserved.
//

#import "AlertManager.h"

#define BUTTON_OKAY @"确定"
#define BUTTON_YES @"是"
#define BUTTON_NO @"否"
#define BUTTON_OK @"确定"
#define BUTTON_CANCEL @"取消"

@interface AlertManagerViewDelegate : NSObject<UIAlertViewDelegate>

@property (nonatomic,strong) void(^completion)(NSInteger);

+(void)addDelegate:(AlertManagerViewDelegate*)delegate;
+(void)removeDelegate:(AlertManagerViewDelegate*)delegate;

@end

@implementation AlertManager

static __strong NSString *__alertDefaultTitle = @"提示";
/**
 *	@brief	默认标题
 *
 *	@return	默认标题
 */
+ (NSString*)defaultTitle{
    return __alertDefaultTitle;
}
/**
 *	@brief	设置默认标题
 *
 *	@param 	title 	默认标题
 */
+ (void)setDefaultTitle:(NSString*)title{
    if (__alertDefaultTitle != title) {
        __alertDefaultTitle = title;
    }
}
/**
 *	@brief  输入框
 *
 *	@param 	title 	标题
 *	@param 	prompt  输入框占位符
 */
+ (void)ask:(void(^)(NSString * answer))block title:(NSString*)title withTextPrompt: (NSString *) prompt{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:BUTTON_CANCEL style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (block) {
                block(nil);
            }
        }];
        [alert addAction:cancelAction];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:BUTTON_OKAY style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (block) {
                block(alert.textFields.firstObject.text);
            }
        }];
        [alert addAction:confirmAction];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = prompt;
        }];
        UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        //当已经有弹出框在上面时则在最上层弹出来
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }
        [controller presentViewController:alert animated:YES completion:nil];
    }else{
        // Build text field
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 30.0f)];
        
        AlertManagerViewDelegate *delegate = nil;
        if (block) {
            delegate = [[AlertManagerViewDelegate alloc] init];
            delegate.completion = ^(NSInteger index){
                if (index == 1) {
                    block(tf.text);
                }
            };
            [AlertManagerViewDelegate addDelegate:delegate];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"\n" delegate:delegate cancelButtonTitle:BUTTON_CANCEL otherButtonTitles:BUTTON_OKAY, nil];
        
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.tag = 9999;
        tf.placeholder = prompt;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        //tf.keyboardType = UIKeyboardTypeAlphabet;
        //tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        tf.autocapitalizationType = UITextAutocapitalizationTypeWords;
        tf.autocorrectionType = UITextAutocorrectionTypeNo;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // Show alert and wait for it to finish displaying
        [alertView show];
        while (CGRectEqualToRect(alertView.bounds, CGRectZero));
        
        // Find the center for the text field and add it
        CGRect bounds = alertView.bounds;
        tf.center = CGPointMake(bounds.size.width / 2.0f, bounds.size.height / 2.0f - 10.0f);
        [alertView addSubview:tf];
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.25f];
        if (![self isLandscape])
            alertView.center = CGPointMake(160.0f, 180.0f);
        else
            alertView.center = CGPointMake(240.0f, 90.0f);
        [UIView commitAnimations];
        
        [tf becomeFirstResponder];
    }
}
+ (BOOL) isLandscape
{
    return ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) || ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
}
/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	question 	描述
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
 */
+ (void)ask:(void(^)(NSInteger answer))block title:(NSString*)title question:(NSString *)question withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray*)buttons{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:question preferredStyle:UIAlertControllerStyleAlert];
        NSInteger index = 0;
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (block) {
                    block(index);
                }
            }];
            [alert addAction:cancelAction];
            index++;
        }
        if (buttons) {
            for (NSString *button in buttons) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (block) {
                        block(index);
                    }
                }];
                [alert addAction:action];
                index++;
            }
        }
        UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        //当已经有弹出框在上面时则在最上层弹出来
        while (controller.presentedViewController) {
            controller = controller.presentedViewController;
        }
        [controller presentViewController:alert animated:YES completion:nil];
        
    }else{
        AlertManagerViewDelegate *delegate = nil;
        if (block) {
            delegate = [[AlertManagerViewDelegate alloc] init];
            delegate.completion = block;
            [AlertManagerViewDelegate addDelegate:delegate];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = title;
        alertView.message = question;
        alertView.delegate = delegate;
        if (cancelButtonTitle) {
            alertView.cancelButtonIndex = 0;
            [alertView addButtonWithTitle:cancelButtonTitle];
        }
        if (buttons) {
            for (NSString *button in buttons) {
                [alertView addButtonWithTitle:button];
            }
        }
        [alertView show];
    }
}
/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	question 	描述
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
  *	@param 	vc 	控制器
 */
+ (void)ask:(void(^)(NSInteger answer))block title:(NSString*)title question:(NSString *)question withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray*)buttons vc:(__kindof UIViewController *)vc{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:question preferredStyle:UIAlertControllerStyleAlert];
        NSInteger index = 0;
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (block) {
                    block(index);
                }
            }];
            [alert addAction:cancelAction];
            index++;
        }
        if (buttons) {
            for (NSString *button in buttons) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (block) {
                        block(index);
                    }
                }];
                [alert addAction:action];
                index++;
            }
        }
        [vc presentViewController:alert animated:YES completion:nil];
        
    }else{
        AlertManagerViewDelegate *delegate = nil;
        if (block) {
            delegate = [[AlertManagerViewDelegate alloc] init];
            delegate.completion = block;
            [AlertManagerViewDelegate addDelegate:delegate];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.title = title;
        alertView.message = question;
        alertView.delegate = delegate;
        if (cancelButtonTitle) {
            alertView.cancelButtonIndex = 0;
            [alertView addButtonWithTitle:cancelButtonTitle];
        }
        if (buttons) {
            for (NSString *button in buttons) {
                [alertView addButtonWithTitle:button];
            }
        }
        [alertView show];
    }
}

/**
 *	@brief	询问框
 *
 *	@param 	question 	描述
 *	@param 	cancelButtonTitle 	取消按钮文字
 *	@param 	buttons 	其他按钮文字
 */
+ (void)ask:(void(^)(NSInteger answer))block question:(NSString *)question withCancel:(NSString *)cancelButtonTitle withButtons:(NSArray*)buttons{
    [self ask:block title:__alertDefaultTitle question:question withCancel:cancelButtonTitle withButtons:buttons];
}
/**
 *	@brief	提示框
 *
 *	@param 	formatstring 	描述
 */
+ (void)say:(id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask:nil question:statement withCancel:BUTTON_OKAY withButtons:nil];
    //	[statement release];
}
/**
 *	@brief	提示框
 *
 *	@param 	formatstring 	描述
 */
+ (void)say:(void(^)())block message: (id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self say:block title:__alertDefaultTitle message:statement];
    //	[statement release];
}
/**
 *	@brief	询问框
 *
 *	@param 	formatstring 	描述
 */
+ (void)ask:(void(^)(BOOL answer))block question:(id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask:block title:__alertDefaultTitle question:statement];
    //	[statement release];
}
/**
 *	@brief	确认框
 *
 *	@param 	formatstring 	描述
 */
+ (void)confirm:(void(^)())block question:(id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self confirm:block title:__alertDefaultTitle question:statement];
    //	[statement release];
}

/**
 *	@brief	提醒框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)say:(void(^)())block title:(NSString*)title message: (id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask:^(NSInteger a){if(block)block();} title:title question:statement withCancel:BUTTON_OKAY withButtons:nil];
    //	[statement release];
}
/**
 *	@brief	提醒框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
  *	@param 	vc 	控制器
 */
+ (void)sayIn:(__kindof UIViewController *)vc Block:(void(^)())block title:(NSString*)title message: (id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask:^(NSInteger a){if(block)block();} title:title question:statement withCancel:BUTTON_OKAY withButtons:nil vc:vc];
    //	[statement release];
}
/**
 *	@brief	询问框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)ask:(void(^)(BOOL answer))block title:(NSString*)title question:(id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask:^(NSInteger answer) { block(answer == 0);} title:title question:statement withCancel:nil withButtons:@[BUTTON_YES, BUTTON_NO]];
    //	[statement release];
}
/**
 *	@brief	确认框
 *
 *	@param 	title 	标题
 *	@param 	formatstring 	描述
 */
+ (void)confirm:(void(^)())block title:(NSString*)title question:(id)formatstring,...{
    va_list arglist;
    va_start(arglist, formatstring);
    id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
    va_end(arglist);
    [self ask: ^(NSInteger a){if(a == 1)block();} title:title question:statement withCancel:BUTTON_CANCEL withButtons:@[BUTTON_OK]];
    //	[statement release];
}

@end

@implementation AlertManagerViewDelegate

static __strong NSMutableArray *__delegates;
+(NSMutableArray*)delegates{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        __delegates = [[NSMutableArray alloc] init];
    });
    return __delegates;
}
+(void)addDelegate:(AlertManagerViewDelegate*)delegate{
    [[self delegates] addObject:delegate];
}
+(void)removeDelegate:(AlertManagerViewDelegate*)delegate{
    [[self delegates] removeObject:delegate];
}
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (self.completion) {
        self.completion(buttonIndex);
    }
    [[self class] removeDelegate:self];
}

@end
