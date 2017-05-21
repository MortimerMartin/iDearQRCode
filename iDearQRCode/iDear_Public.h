//
//  iDear_Public.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#ifndef iDear_Public_h
#define iDear_Public_h

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)

#define text_Color1 RGB(86, 92, 92)
#define text_Color2 RGB(115, 127, 127)
#define text_Color3 RGB(154, 169, 169)

#define back_Color RGB(239, 244, 244)

#define line_Color RGB(201, 205, 205)
//组长
#define do_Color RGB(160, 226, 224)
//字体
#define kFont_16 [UIFont systemFontOfSize:16]
#define kFont_14 [UIFont systemFontOfSize:14]
#define kFont_12 [UIFont systemFontOfSize:12]


// 3.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 4.屏幕大小尺寸
#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)


//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y

//5.常用对象
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define WeakObj(self) __weak typeof(self) self##Weak = self;

//7.
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取用户存储信息
#define getUserInfo(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key];


#define kGetTEXTSIZE(text, font) [text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero
#endif /* iDear_Public_h */
