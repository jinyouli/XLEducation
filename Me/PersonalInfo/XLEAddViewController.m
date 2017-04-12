//
//  XLEAddViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEAddViewController.h"
#import "SZTextView.h"

@interface XLEAddViewController ()
{
    SZTextView *addrTextView;
}
@end

@implementation XLEAddViewController

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
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAddr:(id)sender
{
    if (addrTextView.text.length && [self.delegate respondsToSelector:@selector(setAddr:)]) {
        [self.delegate setAddr:addrTextView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initView
{
    NavigationView *navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:@"个人信息" CNavigationTitle:@"家庭住址" RNavigationTitle:@"保存" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LAction:@selector(backToPrevousView:) WithRightTarget:self RAction:@selector(saveAddr:) LeftTitleLength:100];
    [self.view addSubview:navigationView];
    
    addrTextView = [[SZTextView alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 88)];
//    biographyText.placeholder = @"用一句话让老师更了解你";
    //        biographyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //        biographyText.delegate = self;
    addrTextView.textContainer.maximumNumberOfLines = 4;
    [addrTextView.layoutManager textContainerChangedGeometry:addrTextView.textContainer];
    addrTextView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:addrTextView];
    
    self.tabBarController.view.hidden = YES;
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
