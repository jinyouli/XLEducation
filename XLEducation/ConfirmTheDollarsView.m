//
//  ConfirmTheDollarsView.m
//  XLEducation
//
//  Created by kin on 15/1/23.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "ConfirmTheDollarsView.h"
#import "MJRefresh.h"
#import "ClassNoDataCell.h"

@implementation ConfirmTheDollarsView



@synthesize ConfirmTableView,teachDatasArray,cpHeaderView,dictionaryWeek,tishiLable,XLConfirmCourseData;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        pagesizeNumber = 20;
        pageNumber=1;
        [self XLNetWorkQuestURL];
        
        ShowsView = [[TeacherShowsView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.frame.size.height)];
        ShowsView.hidden = YES;
        ShowsView.delegate = self;
        //[self addSubview:ShowsView];
        
        self.teachDatasArray = [[NSMutableArray alloc]init];
        self.dictionaryWeek = @{@"0":@"日",@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六"};
        self.ConfirmTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-120)style:(UITableViewStylePlain)];
        self.ConfirmTableView.backgroundColor = [UIColor whiteColor];
        self.ConfirmTableView.delegate=self;
        self.ConfirmTableView.dataSource=self;
        //self.ConfirmTableView.hidden = YES;
        [self addSubview:self.ConfirmTableView];
        
        self.ConfirmTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(ConfirmTheDollarsOneAgenRequestWorking)];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ConfirmTheDollarsOneAgenRequestWorking) name:@"refreshCourse" object:nil];
        
        if (_cprefreshHeaderView == nil)
        {
            self.cpHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame: CGRectMake(0.0f,self.frame.size.height, self.frame.size.width, 60)];
            self.cpHeaderView.delegate = self;
            _cprefreshHeaderView = self.cpHeaderView;
        }
        [_cprefreshHeaderView refreshLastUpdatedDate];
        
        NSString *textString = @"温馨提示：如老师在填写教学日志后24小时您仍未确认课酬，系统将自动将课酬打入老师钱包！";
        NSDictionary *dic2=@{NSFontAttributeName:teachCellFont};
        CGSize sized2=[textString boundingRectWithSize:CGSizeMake((Screen_Width), 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic2
                                               context:nil].size;
        UILabel *tkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,(Screen_Height)-110-(sized2.height), (Screen_Width), sized2.height)];
        tkLabel.backgroundColor = editioncolor;
        tkLabel.numberOfLines = 0;
        tkLabel.lineBreakMode = 0;
        tkLabel.text =textString;
        tkLabel.font = cellFont;
        tkLabel.backgroundColor = RGBACOLOR(255, 250, 225, 1);
        [self addSubview:tkLabel];
        
        //        self.tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80,Screen_Width, 45)];
        //        self.tishiLable.text = @"亲！暂时没有数据〜〜";
        //        self.tishiLable.hidden = YES;
        //        self.tishiLable.textColor = [UIColor grayColor];
        //        self.tishiLable.textAlignment = NSTextAlignmentCenter;
        //        [self addSubview:self.tishiLable];
        
        self.ConfirmTableView.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0];
        self.ConfirmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)XLNetWorkQuestURL;
{
    NSURL *url;
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"courseStatus"] isEqualToString:@""]) {
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@booking/bookinglist?pagesize=20&page=%d&statusType=%@&PHPSESSID=%@&orderId=%@",XLNETWORKREQUESTSURLDomain,pageNumber,@"3",IPHNOEPHPSESSID,[[NSUserDefaults standardUserDefaults] objectForKey:@"courseStatus"]]];

    }else{
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@booking/bookinglist?pagesize=20&page=%d&statusType=%@&PHPSESSID=%@",XLNETWORKREQUESTSURLDomain,pageNumber,@"3",IPHNOEPHPSESSID]];

    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    //    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@booking/bookinglist?pagesize=20&page=%d&status=%@&PHPSESSID=%@&sort=0",XLNETWORKREQUESTSURLDomain,pageNumber,@"3",IPHNOEPHPSESSID]]];
    //    request.delegate=self;
    //    request.tag = 40;
    //    [request startAsynchronous];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse{
    self.XLConfirmCourseData =[[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.XLConfirmCourseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self.ConfirmTableView.header endRefreshing];
    //self.ConfirmTableView.hidden = YES;
    ShowsView.hidden = NO;
    [self.delegate ConfirmTheDollars:0];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    NSString *asyReturn = [[NSString alloc] initWithData:self.XLConfirmCourseData encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[asyReturn dataUsingEncoding:(NSUTF8StringEncoding)] options:kNilOptions error:nil];
    DBG(@"=======jsonDataschool1=======%@",jsonDictionary);
    NSString *titleUnmber;
    if ([[jsonDictionary objectForKey:@"ret"] integerValue] == 0) {
        if (![[jsonDictionary objectForKey:@"datas"] isEqual:@""])
        {
            NSMutableArray *teachDataArray = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"content"];
            
            int data_total = [[[jsonDictionary objectForKey:@"datas"]  objectForKey:@"data_total_num"] intValue];
            totalPage = data_total/ 20;
            DBG(@"===totalPage==%d",totalPage);
            totalyu = data_total % 20;
            DBG(@"===totalyu==%d",totalyu);
            if (pageNumber == 1 && [self.teachDatasArray count] > 0)
            {
                [self.teachDatasArray removeAllObjects];
            }
            
            
            for (int i = 0; i < [teachDataArray count]; i++)
            {
                [self.teachDatasArray addObject:[teachDataArray objectAtIndex:i]];
            }
            if ([self.teachDatasArray count] == 0)
            {
                //self.ConfirmTableView.hidden = YES;
                ShowsView.hidden = NO;
                [self.delegate ConfirmTheDollarsdelegate:@"0"];
                
            }
            else
            {
                if ([self.teachDatasArray count] >= (Screen_EGONUBER)){
                    self.ConfirmTableView.hidden = NO;
                    self.ConfirmTableView.tableFooterView = self.cpHeaderView;
                    ShowsView.hidden = YES;
                }
                else{
                    self.ConfirmTableView.hidden = NO;
                    self.cpHeaderView.hidden = YES;
                    ShowsView.hidden = YES;
                }
                titleUnmber = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"data_total_num"];
                
                [self.delegate ConfirmTheDollarsdelegate:titleUnmber];
            }
        }else
        {
            self.teachDatasArray = [[NSMutableArray alloc] init];
            //self.ConfirmTableView.hidden = YES;
            ShowsView.hidden = NO;
            [self.delegate ConfirmTheDollarsdelegate:@"0"];
            
        }
    }else{
        
        self.teachDatasArray = [[NSMutableArray alloc] init];
        //self.ConfirmTableView.hidden = YES;
        ShowsView.hidden = NO;
        [self.delegate ConfirmTheDollarsdelegate:@"0"];
    }
    [self.ConfirmTableView.header endRefreshing];
    [self.delegate ConfirmTheDollars:1];
    [self.ConfirmTableView reloadData];
    
    
}
//-(void)requestStarted:(ASIHTTPRequest *)request
//{
//
//}
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//
//    if (request.tag == 40) {
//        NSDictionary * jsonDictionary;
//        jsonDictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:nil];
//        DBG(@"===jsonDictionary4444==%@",jsonDictionary);
//
//        NSString *titleUnmber;
//        if ([[jsonDictionary objectForKey:@"ret"] integerValue] == 0) {
//            if (![[jsonDictionary objectForKey:@"datas"] isEqual:@""])
//            {
//                NSMutableArray *teachDataArray = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"content"];
//
//                int data_total = [[[jsonDictionary objectForKey:@"datas"]  objectForKey:@"data_total_num"] intValue];
//                totalPage = data_total/ 20;
//                DBG(@"===totalPage==%d",totalPage);
//                totalyu = data_total % 20;
//                DBG(@"===totalyu==%d",totalyu);
//                if (pageNumber == 1 && [self.teachDatasArray count] > 0)
//                {
//                    [self.teachDatasArray removeAllObjects];
//                }
//
//
//                for (int i = 0; i < [teachDataArray count]; i++)
//                {
//                    [self.teachDatasArray addObject:[teachDataArray objectAtIndex:i]];
//                }
//                if ([self.teachDatasArray count] == 0)
//                {
//                    self.ConfirmTableView.hidden = YES;
//                    ShowsView.hidden = NO;
//                    [self.delegate ConfirmTheDollarsdelegate:@"0"];
//
//                }
//                else
//                {
//                    if ([self.teachDatasArray count] >= (Screen_EGONUBER)){
//                        self.ConfirmTableView.hidden = NO;
//                        self.ConfirmTableView.tableFooterView = self.cpHeaderView;
//                        ShowsView.hidden = YES;
//                    }
//                    else{
//                        self.ConfirmTableView.hidden = NO;
//                        self.cpHeaderView.hidden = YES;
//                        ShowsView.hidden = YES;
//                    }
//                    titleUnmber = [[jsonDictionary objectForKey:@"datas"] objectForKey:@"data_total_num"];
//
//                    [self.delegate ConfirmTheDollarsdelegate:titleUnmber];
//                }
//            }else
//            {
//                self.ConfirmTableView.hidden = YES;
//                ShowsView.hidden = NO;
//                [self.delegate ConfirmTheDollarsdelegate:@"0"];
//
//            }
//        }else{
//
//            self.ConfirmTableView.hidden = YES;
//            ShowsView.hidden = NO;
//            [self.delegate ConfirmTheDollarsdelegate:@"0"];
//        }
//    }
//    [self.ConfirmTableView.header endRefreshing];
//    [self.delegate ConfirmTheDollars:1];
//    [self.ConfirmTableView reloadData];
//}
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    [self.ConfirmTableView.header endRefreshing];
//    self.ConfirmTableView.hidden = YES;
//    ShowsView.hidden = NO;
//    [self.delegate ConfirmTheDollars:0];
//
//}
-(void)TeacherShowsPush
{
    [self.delegate ConfirmTheDollarspush];
}
-(NSString *)getAppLibCaches{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    return cachePath;
}


