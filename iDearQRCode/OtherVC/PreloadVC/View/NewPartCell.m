//
//  NewPartCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/25.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "NewPartCell.h"
#import "NSString+Validate.h"
@interface NewPartCell ()

@property (nonatomic , strong) UILabel * part;
@property (nonatomic , strong) UIButton * deleteBtn;
@property (nonatomic , strong) UIButton * numberBtn;
@property (nonatomic , strong) UIView * line;

@end

@implementation NewPartCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupDefaultPartView];
    }
    return self;
}

-(void)setupDefaultPartView{

    UILabel * label = [UILabel new];
    label.textColor = text_Color1;
    label.font = kFont_16;
    [self.contentView addSubview:label];
    _part = label;

    UILabel * number = [UILabel new];
    number.textColor = text_Color2;
    number.font = kFont_12;
    number.text = @"数量 :";
    [self.contentView addSubview:number];

    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.tag = 11;
    [_deleteBtn setImage:[UIImage imageNamed:@"icon_delete)"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(didSelectNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];


    _numberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _numberBtn.tag = 12;
    NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:@"请选择数量"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9aa9a9"] range:titleRange];

    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [_numberBtn setAttributedTitle:title forState:UIControlStateNormal];
    _numberBtn.titleLabel.font = kFont_14;
    [_numberBtn addTarget:self action:@selector(didSelectNumber:) forControlEvents:UIControlEventTouchUpInside];
//    _numberBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_numberBtn];

   _line =  [UIView new];
    _line.backgroundColor = line_Color;
    [self.contentView addSubview:_line];

    [_part mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(6);
//        make.width.mas_equalTo(kScreen_width*3/4);
    }];

    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_part);
        make.top.equalTo(_part.mas_bottom).offset(3);
    }];

    [_numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(number.mas_right).offset(4);
//        make.bottom.equalTo(number);
        make.centerY.equalTo(number);
    }];

    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-8);
    }];

    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_part);
        make.right.equalTo(_deleteBtn);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.6);
    }];
}


-(void)setPartName:(NSString *)partName{
    _partName = partName;
    _part.text = partName;
}
-(void)setNumber:(NSString *)number{
    _number = number;

    NSString * cellNumber = number;
    if (![cellNumber validateOnlyNumber] || [cellNumber isEqualToString:@"0"]) {

        cellNumber = @"请选择数量";
    }

    NSMutableAttributedString * title = [[NSMutableAttributedString alloc] initWithString:cellNumber];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSForegroundColorAttributeName value:topView_Color range:titleRange];

    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [_numberBtn setAttributedTitle:title forState:UIControlStateNormal];

}

-(void)didSelectNumber:(UIButton *)sender{

    if (self.didSelectHandle) {
        _didSelectHandle(sender.tag,self.index);
    }
}

-(void)setIsLastCell:(BOOL)isLastCell{
    _isLastCell = isLastCell;
    if (isLastCell == YES) {
        _line.hidden = YES;
    }else{
        _line.hidden = NO;
    }

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
