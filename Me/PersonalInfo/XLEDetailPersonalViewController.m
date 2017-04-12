//
//  XLEDetailPersonalViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/28.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEDetailPersonalViewController.h"
#import "XLEDetailPersonalInfoTableViewCell.h"
#import "XLESetNameViewController.h"
#import "XLEBiographyViewController.h"
#import "XLEHobbyViewController.h"
#import "XLEAddViewController.h"
#import "XLESelGradeViewController.h"
#import "XLEBirthDayViewController.h"
#import "UIViewController+XLESemiModalView.h"
#import "XLEHeadPortraitViewController.h"
#import "ASIFormDataRequest.h"

#import "XLESetViewController.h"

@interface XLEDetailPersonalViewController ()
{  
    XLEBirthDayViewController *birthdayViewController;
//    NSDate* selectedDate;
    
    XLEHeadPortraitViewController *headPortraitVC;
}

@end

@implementation XLEDetailPersonalViewController
@synthesize userInfo,tableViewData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"个人信息" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPersonalCentor:) LeftButtonBool:NO];
    [self.view addSubview:navigationView];
    [self initTableView];
    
}
-(void)backToPersonalCentor:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([[tableViewData objectForKey:_USER_INFO_UPDATEDE_KEY] boolValue]) {
        [userInfo saveToServer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
//    [self removeObserver:self forKeyPath:@"userInfo.headImg"];
//    [super dealloc];
}

-(void)initTableView
{
    self.detailPersonalInfoTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 2, self.view.frame.size.width, self.view.frame.size.height - (IOSNAVIGATIONSIZE) - 2) style:(UITableViewStyleGrouped)];
    self.detailPersonalInfoTbl.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    self.tabBarController.tabBarController.view.hidden = YES;
    self.detailPersonalInfoTbl.delegate=self;
    self.detailPersonalInfoTbl.dataSource=self;
    if ([self.detailPersonalInfoTbl respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.detailPersonalInfoTbl setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.detailPersonalInfoTbl respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.detailPersonalInfoTbl setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.view addSubview:self.detailPersonalInfoTbl];
    
//    userInfo = [[XLEUserPersonalInfo alloc] init];
//    userInfo.delegate = self;//update basic Info by delegate;
    
    //update headImg by KVO;
//    [self addObserver:self forKeyPath:@"userInfo.headImg" options:NSKeyValueObservingOptionNew context:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-UITableViewCell方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }
    else if(section == 1)
        return 3;
    else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }
    else
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
        label.text = @"基本信息";
    } else if(section == 1){
        label.text = @"教育背景";
    }
    [view addSubview:label];
    
    return  view;
}


- (XLEDetailPersonalInfoTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
               return  [self headImgCell:_USER_FACE_KEY headImgpath:nil];
            case 1:
                return [self normalCell:_USER_NAME_KEY value:@"test"];
            case 2:
                return [self normalCell:_USER_GENDER_KEY value:@"test"];
           
            case 3:
                return [self normalCell:_USER_ADDR_KEY value:@"test"];
             
            case 4:
                return [self normalCell:_USER_BIRTHDAY_KEY value:@"test"];
            
            case 5:
                return [self normalCell:_USER_HOBBY_KEY value:@"test"];
               
            case 6:
                return [self normalCell:_USER_SHORT_INTRO_KEY value:@"test"];
                
            default:
                break;
        }
        
    } else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                 return [self normalCell:_USER_SCHOOL_KEY value:@"test"];
            case 1:
                return [self normalCell:_USER_GRADE_KEY value:@"test"];
            case 2:
                return [self normalCell:_USER_SKILLED_COURSE_KEY value:@"test"];
            default:
                break;
        }
    }
//    else
//    {
//        switch (indexPath.row) {
//            case 0:
//                return [self normalCell:@"修改密码" value:nil];
//            case 1:
//                return [self normalCell:@"退出登录" value:nil];
//            default:
//                break;
//        }
//    }
    return nil;

}


-(XLEDetailPersonalInfoTableViewCell *)headImgCell:(NSString *)title headImgpath:(NSString *)headImgpath
{
    XLEDetailPersonalInfoTableViewCell *cell=[self.detailPersonalInfoTbl dequeueReusableCellWithIdentifier:title];
    if (nil==cell)
    {
        cell=[[XLEDetailPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:title isHeadIconCell:YES];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        cell.title.text = title;
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
   
    cell.headImg.image = [tableViewData valueForKey:_USER_FACE_KEY];
    return cell;
}

-(XLEDetailPersonalInfoTableViewCell *)normalCell:(NSString *)title value:(NSString *)value
{
    XLEDetailPersonalInfoTableViewCell *cell=[self.detailPersonalInfoTbl dequeueReusableCellWithIdentifier: title];
    if (cell == nil) {
        cell = [[XLEDetailPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:title isHeadIconCell:NO];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        cell.title.text = title;
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    cell.value.text = [tableViewData valueForKey:title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES)
    {
        [cell setBackgroundColor:RGBACOLOR(255, 255, 255, 1)];
    }
}

#pragma mark -UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBG(@"%s",__FUNCTION__);

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self enterheadPortraitView];
                break;
            case 1:
            {
                [self enterSubView:@"XLESetNameViewController"];
                break;
            }
            case 2:
                [self enterSubView:@"XLEGenderViewController"];
                break;
            case 3:
                [self enterSubView:@"XLEAddViewController"];
                break;
            case 4:
                [self enterBirthDayView];
                break;
            case 5:
                [self enterSubView:@"XLEHobbyViewController"];
                break;
            case 6:
            {
                [self enterSubView:@"XLEBiographyViewController"];
                break;
            }
            case 7:
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self enterSubView:@"XLESchoolViewController"];
                break;
            case 1:
                [self enterSubView:@"XLESelGradeViewController"];
                break ;
            case 2:
                [self enterSubView:@"XLESkilledCourseViewController"];
                break ;
                
            default:
                break;
        }
    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [tableView reloadData];
}

