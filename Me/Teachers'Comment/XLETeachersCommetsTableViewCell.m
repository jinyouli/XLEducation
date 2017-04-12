//
//  XLETeachersCommetsTableViewCell.m
//  XLEducation
//
//  Created by xiliedu on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLETeachersCommetsTableViewCell.h"

@implementation XLETeachersCommetsTableViewCell

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
        [self initHeadAndNameView];
        [self initRigtPart];
    }
    return self;
}

-(void)initHeadAndNameView
{
    self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 30;
    self.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImg.layer.borderWidth = 3.0f;
    self.headImg.layer.shouldRasterize = YES;
    self.headImg.clipsToBounds = YES;
    [self addSubview:_headImg];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 60, (CELLHEIGHT) - 70 - 20)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = RGBACOLOR(110, 110, 110, 1);
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLabel];
}

-(void)initRigtPart
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.textBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(72, 10, screenWidth - 72 - 10, CELLHEIGHT - 20)];
    self.textBackgroundView.image = [UIImage imageNamed:@"me_comment_bg"];
    [self addSubview:_textBackgroundView];
    
    self.starIndicators = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *starIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(20 + 10 * i, 13, 9, 9)];
        [self.textBackgroundView addSubview:starIndicator];
        [_starIndicators addObject:starIndicator];
    }
    
    _courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 40, 16)];
    _courseLabel.textColor = RGBACOLOR(128, 128, 128, 1);
    _courseLabel.font = [UIFont systemFontOfSize:10];
//    _courseLabel.backgroundColor = [UIColor redColor];
    _courseLabel.textAlignment = NSTextAlignmentLeft;
    [self.textBackgroundView addSubview:_courseLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 10, 60, 16)];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    _dateLabel.textColor = RGBACOLOR(128, 128, 128, 1);
    _dateLabel.font = [UIFont systemFontOfSize:10];
//    _dateLabel.backgroundColor = [UIColor redColor];
    [self.textBackgroundView addSubview:_dateLabel];
    
    _commentLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 28, _textBackgroundView.frame.size.width - 40, _textBackgroundView.frame.size.height - 40)];
    _commentLable.textColor = [UIColor blackColor];
    _commentLable.font = [UIFont systemFontOfSize:12];
    _commentLable.numberOfLines = 0;
//    _commentLable.backgroundColor = [UIColor redColor];
    [self.textBackgroundView addSubview:_commentLable];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
