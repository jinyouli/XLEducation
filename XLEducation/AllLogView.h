//
//  AllLogView.h
//  XLEducation
//
//  Created by kin on 15/3/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetureError.h"
#import "XLscoreView.h"
#import "EGORefreshTableHeaderView.h"

@interface AllLogView : UIView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
   RetureError *ErrorProtion;
    XLscoreView *ScoreView;
    EGORefreshTableHeaderView *_cprefreshHeaderView;
    BOOL _reloading;
    int pageNumber;
    BOOL ADDBOOL;
    
    int totalPage;
    int totalyu;
    int pagesizeNumber;
}

@property(retain,nonatomic)UITableView *AllLogTableView;
@property(retain,nonatomic)NSMutableArray *AllLogArray;
@property(retain,nonatomic)NSMutableDictionary *dicOfScore;
@property(retain,nonatomic)PlayCustomActivityView *activityView;
@property(retain,nonatomic)UILabel *tishiLable;
@property(nonatomic,retain)EGORefreshTableHeaderView *cpHeaderView;

-(void)reloadTableViewDataSource;
-(void)doneLoadingTableViewData;
//-(void)oneAgenRequestWorking;



@end
