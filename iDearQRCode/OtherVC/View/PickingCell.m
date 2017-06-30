//
//  PickingCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/17.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PickingCell.h"
#import "PickingModel.h"
#import "UIImage+Common.h"
#import "UIView+CornerView.h"
@interface PickingCell ()
{
    UIView * _topView;
    CGFloat name_width;
    CGFloat do_width;

}
@property (nonatomic , strong) UIView * bakcView;
@property (nonatomic , strong) UIImageView * head;
@property (nonatomic , weak) UILabel * name_label;
@property (nonatomic , weak) UILabel * do_label;
@property (nonatomic , weak) UILabel * join_label;
@property (nonatomic , strong) UIButton * selectBtn;

@property (nonatomic , assign) selectCellType selectCell;

@property (nonatomic , strong) UIView * LabelView;



@end
@implementation PickingCell



//+(instancetype)instancedCell:(UITableView *)tableview{
//
//
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = back_Color;
        [self setupDefaultUI];

    }
    return self;
}

-(void)setupDefaultUI{
    _bakcView = [UIView new];
    _bakcView.layer.borderColor = line_Color.CGColor;
    _bakcView.layer.borderWidth = 0.5f;
    _bakcView.layer.cornerRadius = 5.0f;
    _bakcView.layer.masksToBounds = YES;




    _bakcView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bakcView];

    UIView * top = [UIView new];
    top.backgroundColor = [UIColor greenColor];
    [_bakcView addSubview:top];
    _topView = top;

    _head = [[UIImageView alloc] init];
//    _head.image = [UIImage imageNamed:@"btn_combine"];
    _head.layer.cornerRadius = 15.0f;
    _head.layer.masksToBounds = YES;
//    _head.layer.mask = [_head getCornerView];

//    _head.backgroundColor = [UIColor orangeColor];
    [_bakcView addSubview:_head];

    UILabel * (^creatLabel)(UIColor * color,CGFloat font) = ^(UIColor * color,CGFloat font){
        UILabel * label = [UILabel new];
        label.textColor = color;
        label.font = [UIFont systemFontOfSize:font];
        return label;
    };

    [_bakcView addSubview:self.name_label = creatLabel(text_Color1,14) ];
    [_bakcView addSubview:self.do_label = creatLabel(text_Color1,14)];
    [_bakcView addSubview:self.join_label = creatLabel(text_Color3,14)];

    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [_selectBtn setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.hidden = YES;
    [_bakcView addSubview:_selectBtn];

    _LabelView = [UIView new];
    [_bakcView addSubview:_LabelView];

    [_bakcView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(5);//+10
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];

    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_bakcView);
        make.height.mas_equalTo(20);//+20
    }];

    [_head mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(10);//+10
        make.left.equalTo(_bakcView).offset(8);
        make.height.width.mas_equalTo(30);//+30
    }];


    [_name_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_head).offset(-3);
        make.left.equalTo(_head.mas_right).offset(5);
//        make.width.mas_equalTo(kScreen_width/2);
    }];

    [_do_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_name_label);
        make.left.equalTo(_name_label.mas_right).offset(5);

    }];

    [_join_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_head).offset(3);
        make.left.equalTo(_name_label);
        make.right.equalTo(_bakcView).offset(-8);
    }];

    [_selectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_head);
        make.centerY.equalTo(_head);
        make.right.equalTo(_bakcView).offset(-8);
        make.width.height.mas_equalTo(42);
    }];
    [_LabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_head.mas_bottom).offset(6);
        make.bottom.equalTo(_bakcView);
        make.right.equalTo(_bakcView).offset(-8);
        make.left.equalTo(_head);
     
    }];


}



