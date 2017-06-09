//
//  PickingViewModel.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/21.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickingViewModel.h"
//#import "RTNetworking.h"
#import "YQNetworking.h"
#import "PickDetailVc.h"
#import "PickingModel.h"

@interface PickingViewModel ()

@property(nonatomic , assign) NSInteger page;

@end
@implementation PickingViewModel

-(void)fetchPickingList:(NSInteger)page{

    [YQNetworking postWithUrl:@"http://image.degjsm.cn/EHome/services/api/mobileManager/doQueryActivity" refreshRequest:NO cache:NO params:@{@"type": @(4)} progressBlock:nil successBlock:^(id response) {
        if (response) {
        [self loadDataWithSuccessDic:response];
        }

    } failBlock:^(NSError *error) {
        self.errorBlock(error);
    }];


}

- (void)loadDataWithSuccessDic:(NSDictionary *)dic{
//    NSMutableArray *arr = dic[@"data"];
//    self.returnBlock(arr);

    NSMutableArray * arr = [NSMutableArray array];
    NSArray *namesArray = @[@"Mortimer",
                            @"Martin",
                            @"chaowei",
                            @"leigai",
                            @"Hello Kitty"];

    NSArray *textArray = @[@"马面",
                           @"鹿角",
                           @"蛇身",
                           @"鱼鳞",
                           @"牛脚"
                           ];

    NSArray *commentsArray = @[@"2017-12-33",
                               @"2017-12-30",
                               @"2017-12-00",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];

    NSArray *picImageNamesArray = @[ @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"http://file06.16sucai.com/2016/0303/567565d0e78a7e51b6c38f07e7be06ac.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084431319&di=6ee6bcce85550898fa42c8e86ace9f79&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F6b7f7a3c5ccbe9900094add1d8b5cbc8.jpg",
                                     @"http://file06.16sucai.com/2016/0303/3d9ef7096c8c540064f6c4eb8877a929.jpg",
                                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3219125739,1362099777&fm=23&gp=0.jpg"

                                      ];
    int countIndex = arc4random_uniform(10);
    for (int i = 0; i< countIndex; i++) {

        int nameIndex = arc4random_uniform(5);
        int doIndex = arc4random_uniform(5);
        int timeIndex = arc4random_uniform(13);
        int iconIndex = arc4random_uniform(6);
        int countIndex = arc4random_uniform(5);



        PickingModel * model = [PickingModel new];
        model.URL = picImageNamesArray[iconIndex];
        //        model.name = namesArray[nameIndex];
        model.doSometing = textArray[doIndex];
        model.join_time = commentsArray[timeIndex];
        model.count = countIndex;
        model.pickId = [NSString stringWithFormat:@"%d",i];

        model.height = 78 + countIndex * 24 ;
        model.name = [NSString stringWithFormat:@"%@___height:%f___count:%d____",namesArray[nameIndex],model.height,countIndex];

        [arr addObject:model];
    }
    self.returnBlock(arr);
}

-(void)pushDetailWithVC:(UIViewController *)vc didSelectRowAtPickId:(NSString *)pickId{
    PickDetailVc * detail = [[PickDetailVc alloc] init];
    detail.pickId = pickId;
    [vc.navigationController pushViewController:detail animated:YES];
}
@end
