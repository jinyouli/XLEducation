//
//  BadReviewLogView.m
//  XLEducation
//
//  Created by kin on 15/3/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "BadReviewLogView.h"

@implementation BadReviewLogView


@synthesize BadReviewArray,BadReviewTableView,tishiLable;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commentsRequest];
        self.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        self.BadReviewTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.BadReviewTableView.delegate=self;
        self.BadReviewTableView.dataSource=self;
        self.BadReviewTableView.hidden = YES;
        [self addSubview:self.BadReviewTableView];
        self.tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80,Screen_Width, 45)];
        self.tishiLable.text = @"亲！暂时没有数据〜〜";
        self.tishiLable.hidden = YES;
        self.tishiLable.textColor = [UIColor grayColor];
        self.tishiLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tishiLable];
        

    }
    return self;
}
-(void)commentsRequest
{
    __block NSDictionary * jsonDictionary;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        jsonDictionary = [XLQuestWork XLNetworkRequests:[NSString stringWithFormat:@"%@Credit/CreditList?pagesize=20&page=1&type=3&PHPSESSID=%@",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID]];
        dispatch_async(dispatch_get_main_queue(), ^{
            DBG(@"======ReviewLogArray===%@",jsonDictionary);
            if (![[jsonDictionary objectForKey:@"datas"] isEqual:@""]) {
                self.BadReviewArray =[jsonDictionary objectForKey:@"datas"];
                self.BadReviewTableView.hidden = NO;
                [self.BadReviewTableView reloadData];
                self.tishiLable.hidden = YES;
                [self.delegate BadReviewNumberInfo:[jsonDictionary objectForKey:@"data_total_num"]];

            }else
            {
                [self.delegate BadReviewNumberInfo:@"0"];
                self.tishiLable.hidden = NO;
                self.BadReviewTableView.hidden = YES;
            }
        });
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.BadReviewArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLCustomTableViewCell *cellone=(XLCustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cellone.comments.heigthComment;
    
}
- (XLCustomTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XLCustomTableViewCell *cell = nil;
    static NSString *indenty=@"cell";
    if (nil==cell)
    {
        cell=[[XLCustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.contentView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *dataTime = [[[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"booking_time"] substringWithRange:NSMakeRange(0, 11)];
    
    NSString *courseName = [[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"course"];
    NSString *grade_name = [[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"grade"];
    NSString *courName = [NSString stringWithFormat:@"科目:%@%@",grade_name,courseName];
    NSString *class_hours = [[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"class_hours"];
    NSString *classhour = [NSString stringWithFormat:@"%@小时",class_hours];
    
    [cell commentImageCell:[[[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"face"] commentUserNameCell:[[[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"realname"] commentContionCell:[[self.BadReviewArray objectAtIndex:indexPath.row] objectForKey:@"comment_teacher"] commentDataCell:dataTime commentClassCell:courName commentTimeCell:classhour];
    return cell;
}



@end
