//
//  XLESelGoodAtCourseViewController.h
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLESetViewController.h"

@interface XLESelGradeViewController : XLESetViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic, assign)NSInteger selectedRow;
@property(nonatomic, assign)NSInteger selectedSection;

@end
