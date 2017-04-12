//
//  AgreeViewController.m
//  XLEducation
//
//  Created by kin on 15/7/1.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AgreeViewController.h"

@interface AgreeViewController ()

@end

@implementation AgreeViewController
@synthesize DetailsWebview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    titleLabel.text = @"条款政策";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = titleFont;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = editioncolor;
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right_return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(adderButton)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];

//    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"条款政策" LeftNavigationTitle:@"注册" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(adderButton) LeftButtonBool:NO];
//    [self.view addSubview:navigationView];

    NSString *pathResoure = [[NSBundle mainBundle]pathForResource:@"use-terms" ofType:@"html"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:pathResoure];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    self.DetailsWebview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,(Screen_Height))];
    self.DetailsWebview.scalesPageToFit=YES;
    self.DetailsWebview.dataDetectorTypes=NO;
    self.DetailsWebview.scrollView.showsVerticalScrollIndicator = NO;
    self.DetailsWebview.scrollView.showsHorizontalScrollIndicator = NO;
    self.DetailsWebview.delegate=self;
    self.DetailsWebview.backgroundColor=[UIColor clearColor];
    [self.DetailsWebview loadRequest:urlRequest];
    [self.view addSubview:self.DetailsWebview];


}
-(void)adderButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