- (void)reloadTableViewDataSource{
    
    if (totalPage >= pageNumber)
    {
        pageNumber++;
        DBG(@"========pageNumber======%d",pageNumber);
        if (pageNumber > totalPage) {
            if (totalyu > 0) {
                pagesizeNumber = totalyu;
            }
        }
        [self XLNetWorkQuestURL];
        _reloading = YES;
    }
    
}
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_cprefreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.ConfirmTableView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_cprefreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
#pragma mark-UITableViewCell方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.teachDatasArray.count > 0) {
        return [self.teachDatasArray count];
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_cprefreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.teachDatasArray.count > 0) {
        return 120;
    }else{
        return Screen_Height-100;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.teachDatasArray count] > 0) {
        static NSString *indenty=@"cell";
        XLCustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
        if (nil==cell)
        {
            cell=[[XLCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
        cell.teacherNameLabel.text = [[self.teachDatasArray objectAtIndex:indexPath.section] objectForKey:@"teacherName"];
        
        NSString *status_name =[[self.teachDatasArray objectAtIndex:indexPath.section] objectForKey:@"grade"];
        NSString *course_name =[[self.teachDatasArray objectAtIndex:indexPath.section] objectForKey:@"course"];
        cell.subjectLabel.text = [status_name stringByAppendingString:course_name];
        
        NSString *updateStr=[[self.teachDatasArray objectAtIndex:indexPath.section]  objectForKey:@"updateTime"];//时间戳
        
        NSTimeInterval updateTime=[updateStr doubleValue];
        NSDate *update=[NSDate dateWithTimeIntervalSince1970:updateTime];
        NSDateFormatter *updateFormatter = [[NSDateFormatter alloc] init];
        [updateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *updateDateStr = [updateFormatter stringFromDate: update];
        
        cell.updateLabel.text = updateDateStr;
        
        cell.classLengthLabel.text = [NSString stringWithFormat:@"%@课时",[[self.teachDatasArray objectAtIndex:indexPath.section]  objectForKey:@"classHours"]];
        
        NSString *status = [[self.teachDatasArray objectAtIndex:indexPath.section] objectForKey:@"statusType"];
        NSLog(@"确认课酬状态：%@",status);
        NSArray *arrayOfStatus = [NSArray arrayWithObjects:@"已完成",@"待确认",@"待上课",@"待确认课酬",@"已取消",@"已取消",@"已取消",@"申诉中", nil];
        
        int index = [status integerValue]%8;
        
        cell.classLabel.text = [arrayOfStatus objectAtIndex:[status integerValue]%8];
        
        
        if (index == 0) {
            cell.classLabel.textColor = [UIColor colorWithRed:124.0f/255.0f green:178.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
        }else if (index == 1 || index == 3) {
            cell.classLabel.textColor = [UIColor orangeColor];
        }else if (index == 2) {
            cell.classLabel.textColor = [UIColor colorWithRed:75.0f/255.0f green:190.0f/255.0f blue:225.0f/255.0f alpha:1.0f];
        }else if (index == 4 || index == 5 || index == 6) {
            cell.classLabel.textColor = [UIColor lightGrayColor];
        }
        
        NSString *str=[[self.teachDatasArray objectAtIndex:indexPath.section]  objectForKey:@"bookingTime"];//时间戳
        
        NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        
        cell.dateLabel.text = currentDateStr;
        
        NSString *faceString = [[self.teachDatasArray objectAtIndex:indexPath.section]  objectForKey:@"teacherFace"];
        NSString *sexString = [[[self.teachDatasArray objectAtIndex:indexPath.section]  objectForKey:@"teacherInfo"] objectForKey:@"sex"];
        
        if ([faceString length] > 0) {
            cell.LogoImageView.urlString = faceString;
        }else{
            if ([sexString intValue] == 1)
            {
                cell.LogoImageView.urlString =@"http://oss.new.968666.net/face/default/face_male.jpg";
            }
            else
            {
                cell.LogoImageView.urlString = @"http://oss.new.968666.net/face/default/face_female.jpg";
            }
        }
        return cell;
        
    }else{

        static NSString *cellIdentify=@"ClassNoDataCell";
        ClassNoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (nil==cell)
        {
            cell=[[ClassNoDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.teachDatasArray.count > 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate pushPage:[self.teachDatasArray objectAtIndex:indexPath.section]];
    }
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}
-(void)ConfirmTheDollarsOneAgenRequestWorking
{
    pageNumber = 1;
    [self XLNetWorkQuestURL];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
