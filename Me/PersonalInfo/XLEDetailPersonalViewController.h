//
//  XLEDetailPersonalViewController.h
//  XLEducation
//
//  Created by xiliedu on 15/1/28.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLESetViewController.h"
#import "XLEUserPersonalInfo.h"

@interface XLEDetailPersonalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SettingviewDelegate,UpdatePersonInfoDelegate>
@property(nonatomic,retain)UITableView *detailPersonalInfoTbl;
@property(nonatomic,retain) XLEUserPersonalInfo *userInfo;
@property(nonatomic,retain)NSMutableDictionary *tableViewData;
@end
