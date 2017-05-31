//
//  PrereloadCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PrereloadCell.h"
#import "PrereloadCellModel.h"
#import "UIImageView+WebCache.h"
@interface PrereloadCell ()
@property (nonatomic , strong) UIView * bakcView;
@property (nonatomic , strong) UIImageView * head;
@property (nonatomic , weak) UILabel * name_label;
@property (nonatomic , weak) UILabel * do_label;
@property (nonatomic , weak) UILabel * join_label;
@property (nonatomic , strong) UIButton * selectBtn;


@property (nonatomic , strong) UIView * LabelView;


@end
@implementation PrereloadCell



-(void)setupDefaultCell{
    _bakcView = [UIView new];
    _bakcView.layer.borderColor = line_Color.CGColor;
    _bakcView.layer.borderWidth = 0.5f;
    _bakcView.layer.cornerRadius = 5.0f;
    _bakcView.layer.masksToBounds = YES;
    _bakcView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bakcView];

    UIView * top = [UIView new];
    top.backgroundColor = topView_Color;
    [_bakcView addSubview:top];
//    _topView = top;

    _head = [[UIImageView alloc] init];
    _head.layer.cornerRadius = 15.0f;
    _head.layer.masksToBounds = YES;
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


    UIView * line = [UIView new];
    line.backgroundColor = line_Color;
    [_bakcView addSubview:line];

    UILabel * label = [UILabel new];
    label.text = @"共 333 项";
    label.textColor = text_Color2;
    label.font = kFont_12;
    [_bakcView addSubview:label];


    [_bakcView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);//+10
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];

    [top mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(_bakcView);
        make.height.mas_equalTo(10);//+10
    }];

    [_head mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top.mas_bottom).offset(10);//+10
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
        make.top.equalTo(_head.mas_bottom);
        make.right.left.equalTo(_bakcView);
        make.bottom.equalTo(line.mas_top);
    }];





    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top);
        make.left.right.equalTo(_LabelView);
        make.height.mas_equalTo(0.6);
    }];







    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_LabelView).offset(-8);
        make.bottom.equalTo(_bakcView);
        make.height.mas_equalTo(20);
    }];
        



}

-(void)setPreModel:(PrereloadCellModel *)preModel{
    _preModel = preModel;
    
    [_head sd_setImageWithURL:[NSURL URLWithString:preModel.URL] placeholderImage:[UIImage imageNamed:@""]];
    _name_label.text = preModel.pickId;
    _do_label.text = preModel.doSometing;
    _join_label.text = preModel.join_time;


    for (UIView * view in _LabelView.subviews) {
        [view removeFromSuperview];
    }

    UILabel * (^creatLabel)(NSString * text , UIColor * textColor) = ^(NSString * text , UIColor * textColor){
        UILabel * label = [UILabel new];
        label.font = kFont_14;
        label.text = text;
        label.textColor = textColor;
        return label;
    };

    if (preModel.count>0) {


//        NSLog(@">>>>%ld,%ld",preModel.count,preModel.numberSometing);

        CGFloat topSpace =0;
        for (int i = 0; i<preModel.count; i++) {
            topSpace += 6;



            UILabel * label = creatLabel(preModel.Anyting,text_Color1);
            [_LabelView addSubview:label];
            UILabel * rightLabel = creatLabel(@"X 3",text_Color1);
            [_LabelView addSubview:rightLabel];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_head);
                make.top.mas_equalTo(topSpace);
                make.width.mas_equalTo((kScreen_width-20)*2/3);
            }];

            [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(label);
                make.right.equalTo(_bakcView).offset(-8);
            }];

            topSpace += 16;

            for (int j = 0; j<preModel.numberSometing; j++) {

                topSpace += 3;

                UILabel * detailLabel = creatLabel(preModel.Anyting,text_Color2);
                detailLabel.font = kFont_12;
                [_LabelView addSubview:detailLabel];

                UILabel * numLabel = creatLabel(@"X 1",text_Color2);
                numLabel.font = kFont_12;
                [_LabelView addSubview:numLabel];

                [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(label).offset(8);
                    make.top.mas_equalTo(topSpace);
                    make.width.mas_equalTo((kScreen_width-40)*2/3);
                }];

                [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(detailLabel);
                    make.right.equalTo(rightLabel);
                }];

                topSpace += 14;
            }


            if (i == preModel.count - 1) {

                if (i>0) {

                    UILabel * more = creatLabel(@"...",text_Color2);
                    [_LabelView addSubview:more];

                    [more mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(topSpace );
                        make.right.equalTo(_LabelView).offset(-8);
                    }];


                }

            }
        }



    }



}

-(void)setSelectType:(selectCellType)selectType{
    _selectType = selectType;

    if (selectType == selectCellNormal) {

        [_selectBtn setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];


    }else if (selectType == selectCellDelete){

        [_selectBtn setImage:[UIImage imageNamed:@"btn_deleteNormal"] forState:UIControlStateNormal];

    }else if (selectType == selectCellCombine){

        [_selectBtn setImage:[UIImage imageNamed:@"btn_combine"] forState:UIControlStateNormal];

    }else{

    }
}

-(void)setSenderSelect:(BOOL)senderSelect{

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

            [sender setImage:[UIImage imageNamed:@"btn_deleteNormal"] forState:UIControlStateNormal];
        }else if (self.selectType == selectCellCombine){

            [sender setImage:[UIImage imageNamed:@"btn_combine"] forState:UIControlStateNormal];
        }else{

        }
        if (self.selectCellAction) {
            self.selectCellAction(self.preModel , YES ,self.selectCell,self.index);
        }
    }else{

        [sender setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];


        if (self.selectCellAction) {
            self.selectCellAction(self.preModel , NO ,selectCellNormal,self.index);
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
