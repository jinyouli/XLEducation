//
//  XLETeachersCommetsTableViewCell.h
//  XLEducation
//
//  Created by xiliedu on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLHEIGHT 108
@interface XLETeachersCommetsTableViewCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headImg;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UIImageView *textBackgroundView;
@property(nonatomic,retain)NSMutableArray *starIndicators;//object is UIImageView;
@property(nonatomic,retain)UILabel *courseLabel;
@property(nonatomic,retain)UILabel *dateLabel;
@property(nonatomic,retain)UILabel *commentLable;
@end
