//
//  XLPersonalCenterViewController.m
//  XLEducation
//
//  Created by kin on 15/1/22.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLPersonalCenterViewController.h"
#import "XLEPersonnalCenterTableViewCell.h"
#import "XLEDetailPersonalViewController.h"
#import "XLETeachersCommentViewController.h"
#import "XLEOrderViewController.h"
#import "XLEWalletViewController.h"
#import "XLEIdeaFeedbackVC.h"
#import "XLEAccountSetVC.h"

@interface XLPersonalCenterViewController ()<XLLoginInterfacedelegate>
{
    XLLoginInterfaceView *LoginView;
    NavigationView *navigationView;
    
    XLEUserPersonalInfo *userInfoHTTPRequest;
    NSMutableDictionary *userInfoData;
}

@end

@implementation XLPersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self NavigationSetting];
    
    NSString *RetLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"LOGINRET"];
    LoginPostNotificationName;
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self NavigationSetting];
    if (![RetLogin isEqualToString:@"LOGINSUCESS"]) {
        [self ControlsGenerate];
    }else{
        [self requestUserInfo];
        [self initTopView];
        [self initMiddleTableView];
    }
}
-(void)XLUserLonginViewHidde
{
    [self initTopView];
    [self initMiddleTableView];
    LoginView.hidden = YES;
}
#pragma mark --- 登陆界面
-(void)ControlsGenerate
{
    LoginView = [[XLLoginInterfaceView alloc]initWithFrame:CGRectMake(0, navigationView.frame.origin.y+navigationView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    LoginView.delegate = self;
    LoginView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self.view addSubview:LoginView];
}

-(void)LonginInterfaced:(NSInteger)sendTag
{
    if (sendTag == 0)
    {
        RegisteredViewController *RegisteredView = [[RegisteredViewController alloc]init];
        UINavigationController *RegisteredNavigation = [[UINavigationController alloc]initWithRootViewController:RegisteredView];
        RegisteredNavigation.navigationBarHidden = YES;
        RegisteredView.typePush = 0;
        [self presentViewController:RegisteredNavigation animated:YES completion:nil];
    }
    else
    {
        XLUserLonginViewController *userLonginView = [[XLUserLonginViewController alloc] init];
        UINavigationController *userLonginNavigation = [[UINavigationController alloc]initWithRootViewController:userLonginView];
        userLonginNavigation.navigationBarHidden = YES;
        userLonginView.LongTypePush = 0;
        [self presentViewController:userLonginNavigation animated:YES completion:nil];
    }
}


-(void)requestUserInfo
{
    userInfoHTTPRequest = [[XLEUserPersonalInfo alloc] init];
    userInfoHTTPRequest.delegate = self;//update basic Info by delegate;
    userInfoData = userInfoHTTPRequest.userInfo;
    
    [userInfoHTTPRequest retrieveFromServer];
}

//+(NSMutableDictionary *) initUserInforKeys
//{
//    static NSMutableDictionary *directory;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        directory = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil,@"头像＊",@"",@"名字＊",@"",@"性别＊",@"",@"家庭住址＊",@"",@"生日",@"",@"爱好",@"",@"个人简介",@"",@"所在学校",@"",@"年级",@"",@"擅长科目",@"",@"phone",nil];
//    });
//    return directory;
//}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _name.text = [userInfoData objectForKey:_USER_NAME_KEY];
    _headImg.image = [userInfoData objectForKey:_USER_FACE_KEY];

}

+(NSArray *) rowsTitle
{
    static NSArray *titles;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        titles = @[@"订单",@"钱包",@"老师的上课日志",
                   @"账号设置",@"意见反馈",@"检查更新",
                   @"关于选师网"];
    });
    return titles;
}

-(void)NavigationSetting
{    
    navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:nil CNavigationTitle:@"我" RNavigationTitle:@"编辑" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:nil LAction:nil WithRightTarget:self RAction:@selector(editPersonalInfoBtnTouchUp:) hideButtonFlag:2];
    navigationView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self.view addSubview:navigationView];
    
}

-(void)dealloc
{
    self.individualAndCompanyInfo = nil;
//    self.companyInfo = nil;
}
-(void)editPersonalInfoBtnTouchUp:(id)sender
{
    DBG(@"%s",__FUNCTION__);
    XLEDetailPersonalViewController *subViewController = [[XLEDetailPersonalViewController alloc] init];
    subViewController.hidesBottomBarWhenPushed = YES;
    subViewController.tableViewData = userInfoData;
    subViewController.userInfo = userInfoHTTPRequest;
    [self.navigationController pushViewController:subViewController animated:NO];
}

