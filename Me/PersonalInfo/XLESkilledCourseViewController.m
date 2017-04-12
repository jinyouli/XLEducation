//
//  XLESkiiledCourseViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLESkilledCourseViewController.h"
#import "XLESkillCourseTableViewCell.h"

@interface XLESkilledCourseViewController ()
{
    UITableView *courseTableView;
    BOOL cellIsSelected[9];
}
@end

@implementation XLESkilledCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
//    cellIsSelected = {NO};
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"擅长科目" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
    
//    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    backBtn.frame = CGRectMake(30, 20, 60, 44);
//    backBtn.tag = 1;
//    //    backBtn.titleLabel.text = @"push";
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [backBtn setTitle:@"个人信息" forState:(UIControlStateNormal)];
//    [backBtn addTarget:self action:@selector(backToPrevousView:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
    
    courseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, Screen_Height - 110) style:(UITableViewStyleGrouped)];
    courseTableView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    courseTableView.delegate=self;
    courseTableView.dataSource=self;
    
    [self.view addSubview:courseTableView];
}

+(NSArray *) courseAarry
{
//    static NSArray *courseAarry =
    
    static NSArray *courseAarry;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        courseAarry = @[@"语文",@"数学",@"英语",
                       @"物理",@"化学",@"生物",
                       @"历史",@"地理",@"政治"];
    });
    return courseAarry;
}

-(void)backToPrevousView:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setSkilledCourses:)]) {
        NSMutableArray *courses = [[NSMutableArray alloc] initWithCapacity:9];
        for (int i = 0; i < 9; i++) {
            if (cellIsSelected[i]) {
                [courses addObject:[[[self class] courseAarry] objectAtIndex:i]];
            }
        }
        [self.delegate setSkilledCourses:courses];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-UITableViewCell方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    return  view;
}

- (XLESkillCourseTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLESkillCourseTableViewCell *cell = nil;
    NSArray *courseArray = [[self class] courseAarry];
    NSString *title = [courseArray objectAtIndex:(indexPath.section * 3 + indexPath.row)];
    
    cell=[courseTableView dequeueReusableCellWithIdentifier:title];
    if (nil==cell)
    {
        cell=[[XLESkillCourseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:title];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        cell.courseLabel.text = title;
        
    }
    if (cellIsSelected[indexPath.section * 3 + indexPath.row]) {
        cell.checkMarkImg.image = [UIImage imageNamed:@"checked.png"];
    } else {
        cell.checkMarkImg.image = [UIImage imageNamed:@"unchecked.png"];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellIsSelected[indexPath.section * 3 + indexPath.row]) {
        cellIsSelected[indexPath.section * 3 + indexPath.row] = NO;
    } else {
        cellIsSelected[indexPath.section * 3 + indexPath.row] = YES;
    }
    [tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
