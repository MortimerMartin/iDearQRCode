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
@interface PickingHeadView : UIView

@property (nonatomic , copy) void(^didClickHandler)(UPViewtype,BOOL) ;

@end
