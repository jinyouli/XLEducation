//
//  AllLogView.m
//  XLEducation
//
//  Created by kin on 15/3/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AllLogView.h"
#import "ScoreTableViewCell.h"

@implementation AllLogView

@synthesize AllLogTableView,activityView,tishiLable,cpHeaderView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        ErrorProtion = [[RetureError alloc]init];
        self.AllLogArray = [[NSMutableArray alloc]init];
        
        
        self.AllLogTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, (Screen_Width), self.frame.size.height+60)];
        //    self.AllLogTableView.hidden = YES;
        self.AllLogTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.AllLogTableView.delegate=self;
        self.AllLogTableView.dataSource=self;
        self.AllLogTableView.hidden = YES;
        self.AllLogTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        if (_cprefreshHeaderView == nil)
        {
            self.cpHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f,self.frame.size.height, self.frame.size.width, 60)];
            self.cpHeaderView.delegate = self;
            _cprefreshHeaderView = self.cpHeaderView;
        }
        [_cprefreshHeaderView refreshLastUpdatedDate];
        
        
        [self addSubview:self.AllLogTableView];
        
        self.tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80,Screen_Width, 45)];
        self.tishiLable.text = @"亲！暂时没有数据〜〜";
        self.tishiLable.hidden = YES;
        self.tishiLable.textColor = [UIColor grayColor];
        self.tishiLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tishiLable];
        
        activityView = [[PlayCustomActivityView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        activityView.center = self.center;
        [activityView setTipsText:@"正在加载数据..."];
        [activityView starActivity];
        [self addSubview:activityView];
        pageNumber=1;
        [self XLNetWorkQuestURL:pageNumber];
        
        
    }
    return self;
}
- (void)reloadTableViewDataSource{
    //    pageNumber++;
    //    [self XLNetWorkQuestURL:pageNumber];
    //    _reloading = YES;
    
    if (totalPage >= pageNumber) {
        pageNumber++;
        DBG(@"========pageNumber======%d",pageNumber);
        if (pageNumber > totalPage) {
            if (totalyu > 0) {
                pagesizeNumber = totalyu;
            }
        }
        [self XLNetWorkQuestURL:pageNumber];
        _reloading = YES;
    }
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_cprefreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_cprefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.AllLogTableView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_cprefreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

-(void)XLNetWorkQuestURL:(int)newPageNumber
{
    __block NSDictionary * jsonDictionary;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        jsonDictionary = [XLQuestWork XLNetworkRequests:[NSString stringWithFormat:@"%@booking/commentsummary?pagesize=20&page=%d&PHPSESSID=%@&cp=2",XLNETWORKREQUESTSURLDomain,newPageNumber,IPHNOEPHPSESSID]];
        
        NSLog(@"日志：%@",[NSString stringWithFormat:@"%@booking/commentsummary?pagesize=20&page=%d&PHPSESSID=%@&cp=2",XLNETWORKREQUESTSURLDomain,newPageNumber,IPHNOEPHPSESSID]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"sessionId:%@",IPHNOEPHPSESSID);
            DBG(@"===jsonDictionary===AllLogArray===%@",jsonDictionary);
            if ([[jsonDictionary objectForKey:@"ret"] integerValue]==0) {
                
                if (![[jsonDictionary objectForKey:@"datas"] isEqual:@""]) {
                    
                    NSMutableArray *teachDataArray = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"content"];
                    self.dicOfScore = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"score"];
                    
                    int data_total = [[[jsonDictionary objectForKey:@"datas"]  objectForKey:@"data_total_num"] intValue];
                    totalPage = data_total/ 20;
                    totalyu = data_total % 20;
                    if (newPageNumber == 1 && [self.AllLogArray count] > 0) {
                        [self.AllLogArray removeAllObjects];
                    }
                    
                    for (int i = 0; i < [teachDataArray count]; i++)
                    {
                        [self.AllLogArray addObject:[teachDataArray objectAtIndex:i]];
                    }
                    DBG(@"=====self.AllLogArray=====%@",self.AllLogArray);
                    if ([self.AllLogArray count] == 0)
                    {
                        self.AllLogTableView.hidden = YES;
                        self.tishiLable.hidden = NO;
                        ScoreView.hidden = YES;
                    }
                    else
                    {
                        if ([self.AllLogArray count] >= (Screen_EGONUBER)){
                            self.AllLogTableView.hidden = NO;
                            self.tishiLable.hidden = YES;
                            self.AllLogTableView.tableFooterView = self.cpHeaderView;
                        }
                        else{
                            self.AllLogTableView.hidden = NO;
                            self.cpHeaderView.hidden = YES;
                            self.tishiLable.hidden = YES;
                        }
                        ScoreView = [[XLscoreView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 100) LscoreView:self.dicOfScore];
                        ScoreView.backgroundColor = [UIColor whiteColor];
                        self.AllLogTableView.tableHeaderView = ScoreView;
                        
                        [activityView performSelector:@selector(endActivity) withObject:activityView afterDelay:0.7];
                        [activityView removeFromSuperview];
                        [self.AllLogTableView reloadData];
                    }
                }
            }else{
                self.AllLogTableView.hidden = YES;
                self.tishiLable.hidden = NO;
                ScoreView.hidden = YES;
                if ([[jsonDictionary objectForKey:@"ret"] integerValue] !=10003) {
                    NSString *stringError = [ErrorProtion retureErrorquest:[NSString stringWithFormat:@"%ld",(long)[[jsonDictionary objectForKey:@"ret"] integerValue]]];
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:stringError delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
            [activityView performSelector:@selector(endActivity) withObject:activityView afterDelay:0.7];
            [activityView removeFromSuperview];
            [self.AllLogTableView reloadData];
            
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.AllLogArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreTableViewCell *cellone=(ScoreTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cellone.UserImageView1.frame.origin.y+cellone.UserImageView1.frame.size.height+10;
    
}
- (ScoreTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableViewCell *cell = nil;
    static NSString *indenty=@"cell";
    //    XLCustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
    if (nil==cell)
    {
        cell=[[ScoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    if ([self.AllLogArray count] > 0) {
        NSString *bookinggrade = [[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"grade"];
        NSString *bookingcourse = [[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"course"];
        NSString *bookdate;
        //NSString *bookingdate;

        if (![[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"bookingTime"] isEqual:[NSNull null]] ) {
            NSString *str=[[self.AllLogArray objectAtIndex:indexPath.row]  objectForKey:@"bookingTime"];//时间戳
            
            NSTimeInterval time=[str doubleValue];
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"  MM月dd日"];
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            
            bookdate = currentDateStr;
        }
        
        NSString *comment = [NSString stringWithFormat:@"%@\n%@",[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"studentCommentTitle"],[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"studentComment"]];
        
        [cell scoreTableViewCellImage:[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"teacherFace"] userNameLable:[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"teacherName"] imageNumber:[[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"studentScore"] intValue] infoLabel:[NSString stringWithFormat:@"%@%@\t%@",bookinggrade,bookingcourse,bookdate] titleLabel:[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"teacherComment"] contionLabel:comment];
    }
    return cell;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    XLCustomTableViewCell *cellone=(XLCustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cellone.comments.heigthComment;
//
//}
//- (XLCustomTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    XLCustomTableViewCell *cell = nil;
//    static NSString *indenty=@"cell";
//    //    XLCustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
//    if (nil==cell)
//    {
//     cell=[[XLCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
//    }
//    else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
//    cell.contentView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSString *dataTime = [[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"booking_time"] substringWithRange:NSMakeRange(0, 11)];
//
//    NSString *courseName = [[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"course"];
//    NSString *grade_name = [[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"grade"];
//    NSString *courName = [NSString stringWithFormat:@"科目:%@%@",grade_name,courseName];
//    NSString *class_hours = [[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"class_hours"];
//    NSString *classhour = [NSString stringWithFormat:@"%@小时",class_hours];
//
//    [cell commentImageCell:[[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"face"] commentUserNameCell:[[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"realname"] commentContionCell:[[self.AllLogArray objectAtIndex:indexPath.row] objectForKey:@"comment_teacher"] commentDataCell:dataTime commentClassCell:courName commentTimeCell:classhour];
//    return cell;
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
