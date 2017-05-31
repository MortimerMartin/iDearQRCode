//
//  BaseTableViewCell.m
//  iDearQRCode
//
//  Created by Mortimer on 17/5/22.
//  Copyright © 2017年 Mortimer. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = back_Color;
        [self setupDefaultCell];
    }
    return self;
}

-(void)setupDefaultCell{

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