-(void)enterSubView:(NSString *)className
{
    Class class = NSClassFromString(className);
    XLESetViewController *subViewController = [[class alloc] init];
    subViewController.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    subViewController.hidesBottomBarWhenPushed = YES;
    if ([subViewController respondsToSelector:@selector(setDelegate:)]) {
        subViewController.delegate = self;
    }
//    [self.detailPersonalInfoTbl reloadData];
    [self.navigationController pushViewController:subViewController animated:YES];
    
}

-(void)enterBirthDayView
{
    birthdayViewController = [[XLEBirthDayViewController alloc] init];
    birthdayViewController.delegate = self;
    [self presentSemiModalViewController:birthdayViewController];
}

-(void)enterheadPortraitView
{
    headPortraitVC = [[XLEHeadPortraitViewController alloc] init];
    headPortraitVC.delegate = self;
    [self presentSemiModalPhotoViewController:headPortraitVC];
}

-(void)setVitalInfo
{
    if ([tableViewData objectForKey:_USER_NAME_KEY] == nil) {
        [tableViewData setObject:@"" forKey:_USER_NAME_KEY];
    }
    if ([tableViewData objectForKey:_USER_GENDER_KEY] == nil) {
        [tableViewData setObject:@"" forKey:_USER_GENDER_KEY];
    }
    if ([tableViewData objectForKey:_USER_ADDR_KEY] == nil) {
        [tableViewData setObject:@"" forKey:_USER_ADDR_KEY];
    }
}

#pragma mark -SettingviewDelegate methods
-(void)resetCellValue:(NSString *)value
{
    NSIndexPath *selectedIndexPath = [_detailPersonalInfoTbl indexPathForSelectedRow];
    XLEDetailPersonalInfoTableViewCell *cell = (XLEDetailPersonalInfoTableViewCell *)[_detailPersonalInfoTbl cellForRowAtIndexPath: selectedIndexPath];
    cell.value.text = value;
    [tableViewData setObject:@"YES" forKey:_USER_INFO_UPDATEDE_KEY];
    [self setVitalInfo];
    [_detailPersonalInfoTbl deselectRowAtIndexPath:selectedIndexPath animated:YES];
}
-(void)setName:(NSString *)name
{
    [tableViewData setObject:name forKey:_USER_NAME_KEY];
    [self resetCellValue:name];
}

-(void)setBiography:(NSString *)biography
{
    [tableViewData setObject:biography forKey:_USER_SHORT_INTRO_KEY];
    [self resetCellValue:biography];
}

-(void)setHobby:(NSString *)hobby
{
    [tableViewData setObject:hobby forKey:_USER_HOBBY_KEY];
    [self resetCellValue:hobby];
}

-(void)setAddr:(NSString *)addr
{
    [tableViewData setObject:addr forKey:_USER_ADDR_KEY];
    [self resetCellValue:addr];
}

-(void)setGender:(BOOL)isMan
{
    if (!isMan) {
        [tableViewData setValue:@"男" forKeyPath:_USER_GENDER_KEY];
    }else
    {
        [tableViewData setValue:@"女" forKeyPath:_USER_GENDER_KEY];
    }
    [self resetCellValue:[tableViewData objectForKey:_USER_GENDER_KEY]];

}

-(void)setGrade:(NSString *)grade
{
    [tableViewData setValue:grade forKey:_USER_GRADE_KEY];
    [self resetCellValue:grade];
}

-(void)setSchoolInfo:(NSString *)schoolInfo
{
    [tableViewData setObject:schoolInfo forKey:_USER_SCHOOL_KEY];
    [self resetCellValue:schoolInfo];
}

-(void)setSkilledCourses:(NSArray *)skilledCourseArray
{
    NSMutableString *courses = [[NSMutableString alloc] init];
    for (NSString *course in skilledCourseArray) {
        courses = (NSMutableString *)[courses stringByAppendingFormat:@"%@ ",course];
    }
    [tableViewData setObject:courses forKey:_USER_SKILLED_COURSE_KEY];
    [self resetCellValue:courses];
}

//-(void)imgPickerVC:(UIViewController *)vc
//{
//    [self.navigationController pushViewController:vc animated:YES];
//}

