//
//  XLETransactionRecorderTableViewCell.h
//  XLEducation
//
//  Created by xiliedu on 15/2/11.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TRANSACTION_RECOREDER_ORDER_CELL_HEIGHT 74

@interface XLETransactionRecorderTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *serialNumLabel;
@property(nonatomic,retain)UILabel *timelabel;
@property(nonatomic,retain)UILabel *typeLabel;
@property(nonatomic,retain)UILabel *amountlabel;
@property(nonatomic,retain)UILabel *teacherCourseClasshourLabel;
@end
