//
//  PickingFootView.h
//  iDearQRCode
//
//  Created by Mortimer on 17/5/18.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickModelType) {
    PickModelNormal = 0,
    PickModelDelete,
    PickModelSelectAll,
    PickModelCombine
};


@protocol pickingFootViewDelegate <NSObject>

@required

-(void)didHandelAction:(PickModelType)type;

@end
@interface PickingFootView : UIView

-(instancetype)initWithPickAction:(void(^)(PickModelType type))pick;



@property (nonatomic , weak) id<pickingFootViewDelegate> delegate;

@property (nonatomic , assign) BOOL selectAllState;




-(void)show:(PickModelType)type;

-(void)dismiss;

-(void)remove;
@end
