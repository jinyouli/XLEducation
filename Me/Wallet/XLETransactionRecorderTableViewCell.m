//
//  XLETransactionRecorderTableViewCell.m
//  XLEducation
//
//  Created by xiliedu on 15/2/11.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLETransactionRecorderTableViewCell.h"

@implementation XLETransactionRecorderTableViewCell

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
        [self initControll];
    }
    return self;
}

-(void)initControll
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    _serialNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, screenWidth - 20, 20)];
    _serialNumLabel.font = [UIFont systemFontOfSize:10];
    _serialNumLabel.textColor = RGBACOLOR(164, 164, 164, 1);
//    _serialNumLabel.backgroundColor = [UIColor greenColor];
    [self addSubview:_serialNumLabel];
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, screenWidth - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self addSubview:splitLine];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 200, 15)];
    _typeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_typeLabel];
    
    _timelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 100, 10)];
    _timelabel.font = [UIFont systemFontOfSize:10];
    _timelabel.textColor = RGBACOLOR(181, 181, 181, 1);
    [self addSubview:_timelabel];
    
    _amountlabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 200, 28, screenWidth - 20 - 200, 15)];
    _amountlabel.font = [UIFont systemFontOfSize:15];
    _amountlabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_amountlabel];
    
    _teacherCourseClasshourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 100, 50, screenWidth - 20 - 100, 10)];
    _teacherCourseClasshourLabel.font = [UIFont systemFontOfSize:10];
    _teacherCourseClasshourLabel.textColor = RGBACOLOR(114, 114, 114, 1);
    _teacherCourseClasshourLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_teacherCourseClasshourLabel];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(0, TRANSACTION_RECOREDER_ORDER_CELL_HEIGHT - 4, screenWidth, 4)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self addSubview:splitLine];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
