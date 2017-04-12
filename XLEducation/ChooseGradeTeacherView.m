//
//  ChooseGradeTeacherView.m
//  XLEducation
//
//  Created by kin on 15/8/17.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "ChooseGradeTeacherView.h"
#import "GradeSubectTableViewCell.h"

@implementation ChooseGradeTeacherView

@synthesize GradeTeacherView,GradeDictionary;

-(id)initWithFrame:(CGRect)frame GradeTeacherArray:(NSMutableDictionary *)newsubjectArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *buttonView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0,(Screen_Width)-150, 45)];
        UIButton * loadButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        loadButton.frame = CGRectMake(10, 5, self.frame.size.width-20, 35);
        loadButton.layer.borderWidth = 1;
        loadButton.layer.borderColor = WORDLCOLOR.CGColor;
        loadButton.layer.masksToBounds = YES;
        loadButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [loadButton addTarget:self action:@selector(moreButton) forControlEvents:(UIControlEventTouchUpInside)];
        [loadButton setTitle:@"全部>>" forState:UIControlStateNormal];
        [loadButton setTitleColor:WORDLCOLOR forState:(UIControlStateNormal)];
        [buttonView addSubview:loadButton];
        
        DBG(@"======self.subjectArray===%@",self.GradeDictionary);
        self.GradeDictionary =newsubjectArray;
        self.GradeTeacherView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,(Screen_Width)-150, (Screen_Height)-(IOSNAVIGATIONSIZE))];
        self.GradeTeacherView.backgroundColor = [UIColor whiteColor];
        self.GradeTeacherView.delegate=self;
        self.GradeTeacherView.dataSource=self;
        self.GradeTeacherView.tableHeaderView = buttonView;
        [self addSubview:self.GradeTeacherView];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.GradeDictionary count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (GradeSubectTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indenty=@"cell";
    GradeSubectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
    if (cell==nil)
    {
        cell=[[GradeSubectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
    }
    cell.backgroundColor =  [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLable.text = [self.GradeDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate ChooseGradeTeacher:[self.GradeDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]]];
}
-(void)moreButton
{
    [self.delegate ChooseGradeTeacher:@""];
}

@end
