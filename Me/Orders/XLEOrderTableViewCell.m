//
//  XLEOrderTableViewCell.m
//  XLEducation
//
//  Created by xiliedu on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEOrderTableViewCell.h"

@implementation XLEOrderTableViewCell

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
        [self initFixedControll];
        [self initDynamicControll];
    }
    return self;
}

-(void)initFixedControll
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, screenWidth - 20, 1.5)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self addSubview:splitLine];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, ORDER_CELL_HEIGHT - 40, screenWidth - 20, 1.5)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self addSubview:splitLine];
    
     UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(80, 58, 58, 13)];
    title.text = @"购买课程";
    title.textColor = RGBACOLOR(163, 163, 163, 1);
    title.font = [UIFont systemFontOfSize:13];
    [self addSubview:title];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 25,10)];
    title.text = @"总价:";
    title.textColor = RGBACOLOR(159, 159, 159, 1);
    title.font = [UIFont systemFontOfSize:10];
    [self addSubview:title];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(0, ORDER_CELL_HEIGHT - 4, screenWidth, 4)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self addSubview:splitLine];
}

-(void)initDynamicControll
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    _orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, screenWidth - 20, 20)];
    _orderTimeLabel.font = [UIFont systemFontOfSize:9];
    [self addSubview:_orderTimeLabel];
    
    _teacherHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 33, 60, 60)];
    self.teacherHead.layer.masksToBounds = YES;
    self.teacherHead.layer.cornerRadius = 30;
    self.teacherHead.layer.borderColor = [UIColor whiteColor].CGColor;
    self.teacherHead.layer.borderWidth = 3.0f;
    self.teacherHead.layer.shouldRasterize = YES;
    self.teacherHead.clipsToBounds = YES;
    [self addSubview:_teacherHead];
    
    _teacherName = [[UILabel alloc] initWithFrame:CGRectMake(80, 32, 140, 18)];
    _teacherName.textColor = [UIColor blackColor];
    _teacherName.font = [UIFont systemFontOfSize:17];
    [self addSubview:_teacherName];
    
    _courselabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 78, 140, 14)];
    _courselabel.textColor = [UIColor blackColor];
    _courselabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_courselabel];
    
    _totalPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 115, 140, 18)];
    _totalPricelabel.textColor = RGBACOLOR(252, 105, 0, 1);
    _totalPricelabel.font = [UIFont systemFontOfSize:17];
    _totalPricelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_totalPricelabel];
    
    _orderprocessLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 10 - 88, 35, 88, 16)];
    _orderprocessLabel.textColor = RGBACOLOR(95, 95, 95, 1);
    _orderprocessLabel.font = [UIFont systemFontOfSize:15];
    _orderprocessLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_orderprocessLabel];
    
    _pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 10 - 140, 64, 140, 12)];
    _pricelabel.textColor = RGBACOLOR(95, 95, 95, 1);
    _pricelabel.font = [UIFont systemFontOfSize:11];
    _pricelabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_pricelabel];
    
    _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - 10 - 70, 80, 70, 12)];
    _amountLabel.textColor = RGBACOLOR(95, 95, 95, 1);
    _amountLabel.font = [UIFont systemFontOfSize:11];
    _amountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_amountLabel];
    
    _payOrInviteCourseBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - 10 - 90, 108, 90, 28)];
    [self addSubview:_payOrInviteCourseBtn];
}

@end
