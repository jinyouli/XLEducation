//
//  XLEGenderViewController.h
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLESetViewController.h"

@interface XLEGenderViewController : XLESetViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)NSInteger selectedRow;

@end
