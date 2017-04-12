//
//  XLEHobbyViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEHobbyViewController.h"
#import "XLETextField.h"


@interface XLEHobbyViewController ()
{
    XLETextField *hobbyTextField;
}

@end

@implementation XLEHobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToPrevousView:(id)sender
{    if ([self.delegate respondsToSelector:@selector(setHobby:)]) {
        [self.delegate setHobby:hobbyTextField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initView
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"爱好" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
    
    hobbyTextField = [[XLETextField alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 44)];
    hobbyTextField.placeholder = @"写上爱好可以让老师更了解你";
    //        hobbyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    hobbyTextField.delegate = self;
    hobbyTextField.backgroundColor = [UIColor whiteColor];
    hobbyTextField.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:hobbyTextField];
    
    self.tabBarController.view.hidden = YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if([textField.text length]<20)
//        return YES;
//    else
//        return NO;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


