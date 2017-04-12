//
//  AllCoursesView.h
//  XLEducation
//
//  Created by kin on 15/1/23.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "PlayCustomActivityView.h"
#import "RetureError.h"
#import "ASIHTTPRequest.h"
#import "TeacherShowsView.h"
@protocol AllCoursesdelegate <NSObject>

@optional
-(void)pushPage:(NSDictionary *)cellArray;
-(void)AllCoursespush:(int)newUmber;
-(void)seletionCoursespush;
@end

@interface AllCoursesView : UIView<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,ASIHTTPRequestDelegate,TeacherShowsdelegate,NSURLConnectionDelegate>
{
    EGORefreshTableHeaderView *_cprefreshHeaderView;
	BOOL _reloading;
    int pageNumber;
    BOOL ADDBOOL;
    
    int totalPage;
    int totalyu;
    int pagesizeNumber;
    RetureError *ErrorProtion;
    TeacherShowsView *ShowsView;
}
@property(weak,nonatomic)id<AllCoursesdelegate>delegate;
@property(retain,nonatomic)UITableView *CoureseTableView;
@property(retain,nonatomic)NSMutableArray *teachDatasArray;
@property(nonatomic,retain)EGORefreshTableHeaderView *cpHeaderView;
@property(retain,nonatomic)NSDictionary *dictionaryWeek;
@property(retain,nonatomic)PlayCustomActivityView *activityView;
@property(retain,nonatomic)UILabel *tishiLable;
@property(retain,nonatomic)NSMutableData *XLAllCoursesData;


-(void)reloadTableViewDataSource;
-(void)doneLoadingTableViewData;
-(void)oneAgenRequestWorking;

@end
