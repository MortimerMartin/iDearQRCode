//
//  SheetViewCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/16.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "SheetViewCell.h"

@interface SheetViewCell ()
{
    UIView * line;
}
@property (nonatomic , weak) UILabel * menu_name;

@end
@implementation SheetViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UILabel *(^creatLabel)() =^{
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        return label;
    };

    [self.contentView addSubview:self.menu_name = creatLabel()];

    line = [UIView new];
    line.backgroundColor = line_Color;
    [self.contentView addSubview:line];


}

-(void)setColor:(NSInteger)color{
    _color = color;
    if (color == 4) {

        line.hidden = YES;
        self.menu_name.textColor = [UIColor greenColor];
        self.menu_name.backgroundColor = back_Color;
    }else{
        self.menu_name.textColor = text_Color1;
        self.menu_name.backgroundColor = [UIColor whiteColor];
    }
};

-(void)setTitle:(NSString *)title{
    _title = title;
    self.menu_name.text = title;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.menu_name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        if (_color == 4) {
            make.bottom.equalTo(self.contentView);
        }else{
            make.bottom.equalTo(line.mas_top);
        }

    }];

    if (_color != 4) {
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