-(void)setPickModel:(PickingModel *)pickModel{
    _pickModel = pickModel;

    [_head sd_setImageWithURL:[NSURL URLWithString:pickModel.URL] placeholderImage:[UIImage imageNamed:@""]];

//    [_head sd_setImageWithURL:[NSURL URLWithString:pickModel.URL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        
////        [image circleImage];
//    }];
    _name_label.text = pickModel.pickId;
    _do_label.text = pickModel.doSometing;
    _join_label.text = pickModel.join_time;
//    self.selectBtn.selected = pickModel.select;
//    self.selectType = pickModel.type ? (selectCellType)pickModel.type : selectCellNormal;

    for (UIView *view in _LabelView.subviews) {
        [view removeFromSuperview];
    }

    if (pickModel.count>0) {

        UILabel * (^creatLabel)(NSString * text ,UIColor * color,CGFloat font) = ^(NSString * text ,UIColor * color,CGFloat font){
            UILabel * label = [UILabel new];
            label.text = text;
            label.textColor = color;
            label.font = [UIFont systemFontOfSize:font];
            return label;
        };


        CGFloat spaceH = 8;
        CGFloat lastSpaceH = 8;
        CGFloat labH = 16;

        for (int i = 0; i < pickModel.count; i++) {
            if (i < 3) {
                UILabel * leftLabel = creatLabel(pickModel.name,[UIColor redColor],16);
                [_LabelView addSubview:leftLabel];

                UILabel * rightLabel = creatLabel(pickModel.doSometing,[UIColor redColor],16);
                rightLabel.textAlignment = NSTextAlignmentRight;
                [_LabelView addSubview:rightLabel];

                CGSize rightSize =  kGetTEXTSIZE(rightLabel.text, [UIFont systemFontOfSize:16]);

                [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i *(spaceH + labH));
                    make.left.equalTo(_LabelView);
                    make.right.equalTo(rightLabel.mas_left).offset(-8);
                }];

                [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(leftLabel);

                    make.right.equalTo(_LabelView);
                    make.width.mas_equalTo(rightSize.width + 8);
                    if (i == pickModel.count -1) {
                        make.bottom.mas_equalTo(-lastSpaceH).priorityHigh();
                    }
                }];
            }else if (i == 3){
                UILabel * lastLabel = creatLabel(@"...",[UIColor blueColor],16);
                [_LabelView addSubview:lastLabel];

                [lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo( i *(spaceH + labH));
                    make.right.equalTo(_LabelView);
                    make.bottom.mas_equalTo(-lastSpaceH).priorityHigh();//把 lbaelview 变大
                }];
            }else{

                break;
            }

        }

    }


}


-(void)setSelectType:(selectCellType)selectType{
    _selectType = selectType;

    if (selectType == selectCellNormal) {
        _selectBtn.selected = NO;
//        [_selectBtn setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    }else if (selectType == selectCellDelete){
        _selectBtn.selected = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"btn_deleteNormal"] forState:UIControlStateSelected];
    }else if (selectType == selectCellCombine){

        _selectBtn.selected = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"btn_combine"] forState:UIControlStateSelected];
    }else{

    }
}


-(void)setState:(NSInteger)state{
    _state = state;
    if (state == 1) {
        self.selectCell = selectCellDelete;
        _selectBtn.hidden = NO;
    }else if(state == 2){
        self.selectCell = selectCellCombine;
        _selectBtn.hidden = NO;
    }else{
        self.selectCell = selectCellNormal;
        _selectBtn.hidden = YES;
        if (_selectBtn.selected == YES) {
            _selectBtn.selected = NO;
        }
    }
}


#pragma mark selectAction
-(void)selectAction:(UIButton *)sender{

    sender.selected = !sender.selected;


    if (sender.selected == YES) {
        if (self.selectType == selectCellDelete) {
            [sender setImage:[UIImage imageNamed:@"btn_deleteNormal"] forState:UIControlStateSelected];
        }else if (self.selectType == selectCellCombine){

            [sender setImage:[UIImage imageNamed:@"btn_combine"] forState:UIControlStateSelected];
        }else{
            
        }
        if (self.selectCellAction) {
            self.selectCellAction(self.pickModel , sender.selected ,self.selectCell,self.index);
        }
    }else{
//        [sender setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        if (self.selectType == selectCellDelete) {

        }else if (self.selectType == selectCellCombine){

        }else{
            
        }

        if (self.selectCellAction) {
            self.selectCellAction(self.pickModel , sender.selected ,selectCellNormal,self.index);
        }
    }

    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
