//
//  ConfirmTheDollarsView.h
//  XLEducation
//
//  Created by kin on 15/1/23.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "TeacherShowsView.h"


@protocol ConfirmTheDollarsdelegate <NSObject>

@optional
-(void)ConfirmTheDollarsdelegate:(NSString *)newTitleLable;
-(void)pushPage:(NSDictionary *)cellArray;
-(void)ConfirmTheDollars:(int)newunmber;
-(void)ConfirmTheDollarspush;

@end


@interface ConfirmTheDollarsView : UIView<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,TeacherShowsdelegate,NSURLConnectionDelegate>
{
    EGORefreshTableHeaderView *_cprefreshHeaderView;
	BOOL _reloading;
    int pageNumber;
    BOOL ADDBOOL;
    
    int totalPage;
    int totalyu;
    int pagesizeNumber;
    TeacherShowsView *ShowsView;

}
@property(weak,nonatomic)id<ConfirmTheDollarsdelegate>delegate;
@property(retain,nonatomic)UITableView *ConfirmTableView;
@property(retain,nonatomic)NSMutableArray *teachDatasArray;
@property(nonatomic,retain)EGORefreshTableHeaderView *cpHeaderView;
@property(retain,nonatomic)NSDictionary *dictionaryWeek;
@property(retain,nonatomic)UILabel *tishiLable;
@property(retain,nonatomic)NSMutableData *XLConfirmCourseData;


-(void)reloadTableViewDataSource;
-(void)doneLoadingTableViewData;
-(void)ConfirmTheDollarsOneAgenRequestWorking;




@end
