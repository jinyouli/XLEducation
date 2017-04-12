//
//  XLEOrderTableViewCell.h
//  XLEducation
//
//  Created by xiliedu on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ORDER_CELL_HEIGHT 144

@interface XLEOrderTableViewCell : UITableViewCell
@property(nonatomic,retain)UILabel *orderTimeLabel;
@property(nonatomic,retain)UIImageView *teacherHead;
@property(nonatomic,retain)UILabel *teacherName;
@property(nonatomic,retain)UILabel *courselabel;
@property(nonatomic,retain)UILabel *totalPricelabel;
@property(nonatomic,retain)UILabel *pricelabel;
@property(nonatomic,retain)UILabel *amountLabel;
@property(nonatomic,retain)UIButton *payOrInviteCourseBtn;
@property(nonatomic,retain)UILabel *orderprocessLabel;

@property(nonatomic,retain)NSString *orderID;
@property(nonatomic,assign)NSInteger classHours;
@property(nonatomic,assign)NSInteger classHoursRemain;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,assign)NSInteger orderStatus;
@end
