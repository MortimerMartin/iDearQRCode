//
//  PersonTableViewCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "PersonTableViewCell.h"

@interface PersonTableViewCell ()
{
    UIView * line;
}
@property (nonatomic , weak) UILabel * left;
@property (nonatomic , weak) UILabel * right;


@end
@implementation PersonTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{

    UILabel * (^creatLabel)(CGFloat , UIColor * ) = ^(CGFloat font , UIColor * color){
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:font];
        label.textColor = color;
        return label;
    };

    [self.contentView addSubview:self.left = creatLabel(16 , text_Color2)];
    [self.contentView addSubview:self.right = creatLabel(16, text_Color1)];
    self.right.textAlignment = NSTextAlignmentRight;
    line = [UIView new];
    line.backgroundColor = line_Color;
    [self.contentView addSubview:line];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _left.text = title;
}

-(void)setContent:(NSString *)content{
    _content = content;
    _right.text = content;
}


-(void)layoutSubviews{
    [super layoutSubviews];

    [_left mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
    }];

    [_right mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(_left);
    }];

    if (_isLast != YES) {
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_left);
            make.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
