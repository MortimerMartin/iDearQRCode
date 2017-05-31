//
//  PreloadDetailView.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/24.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadDetailView.h"


@interface PreloadDetailView ()

@property (nonatomic , strong) UIView * topView;
@property (nonatomic , strong) UIImageView * img;
@property (nonatomic , strong) UILabel * personName;
@property (nonatomic , strong) UILabel * personDoing;
@property (nonatomic , strong) UILabel * personJoingTime;

@end
@implementation PreloadDetailView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupDefaultView];
    }
    return self;
}


-(void)setupDefaultView{

    _topView = [UIView new];
    _topView.backgroundColor = line_Color;
    [self addSubview:_topView];

//    UIView * view = [UIView new];
//    view.backgroundColor = [UIColor whiteColor];
    UIImageView * image = [[UIImageView alloc] init];
    image.layer.cornerRadius = 15.0f;
    image.layer.masksToBounds = YES;
    [self addSubview:image];
    _img = image;


    UILabel * title = [self creatLabel:@"" TextColor:text_Color2 Font:nil];
    [self addSubview:title];
    _personName = title;
    UILabel * detail = [self creatLabel:@"" TextColor:text_Color2 Font:nil];
    [self addSubview:detail];
    _personDoing = detail;
    UILabel * time = [self creatLabel:@"" TextColor:text_Color3 Font:nil];;
    [self addSubview:time];
    _personJoingTime = time;



    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.6);
    }];

    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(6);
        make.top.equalTo(_topView.mas_bottom).offset(8);
        make.height.width.mas_equalTo(30);
    }];

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(8);
        make.centerY.equalTo(image).offset(-8);
    }];

    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(6);
        make.centerY.equalTo(title);
    }];

    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title);
        make.centerY.equalTo(image).offset(8);
    }];  
}

-(void)setIsFirst:(NSInteger)isFirst{
    _isFirst = isFirst;
    if (isFirst == YES) {
        // 获取一条曲线。曲线路径为(0,0,96,50).圆角位置为右上和右下，圆角大小为25
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreen_width - 20, 10) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(5, 5)];

        // 初始化一个CAShapeLayer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = CGRectMake(0, 0, kScreen_width - 20, 10);
        // 将曲线路径设置为layer的路径
        maskLayer.path = path.CGPath;

        // 设置控件的mask为CAShapeLayer
        _topView.layer.mask = maskLayer;
        _topView.backgroundColor = topView_Color;
        [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(10);
        }];
    }
}
-(void)uploadDetailHeadView:(NSArray *)data{
    [_img sd_setImageWithURL:[NSURL URLWithString:data[0]] placeholderImage:[UIImage imageNamed:@""]];
    _personName.text = data[1];
    _personDoing.text = data[2];
    _personJoingTime.text = data[3];
}

-(UILabel *)creatLabel:(NSString *)text TextColor:(UIColor *)color Font:(UIFont *)font{
    UILabel * label = [UILabel new];
    if (!font) {
        font = kFont_14;
    }
    label.font = font;
    label.text = text;
    label.textColor = color;
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
