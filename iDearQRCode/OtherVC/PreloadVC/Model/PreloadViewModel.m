//
//  PreloadViewModel.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadViewModel.h"
#import "PreloadDetailVC.h"

#import "RTNetworking.h"
#import "PrereloadCellModel.h"
@interface PreloadViewModel ()


@property(nonatomic , assign) NSInteger pickId;

@end
@implementation PreloadViewModel

-(void)loadPreViewData:(NSInteger)page{



   [RTNetworking postWithUrl:@"doQueryActivity" refreshCache:NO params:@{@"type": @(4)} success:^(id response) {
        [self loadDataWithSuccessDic:nil];



    } fail:^(NSError *error) {


        self.errorBlock(error);


    }];




}
    
- (void)loadDataWithSuccessDic:(NSDictionary *)dic{

    NSMutableArray * arr = [NSMutableArray array];
    NSArray *namesArray = @[@"张三",
                            @"李四",
                            @"王麻子",
                            @"路人甲",
                            @"路人乙"];

    NSArray *textArray = @[@"老板",
                           @"董事长",
                           @"经理",
                           @"其他",
                           @"忽略"
                           ];

    NSArray *commentsArray = @[@"2017-1-01",
                               @"2017-2-28",
                               @"2017-7-00",
                               @"123",
                               @"060706"];

    NSArray *picImageNamesArray = @[ @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"http://file06.16sucai.com/2016/0303/567565d0e78a7e51b6c38f07e7be06ac.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084429317&di=8bf661af0e01924831b035e439500bd6&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F7d4ddedc06495605d726459772423d3b.jpg",
                                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495084431319&di=6ee6bcce85550898fa42c8e86ace9f79&imgtype=0&src=http%3A%2F%2Ffile06.16sucai.com%2F2016%2F0303%2F6b7f7a3c5ccbe9900094add1d8b5cbc8.jpg",
                                     @"http://file06.16sucai.com/2016/0303/3d9ef7096c8c540064f6c4eb8877a929.jpg",
                                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3219125739,1362099777&fm=23&gp=0.jpg"];

    NSArray * sometingArray = @[@"滤水器",
                               @"陶瓷外壳",
                               @"遥控器",
                               @"马桶盖",
                               @"单片机"];

    int countIndex = arc4random_uniform(10);



    for (int i = 0; i< countIndex; i++) {

        int nameIndex = arc4random_uniform(5);
        int doIndex = arc4random_uniform(5);
        int timeIndex = arc4random_uniform(5);
        int iconIndex = arc4random_uniform(6);
        int countIndex = arc4random_uniform(3);
        int numIndex = arc4random_uniform(4);


        PrereloadCellModel * model = [PrereloadCellModel new];

        model.URL = picImageNamesArray[iconIndex];

        model.doSometing = textArray[doIndex];
        model.join_time = commentsArray[timeIndex];
        model.count = countIndex;
        model.numberSometing = numIndex;
        model.pickId = [NSString stringWithFormat:@"%ld",self.pickId++];
        model.name = namesArray[nameIndex];

        CGFloat height = 70;

 
        for (int j = 0; j<countIndex; j++) {

            if (j>1) {
                break;
            }

            height += 26;


            for (int k = 0; k<numIndex; k++) {
                

                height += 16;
            }
        }

        if (countIndex>1) {
            height += 10;
        }

        height += 20;

        model.height =  height ;

        model.Anyting = sometingArray[doIndex];

        [arr addObject:model];
    }

    self.returnBlock(arr);

}

-(void)pushDetailWithVC:(UIViewController *)vc didSelectRowAtPickId:(NSString *)pickId{

    PreloadDetailVC * detail = [[PreloadDetailVC alloc] init];
    detail.pickId = pickId;
    [vc.navigationController pushViewController:detail animated:YES];

}



@end
