//
//  XLEDetailPersonalInfoTableViewCell.m
//  XLEducation
//
//  Created by xiliedu on 15/1/28.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEDetailPersonalInfoTableViewCell.h"

@implementation XLEDetailPersonalInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isHeadIconCell:(BOOL)isHeadIconCell
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        if (isHeadIconCell) {
            self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.frame.size.height )/2, 100, 40)];
            
            self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - 50 - 50, (self.frame.size.height - 38)/2, 64, 64)];
            self.headImg.layer.masksToBounds = YES;
            self.headImg.layer.cornerRadius = 32;
            self.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
            self.headImg.layer.borderWidth = 3.0f;
            self.headImg.layer.shouldRasterize = YES;
            self.headImg.clipsToBounds = YES;
            [self addSubview:_headImg];
        } else {
            self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.frame.size.height - 40)/2, 100, 40)];
            self.value = [[UILabel alloc] initWithFrame:CGRectMake(120, (self.frame.size.height - 40)/2, screenWidth - 120 - 40, 40)];
        }
        self.value.textAlignment = NSTextAlignmentRight;
        self.value.textColor = RGBACOLOR(130, 130, 130, 1);
        self.value.font = [UIFont systemFontOfSize:13];
        
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor blackColor];
        self.title.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:_title];
        [self addSubview:_value];
        
//        self.tipImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 55, 5, 70, 70)];
//        self.tipImg.clipsToBounds = YES;
//        [self addSubview:_tipImg];
        self.highlighted = NO;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}
@end
