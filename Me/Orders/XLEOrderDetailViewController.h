//
//  XLEOrderDetailViewController.h
//  XLEducation
//
//  Created by xiliedu on 15/2/9.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLEViewOrderRequest.h"

@interface XLEOrderDetailViewController : UIViewController<HandleRequestDelegat>
@property(nonatomic,retain)NSString *orderIDStr;
@property(nonatomic,assign)NSInteger classHours;
@property(nonatomic,assign)NSInteger classHoursRemain;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,assign)NSInteger orderStatus;

@property(nonatomic,retain)NSString *orderTimeStr;
@property(nonatomic,retain)UIImage *teacherHeadImage;
@property(nonatomic,retain)NSString *teacherNameStr;
@property(nonatomic,retain)NSString *coureStr;
@property(nonatomic,retain)NSString *teacherPhone;
@end
