//
//  CityRegionViewController.h
//  XLEducation
//
//  Created by kin on 15/7/27.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityRegionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)NSString *cityID;
@property(retain,nonatomic)NSArray *subArray;


@end
