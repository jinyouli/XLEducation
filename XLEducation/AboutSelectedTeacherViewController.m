//
//  AboutSelectedTeacherViewController.m
//  XLEducation
//
//  Created by kin on 15/3/9.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AboutSelectedTeacherViewController.h"
@interface AboutSelectedTeacherViewController ()

@end

@implementation AboutSelectedTeacherViewController
@synthesize ActivitiesWebview;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NavigationSetting];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.51xuanshi.com/helpcenter/about-us.html"]];
    self.ActivitiesWebview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,(Screen_Height))];
    self.ActivitiesWebview.scalesPageToFit=YES;
    self.ActivitiesWebview.dataDetectorTypes=NO;
    self.ActivitiesWebview.scrollView.showsVerticalScrollIndicator = NO;
    self.ActivitiesWebview.scrollView.showsHorizontalScrollIndicator = NO;
    self.ActivitiesWebview.delegate=self;
    self.ActivitiesWebview.backgroundColor=[UIColor clearColor];
    [self.ActivitiesWebview loadRequest:urlRequest];
    [self.view addSubview:self.ActivitiesWebview];
}

-(void)NavigationSetting
{
    self.title = @"关于选师无忧";
    NSDictionary *titleDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:LoinFont};
    [self.navigationController.navigationBar setTitleTextAttributes:titleDictionary];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right_return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(XSBannerNavigationleftPush)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
}
-(void)XSBannerNavigationleftPush
{
    [self.navigationController popViewControllerAnimated:YES];
}
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
