//
//  XLESelGoodAtCourseViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLESelGradeViewController.h"

@interface XLESelGradeViewController ()
{

    UITableView *gradeTableView;
}
@end

@implementation XLESelGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSArray *)grades
{
    static NSArray *gradeArray;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gradeArray = @[@"高三",@"高二",@"高一",
                       @"初三",@"初二",@"初二",
                       @"六年级",@"五年级",@"四年级",@"三年级",@"二年级",@"一年级"];
    });
    
    return gradeArray;
}

-(void)initView
{
    self.selectedRow = -1;self.selectedSection = -1;
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"年级" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
   
//    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    backBtn.frame = CGRectMake(30, 20, 60, 44);
//    backBtn.tag = 1;
//    //    backBtn.titleLabel.text = @"push";
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [backBtn setTitle:@"个人信息" forState:(UIControlStateNormal)];
//    [backBtn addTarget:self action:@selector(backToPrevousView:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
//    self.navigationItem.leftBarButtonItem = (UIBarButtonItem *)backBtn;
    
//    tableViewData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"头像＊",@"",@"名字＊",@"",@"性别＊",@"",@"家庭住址＊",@"",@"生日",@"",@"爱好",@"",@"个人简介",@"",@"所在学校",@"",@"年级",@"",@"擅长科目",@"",@"修改密码",@"",@"退出登录", nil];
    gradeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, self.view.frame.size.height - (IOSNAVIGATIONSIZE)) style:(UITableViewStyleGrouped)];
    gradeTableView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
//    self.tabBarController.tabBarController.view.hidden = YES;
    gradeTableView.delegate=self;
    gradeTableView.dataSource=self;
    
    [self.view addSubview:gradeTableView];
    
}

-(void)backToPrevousView:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setGrade:)] && self.selectedRow >= 0 && self.selectedSection >= 0) {
        NSArray *grade = [[self class] grades];        
        [self.delegate setGrade:[grade objectAtIndex:(self.selectedSection * 3 + self.selectedRow)]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-UITableViewCell方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 3;
    }
    else
        return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, self.view.frame.size.width, 30);
    //    label.backgroundColor = [UIColor clearColor];
    //    label.textColor = [UIColor colorWithHue:(136.0/360.0)  // Slightly bluish green
    //                                 saturation:1.0
    //                                 brightness:0.60
    //                                      alpha:1.0];
    label.textColor = RGBACOLOR(160, 160, 160, 1);
    //    label.shadowColor = [UIColor whiteColor];
    //    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:12];
    if (section == 0) {
        label.text = @"高中";
    } else if(section == 1){
        label.text = @"初中";
    }else
    {
        label.text = @"小学";
    }
    
    [view addSubview:label];
    
    return  view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSArray *gradeArray = [[self class] grades];
    NSString *title = [gradeArray objectAtIndex:(indexPath.section * 3 + indexPath.row)];
    
   cell=[gradeTableView dequeueReusableCellWithIdentifier:title];
    if (nil==cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:title];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        cell.textLabel.text = title;
    }
    if (indexPath.row == self.selectedRow && indexPath.section == self.selectedSection) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    self.selectedSection = indexPath.section;
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
