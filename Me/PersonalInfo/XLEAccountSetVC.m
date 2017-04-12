//
//  XLEAccountSetVC.m
//  XLEducation
//
//  Created by xiliedu on 15/2/14.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEAccountSetVC.h"
#import "FindPassWordViewController.h"
#import "XLUserLonginViewController.h"
#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import "XLEUserPersonalInfo.h"

@interface XLEAccountSetVC ()
{
    UITableView *TV;
}

@end

@implementation XLEAccountSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavgation];
    [self loadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadNavgation
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"账号设置" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPreviousView:) LeftButtonBool:NO];
    [self.view addSubview:navigationView];
    
    navigationView.backgroundColor = RGBACOLOR(124 , 176, 38, 1);
    
    for (UIView *subview in navigationView.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            [label setTextColor:[UIColor whiteColor]];
        }
    }
    
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
//    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    backBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 30, IOSVERSIONSIZE, 30, 44);
//    backBtn.tag = 1;
//    //    backBtn.titleLabel.text = @"push";
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [backBtn setTitle:@"提交" forState:(UIControlStateNormal)];
//    [backBtn addTarget:self action:@selector(backToPreviousView:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
}

-(void)backToPreviousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadTableView
{
    TV = [[UITableView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 10 , self.view.frame.size.width, 88)];
    TV.dataSource = self;
    TV.delegate = self;
    [self.view addSubview:TV];
    
    if ([TV respondsToSelector:@selector(setSeparatorInset:)]) {
        [TV setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([TV respondsToSelector:@selector(setLayoutMargins:)]) {
        [TV setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell=[TV dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//        cell.backgroundColor = self.view.backgroundColor;
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        switch (indexPath.row) {
            case 0:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"修改密码";
                break;
            }
            case 1:
                cell.textLabel.text = @"退出登录";
                break;
                
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self enterFindPasswordVC];
            break;
        case 1:
            [self enterLoginVC];
            break;
            
        default:
            break;
    }
}

-(void)enterFindPasswordVC
{
    FindPassWordViewController *findPwdVC = [[FindPassWordViewController alloc] init];
    
    for (UIView *subview in findPwdVC.view.subviews)
    {
        if([subview isKindOfClass:([NavigationView class])])
        {
            NavigationView *nav = (NavigationView *)subview;
            
            for (UIView *subview2 in nav.subviews) {
                if ([subview2 isKindOfClass:[UILabel class]] ) {
                    UILabel *label = (UILabel *)subview2;
                    label.text = @"修改密码";
                }
            }
        }
    }
    
    [self.navigationController pushViewController:findPwdVC animated:NO];
}

-(void)enterLoginVC
{
//    XLUserLonginViewController *loginVC = [[XLUserLonginViewController alloc] init];
//    loginVC.LongTypePush = 0;
//    [self.navigationController presentModalViewController:loginVC animated:NO];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSucceed:) name:@"LOGINYES" object:nil];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"IPHONE"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PASSWORD"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LOGINRET"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:_USER_INFO_KEY_YWJ];
    [[NSUserDefaults standardUserDefaults]synchronize];
//    exit(0);

    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToViewController:self animated:YES];
//    self.tabBarController.selectedIndex = 0;
//    self.navigationController.tabBarController.tabBar.hidden = NO;
    
//    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
//    CustomTabBarController *tabController = (CustomTabBarController *)appDelegate.window.rootViewController;
////    tabController.selectedIndex = 0;
//    tabController.selectedViewController=[tabController.viewControllers objectAtIndex:0];
//    tabController.tabBar.hidden = YES;
}

-(void)loginSucceed:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"LOGINYES"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void) dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [super dealloc];
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
