//
//  XLESetNameViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/29.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLESetNameViewController.h"
#import "XLETextField.h"

@interface XLESetNameViewController ()
{
    XLETextField *nameTextField;
}

@end

@implementation XLESetNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];

//    [self initTableView];
}

-(void)backToPrevousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) saveName:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(setName:)]) {
        [self.delegate setName:nameTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initView
{

    NavigationView *navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:@"个人信息" CNavigationTitle:@"名字" RNavigationTitle:@"保存" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LAction:@selector(backToPrevousView:) WithRightTarget:self RAction:@selector(saveName:) LeftTitleLength:100];
    [self.view addSubview:navigationView];
    
    nameTextField = [[XLETextField alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 44)];
    nameTextField.placeholder = @"请设置你的名字";
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.delegate = self;
    nameTextField.backgroundColor = [UIColor whiteColor];
    nameTextField.font = [UIFont systemFontOfSize:16];
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:nameTextField];
    
    self.tabBarController.view.hidden = YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if([textField.text length]<5)
//        return YES;
//    else
//        return NO;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
