//
//  AllCommentsView.m
//  XLEducation
//
//  Created by kin on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AllCommentsView.h"

@implementation AllCommentsView

@synthesize AllCommentsTableView,commentsArray,tishiLable;


-(id)initWithFrame:(CGRect)frame teachingId:(NSString *)newTeachingId
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commentsRequest:newTeachingId];
        self.AllCommentsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.AllCommentsTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        self.AllCommentsTableView.delegate=self;
        self.AllCommentsTableView.hidden = YES;
        self.AllCommentsTableView.dataSource=self;
        [self addSubview:self.AllCommentsTableView];
        
        self.tishiLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80,Screen_Width, 45)];
        self.tishiLable.text = @"亲！暂时没有数据〜〜";
        self.tishiLable.hidden = YES;
        self.tishiLable.textColor = [UIColor grayColor];
        self.tishiLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tishiLable];

    }
    return self;
}
-(void)commentsRequest:(NSString *)teachingId
{
    
    __block NSDictionary * jsonDictionary;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        jsonDictionary = [XLQuestWork XLNetworkRequests:[NSString stringWithFormat:@"%@app/TeacherComment?teacher_uid=%@&page=1&pagesize=30&type=0",XLNETWORKREQUESTSURLDomain,teachingId]];
        dispatch_async(dispatch_get_main_queue(), ^{
            DBG(@"===jsonDictionary===commaaaaaa===%@",jsonDictionary);
            if (![[jsonDictionary objectForKey:@"datas"] isEqual:@""]) {
                self.commentsArray =[[jsonDictionary objectForKey:@"datas"] objectForKey:@"content"];
                [self.delegate AllCommentsdelegate:[NSString stringWithFormat:@"%ld",(unsigned long)[self.commentsArray count]]];
                self.AllCommentsTableView.hidden = NO;
                self.tishiLable.hidden = YES;
                [self.AllCommentsTableView reloadData];
            }
            else
            {
                self.tishiLable.hidden = NO;
                self.AllCommentsTableView.hidden = YES;
                [self.delegate AllCommentsdelegate:@"0"];
            }
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.commentsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLCustomTableViewCell *cellone=(XLCustomTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cellone.comments.heigthComment;
    
}
- (XLCustomTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLCustomTableViewCell *cell = nil;
    static NSString *indenty=@"cell";
//    XLCustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
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
    NSString *dataTime = [[[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"booking_time"] substringWithRange:NSMakeRange(0, 11)];
    
    NSString *courseName = [[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"course_name"];
    NSString *grade_name = [[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"grade_name"];
    NSString *courName = [NSString stringWithFormat:@"科目:%@%@",grade_name,courseName];
    NSString *class_hours = [[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"class_hours"];
    NSString *classhour = [NSString stringWithFormat:@"%@小时",class_hours];

  NSString*urlString = [NSString stringWithFormat:@"%@",[[[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"face"]];

    [cell commentImageCell:urlString commentUserNameCell:[[[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"studentInfo"] objectForKey:@"realname"] commentContionCell:[[self.commentsArray objectAtIndex:indexPath.row] objectForKey:@"comment_teacher"] commentDataCell:dataTime commentClassCell:courName commentTimeCell:classhour];
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
