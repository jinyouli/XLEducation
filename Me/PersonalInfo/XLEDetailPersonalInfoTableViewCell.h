//
//  XLEDetailPersonalInfoTableViewCell.h
//  XLEducation
//
//  Created by xiliedu on 15/1/28.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLEDetailPersonalInfoTableViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *title;
//@property(nonatomic,retain)UIImageView *tipImg;
@property(nonatomic,retain)UIImageView *headImg;
@property(nonatomic,retain)UILabel *value;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isHeadIconCell:(BOOL)isHeadIconCell;
@end
