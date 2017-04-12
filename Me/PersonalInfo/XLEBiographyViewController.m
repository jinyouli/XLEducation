//
//  XLEBiographyViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEBiographyViewController.h"
#import "SZTextView.h"

@interface XLEBiographyViewController ()
{
    SZTextView *biographyText;
}

@end

@implementation XLEBiographyViewController

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
//    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(setBiography:)]) {
        [self.delegate setBiography:biographyText.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initView
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"个人简介" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
    
    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(30, 20, 60, 44);
    backBtn.tag = 1;
    //    backBtn.titleLabel.text = @"push";
    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [backBtn setTitle:@"个人信息" forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backToPrevousView:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    biographyText = [[SZTextView alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 88)];
    biographyText.placeholder = @"用一句话让老师更了解你";
    //        biographyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //        biographyText.delegate = self;
    biographyText.textContainer.maximumNumberOfLines = 4;
    [biographyText.layoutManager textContainerChangedGeometry:biographyText.textContainer];
    biographyText.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:biographyText];
    
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