-(void)setHeadImg:(UIImage *)image
{
    NSIndexPath *selectedIndexPath = [_detailPersonalInfoTbl indexPathForSelectedRow];
    if (image == nil) {
        [self dismissSemiModalPhotoViewController:headPortraitVC];
        [_detailPersonalInfoTbl deselectRowAtIndexPath:selectedIndexPath animated:YES];
        return;
    }
    
    [tableViewData setObject:image forKey:_USER_FACE_KEY];
    
    XLEDetailPersonalInfoTableViewCell *cell = (XLEDetailPersonalInfoTableViewCell *)[_detailPersonalInfoTbl cellForRowAtIndexPath: selectedIndexPath];
    cell.headImg.image = image;
    [_detailPersonalInfoTbl deselectRowAtIndexPath:selectedIndexPath animated:YES];
    
    [userInfo uploadFace];
    [self dismissSemiModalPhotoViewController:headPortraitVC];
}

//-(void)saveBasicInfoToServer
//{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.xsw100.com/Student/SaveInfo"]];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    
//    [request setRequestMethod:@"POST"];
//    [request setPostValue:[tableViewData objectForKey:@"名字＊"] forKey:@"realname"];
//    [request setPostValue:[tableViewData objectForKey:@"家庭住址＊"]forKey:@"addr"];
////    NSString *sexStr = [NSString stringWithFormat:@"%ld", self.sex];
////    [request setPostValue:sexStr forKey:@"sex"];
//    [request setPostValue:[tableViewData objectForKey:@"生日"] forKey:@"birthday"];
//    [request setPostValue:[tableViewData objectForKey:@"爱好"] forKey:@"hobby"];
//    [request setPostValue:[tableViewData objectForKey:@"个人简介"] forKey:@"intro_short"];
////    NSString *gradeStr = [NSString stringWithFormat:@"%ld", self.grade];
////    [request setPostValue:gradeStr forKey:@"grade"];
//    [request setPostValue:[tableViewData objectForKey:@"所在学校"] forKey:@"school"];
//    [request setPostValue:[tableViewData objectForKey:@"擅长科目"] forKey:@"course_adept"];
//    
//    [userInfo saveBasicInfoToServer:request];
//}



#pragma mark -
#pragma mark Date Picker Delegate

-(void)datePickerSetDate:(XLEBirthDayViewController*)viewController {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:viewController.datePicker.date];
    [tableViewData setObject:str forKey:_USER_BIRTHDAY_KEY];

    [self resetCellValue:[tableViewData objectForKey:_USER_BIRTHDAY_KEY]];
    
    [self dismissSemiModalViewController:birthdayViewController];

}

-(void)datePickerClearDate:(XLEBirthDayViewController*)viewController {
    [self dismissSemiModalViewController:birthdayViewController];
//    [self.detailPersonalInfoTbl reloadData];
}

-(void)datePickerCancel:(XLEBirthDayViewController*)viewController {
    [self dismissSemiModalViewController:birthdayViewController];
//    [self.detailPersonalInfoTbl reloadData];
}

//#pragma mark XLEUserPersonalInfo Delegate Method
//-(void)updateInfo
//{
//    [tableViewData setObject:userInfo.realName forKey:@"名字＊"];
//    [tableViewData setObject:userInfo.addr forKey:@"家庭住址＊"];
//    [tableViewData setObject:userInfo.birthDay forKey:@"生日"];
//    [tableViewData setObject:userInfo.hobby forKey:@"爱好"];
//    [tableViewData setObject:userInfo.introShort forKey:@"个人简介"];
//    [tableViewData setObject:userInfo.school forKey:@"所在学校"];
//    [tableViewData setObject:userInfo.skilledCourse forKey:@"擅长科目"];
//    switch (userInfo.sex) {
//        case 0:
//            break;
//        case 1:
//            [tableViewData setObject:@"男" forKey:@"性别＊"];
//            break;
//        case 2:
//            [tableViewData setObject:@"女" forKey:@"性别＊"];
//            break;
//            
//        default:
//            break;
//    }
//    
//    switch (userInfo.grade) {
//        case 0:
//            [tableViewData setObject:@"小学" forKey:@"年级"];
//            break;
//        case 1:
//            [tableViewData setObject:@"小学升初" forKey:@"年级"];
//            break;
//        case 2:
//            [tableViewData setObject:@"初中" forKey:@"年级"];
//            break;
//        case 3:
//            [tableViewData setObject:@"中考" forKey:@"年级"];
//            break;
//        case 4:
//            [tableViewData setObject:@"高中" forKey:@"年级"];
//            break;
//        case 5:
//            [tableViewData setObject:@"高考" forKey:@"年级"];
//            break;
//            
//        default:
//            break;
//    }
//    
//    [self.detailPersonalInfoTbl reloadData];
//}
//
//
//#pragma mark - update headImg by KVO
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if([keyPath isEqualToString:@"userInfo.headImg"] && userInfo.headImg)
//    {
//        [tableViewData setObject:userInfo.headImg forKey:@"头像＊"];
////        [self.detailPersonalInfoTbl reloadData];
//    }
//}
@end
