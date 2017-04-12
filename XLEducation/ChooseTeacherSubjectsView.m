//
//  ChooseTeacherSubjectsView.m
//  XLEducation
//
//  Created by kin on 15/8/17.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "ChooseTeacherSubjectsView.h"

@implementation ChooseTeacherSubjectsView

@synthesize ChooseTeacherTableView,ChooseView,TeacherSubjectArray,cellArray;

-(id)initWithFrame:(CGRect)frame ChooseTeacherSubjectsArray:(NSMutableDictionary *)newsubjectDictionary
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cellArray = [[NSMutableArray alloc]init];
        cellBool = YES;
        self.TeacherSubjectArray = newsubjectDictionary;
        self.ChooseTeacherTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 150, (Screen_Height))style:(UITableViewStylePlain)];
        self.ChooseTeacherTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        self.ChooseTeacherTableView.delegate=self;
        self.ChooseTeacherTableView.dataSource=self;
        [self addSubview:self.ChooseTeacherTableView];
        
        self.ChooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 45)];
        self.ChooseView.backgroundColor = [UIColor whiteColor];
        UILabel *moveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 3, 45)];
        moveLabel.backgroundColor = WORDLCOLOR;
        [self.ChooseView addSubview:moveLabel];
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.TeacherSubjectArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indenty=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
    }
    cell.backgroundColor =  RGBACOLOR(238, 238, 238, 1);
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 45)];
    cellView.backgroundColor = [UIColor whiteColor];
    UILabel *moveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 3, 45)];
    moveLabel.backgroundColor = WORDLCOLOR;
    [cellView addSubview:moveLabel];
    cell.selectedBackgroundView = cellView;
    cell.textLabel.text = [self.TeacherSubjectArray objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    if (indexPath.row == 0 && cellBool == YES)
    {
        cell.backgroundView = self.ChooseView;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [tableView visibleCells];
    for (UITableViewCell *cell in array) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        cell.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        [self.ChooseView removeFromSuperview];
        cellBool = NO;
    }
    [self.delegate ChooseTeacherSubjects:[self.TeacherSubjectArray objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]];
}
@end
