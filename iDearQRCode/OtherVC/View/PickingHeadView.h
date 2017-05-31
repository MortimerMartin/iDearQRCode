//
//  PickingHeadView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/17.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UPViewSearchType = 0,
    UPViewScreenType,
    UPViewDeleteType,
    UPViewCombineType,
    UPViewNormal
} UPViewtype;


//类名＋delegate
@protocol PickingHeadViewDelegate <NSObject>
-(void)didClick:(UPViewtype)type WithSelect:(BOOL)select;
//代理方法必须实现的方法
@required

//代理方法可选实现的方法
@optional

@end
@interface PickingHeadView : UIView

@property (nonatomic , weak) id<PickingHeadViewDelegate>  delegate;


//@property (nonatomic , copy) void(^didClickHandler)(UPViewtype,BOOL) ;

@end
