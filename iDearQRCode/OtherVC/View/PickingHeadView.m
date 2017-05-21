//
//  PickingHeadView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/17.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickingHeadView.h"

@implementation PickingHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        [self setupPickingView];
    }
    return self;
}

-(void)setupPickingView{
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(kScreen_width/4), 0, kScreen_width/4, self.frame.size.height);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_pick%d",i]] forState:UIControlStateNormal];
        [btn setTitle:i == 0 ? @"搜索": i == 1  ? @"筛选" : i == 2 ? @"删除":@"合并" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 714 + i;
        [btn addTarget:self action:@selector(upView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
    }

}


-(void)upView:(UIButton *)sender{

    for (int i = 0; i<4; i++) {
        //根据tag 获取到你其他所有的button
        UIButton *btn = (UIButton *)[self viewWithTag:714 + i];
        //判断点击的是那个button
        if (btn.tag==[(UIButton *)sender tag])
        {
//            if (btn.tag == 716 || btn.tag == 717) {
//                btn.selected = !btn.selected; //不管用，卧槽
//                if (btn.selected == YES) {
                    if (self.didClickHandler) {
                        self.didClickHandler((UPViewtype)btn.tag - 714,sender.selected);
                    }
//                }else{
//                    if (self.didClickHandler) {
//                        self.didClickHandler(UPViewNormal,sender.selected);
//                    }
//                }
//            }else{
//                if (self.didClickHandler) {
//                    self.didClickHandler((UPViewtype)btn.tag - 714,sender.selected);
//                }
//            }


        }else{
            //这里设置你其他button 的样式
            btn.selected = NO;
        }
    }

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