-(void)initTopView
{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, 180)];
    back.backgroundColor = RGBACOLOR(147, 183, 74, 1);
    [self.view addSubview:back ];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake((back.frame.size.width - 85)/2.0, 12, 85, 85)];
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 42.5f;
    self.headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImg.layer.borderWidth = 3.0f;
    self.headImg.layer.shouldRasterize = YES;
    self.headImg.clipsToBounds = YES;
    [back addSubview:self.headImg];
    self.headImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPersonalInfoBtnTouchUp:)];
    [self.headImg addGestureRecognizer:singleTap];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 107, back.frame.size.width, 17)];
    self.name.textColor = RGBACOLOR(242, 255, 215, 1);
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = [UIFont systemFontOfSize:20];
    [back addSubview:self.name];
    
    _account = [[UILabel alloc] initWithFrame:CGRectMake(0, 132, back.frame.size.width, 12)];

    self.account.textColor = RGBACOLOR(195, 221, 114, 1);
    self.account.textAlignment = NSTextAlignmentCenter;
    self.account.font = [UIFont systemFontOfSize:12];
    [back addSubview:self.account];
}

-(void)initMiddleTableView
{
    self.individualAndCompanyInfo=[[UITableView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height - 180 - (IOSNAVIGATIONSIZE) - 44 - 10) style:(UITableViewStyleGrouped)];
    self.individualAndCompanyInfo.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    self.individualAndCompanyInfo.delegate=self;
    self.individualAndCompanyInfo.dataSource=self;
    [self.view addSubview:self.individualAndCompanyInfo];
    if ([self.individualAndCompanyInfo respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.individualAndCompanyInfo setSeparatorInset:UIEdgeInsetsZero];
    }
    
//    if ([self.individualAndCompanyInfo respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.individualAndCompanyInfo setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewCell方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    else
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
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    return  view;
}

- (XLEPersonnalCenterTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIndentifier = @"XLEPersonnalCenterTableViewCell";
    XLEPersonnalCenterTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (cell == nil) {
        cell=[[XLEPersonnalCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);

        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
//        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//            [cell setLayoutMargins:UIEdgeInsetsZero];
//        }
        
//        NSArray *titles = [XLPersonalCenterViewController rowsTitle];
//        NSInteger index = indexPath.section * 4 + indexPath.row;
//        cell.title.text = [titles objectAtIndex:index];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.title.text = @"订单";
                //    cell.tipImg.image = [UIImage imageNamed:@"userIamge.png"];//need update
                return cell;
            }
            case 1:
            {
                cell.title.text = @"钱包";
                
                //    cell.tipImg.image = [UIImage imageNamed:@"userIamge.png"];//need update
                return cell;
            }
            case 2:
            {
                cell.title.text = @"老师上课日志";
                return cell;
            }
            case 3:
            {
                cell.title.text = @"账号设置";
                return cell;
            }
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
            {
                cell.title.text = @"意见反馈";
                
                
                return cell;
            }
            case 1:
            {
                cell.title.text = @"检查更新";
                //    cell.tipImg.image = [UIImage imageNamed:@"userIamge.png"];
                return cell;
            }
            case 2:
            {
                cell.title.text = @"关于选师网";
                //    cell.tipImg.image = [UIImage imageNamed:@"userIamge.png"];
                return cell;
            }
            default:
                break;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self enterSubViewController:@"XLEOrderViewController"];
                break;
            case 1:
                [self enterSubViewController:@"XLEWalletViewController"];
                break;
            case 2:
                [self enterSubViewController:@"XLETeachersCommentViewController"];
                break;
            case 3:
                [self enterSubViewController:@"XLEAccountSetVC"];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self enterSubViewController:@"XLEIdeaFeedbackVC"];
                break;
//            case 1:
//                [self enterSubViewController:@"XLEWalletViewController"];
//                break;
//            case 2:
//                [self enterSubViewController:@"XLETeachersCommentViewController"];
//                break;
                //            case 3:
                //                [self enterSubViewController:@"XLEOrderViewController"];
                //                break;
            default:
                break;
        }
    }
}

-(void)enterSubViewController:(NSString *)viewControllerClass
{
    Class class = NSClassFromString(viewControllerClass);
    UIViewController *subViewController = [[class alloc] init];
//    subViewController.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    subViewController.hidesBottomBarWhenPushed = YES;
//    if ([subViewController respondsToSelector:@selector(setDelegate:)]) {
//        subViewController.delegate = self;
//    }
//    [self.detailPersonalInfoTbl reloadData];
    [self.navigationController pushViewController:subViewController animated:NO];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UpdatePersonInfoDelegate Method
-(void)updateUserCentorUI
{
    NSString *str = @"账号：";
    self.account.text = [str stringByAppendingString:[[NSUserDefaults standardUserDefaults] objectForKey:@"IPHONE"]];
    userInfoData = userInfoHTTPRequest.userInfo;
    _name.text = [userInfoData objectForKey:_USER_NAME_KEY];
    _headImg.image = [userInfoData objectForKey:_USER_FACE_KEY];
}
@end
