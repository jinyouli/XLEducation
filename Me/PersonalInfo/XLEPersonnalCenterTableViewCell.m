//
//  XLEPersonnalCenterTableViewCell.m
//  XLEducation
//
//  Created by xiliedu on 15/1/27.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEPersonnalCenterTableViewCell.h"

@implementation XLEPersonnalCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.frame.size.width - 100, 40)];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor grayColor];
        self.title.font = [UIFont systemFontOfSize:15];
        [self addSubview:_title];
        
//        self.tipImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 55, 5, 70, 70)];
//        self.tipImg.clipsToBounds = YES;
//        [self addSubview:_tipImg];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;        
    }
    return self;
}
@end
