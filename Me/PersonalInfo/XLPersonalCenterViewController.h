//
//  XLPersonalCenterViewController.h
//  XLEducation
//
//  Created by kin on 15/1/22.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLEUserPersonalInfo.h"


@interface XLPersonalCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UpdatePersonInfoDelegate>

@property(nonatomic,retain)UITableView *individualAndCompanyInfo;

@property(nonatomic,retain)UIImageView *headImg;
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *account;
@property(nonatomic,retain)UIButton *editButton;

@end
