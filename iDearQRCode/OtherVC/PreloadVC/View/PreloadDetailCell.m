//
//  PreloadDetailCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/24.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PreloadDetailCell.h"
#import "UIView+MJExtension.h"
#import "PrereloadCellModel.h"
@interface PreloadDetailCell ()

@property (nonatomic , strong) UILabel * leftLabel;
@property (nonatomic , strong) UILabel * rightLabel;

@property (nonatomic , strong) UIView * detailView;
@property (nonatomic , strong) UIButton * DataBtn;

//@property (nonatomic , assign) BOOL swipe;

@end

@implementation PreloadDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDefaultCell];
    }
    return self;
}


-(void)setupDefaultCell{

    _leftLabel = [self creatLabelTextColor:text_Color1 Font:nil];
    _rightLabel = [self creatLabelTextColor:text_Color1 Font:nil];

    [self.contentView addSubview:_leftLabel];
    [self.contentView addSubview:_rightLabel];

    _detailView = [UIView new];
//    _detailView.backgroundColor = [UIColor redColor];
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSelectView:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_detailView addGestureRecognizer:swipeLeft];

     UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSelectView:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_detailView addGestureRecognizer:swipeRight];


    _DataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _DataBtn.layer.cornerRadius = 3;
    _DataBtn.layer.masksToBounds = YES;
    _DataBtn.layer.borderColor = topView_Color.CGColor;
    _DataBtn.layer.borderWidth = 0.8;
    [_DataBtn setTitle:@"复制" forState:UIControlStateNormal];
    _DataBtn.titleLabel.font = kFont_12;
    [_DataBtn setTitleColor:topView_Color forState:UIControlStateNormal];
    [_DataBtn addTarget:self action:@selector(copyPush) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_DataBtn];
    _DataBtn.hidden = YES;


    [self.contentView addSubview:_detailView];

    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(6);
        make.top.equalTo(self.contentView).offset(4);
    }];

    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-6);
        make.centerY.equalTo(_leftLabel);
    }];



    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.equalTo(_leftLabel.mas_bottom).offset(5);
        make.right.bottom.equalTo(self.contentView);

    }];


//    _DataBtn.frame = CGRectMake(self.frame.size.width, (self.frame.size.height - 20)/2 - 10, 50, 20);

    [_DataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(60);
        make.centerY.equalTo(_detailView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
//        make.left.equalTo(_detailView.mas_right).offset(8);
//        make.width.mas_equalTo(44);
    }];
}



-(UILabel *)creatLabelTextColor:(UIColor *)color Font:(UIFont *)font{
    UILabel * label = [UILabel new];
    if (!font) {
        font = kFont_14;
    }
    label.font = font;
    label.textColor = color;
    return label;
}


-(void)showSelectView:(UISwipeGestureRecognizer *)swipe{

    if (self.shouldMove == YES) {
        if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {

            [UIView animateWithDuration:0.3 animations:^{

                _DataBtn.alpha = 0;

                [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(12);

                }];


                [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView);
                }];

                [_DataBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(60);
                }];
            } completion:^(BOOL finished) {
                _DataBtn.hidden = YES;

            }];


        }else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){

            [UIView animateWithDuration:0.3 animations:^{


                [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(4);
                }];
                [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView).offset(-80);
                }];



                _DataBtn.hidden = NO;
            }completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _DataBtn.alpha = 1;
                    
                    [_DataBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-8);
                    }];
                    
                }];
            }];
        }
    }


}

-(void)copyPush{
    if (_didCopyHandle) {
        _didCopyHandle(self.data);
    }

    

}


-(void)setData:(NSArray *)data{
    _data = data;
    NSArray * left = data[0];
    NSArray * right = data[1];
    _leftLabel.text =left[0];
    _rightLabel.text = right[1];

    for (UIView * view in _detailView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat top = 0;
    for (int i = 0; i<left.count; i++) {
        top += 3;
        UIView * view = [self getDetailView:left[i] Right:right[i]];
        [_detailView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.right.equalTo(_detailView);

        }];
        top += 15;
    }

}

-(UIView *)getDetailView:(NSString *)left Right:(NSString *)right{
    UIView * view = [UIView new];
    UILabel * leftL = [self creatLabelTextColor:text_Color2 Font:kFont_12];
//    leftL.backgroundColor = [UIColor redColor];
    UILabel * rightL = [self creatLabelTextColor:text_Color2 Font:kFont_12];
    leftL.text = left;
    rightL.text = right;
    [view addSubview:leftL];
    [view addSubview:rightL];

    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.centerY.equalTo(view);
//        make.right.equalTo(rightL.mas_left).offset(-8);
        make.width.mas_equalTo((kScreen_width- 20)/2-20);
    }];
    [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-6);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
