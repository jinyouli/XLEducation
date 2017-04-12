//
//  XLESchoolViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLESchoolViewController.h"

@interface XLESchoolViewController ()
{
    UITextField *schoolInfoTextField;
}

@end

@implementation XLESchoolViewController

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
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"所在学校" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
        
    schoolInfoTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 44)];
    schoolInfoTextField.placeholder = @"写上自己的母校～";
    //        hobbyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    schoolInfoTextField.delegate = self;
    schoolInfoTextField.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:schoolInfoTextField];
    
    self.tabBarController.view.hidden = YES;
}

-(void)backToPrevousView:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setSchoolInfo:)]) {

        [self.delegate setSchoolInfo:schoolInfoTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
