//
//  XLEIdeaFeedbackVC.m
//  XLEducation
//
//  Created by xiliedu on 15/2/14.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEIdeaFeedbackVC.h"
#import "SZTextView.h"

@interface XLEIdeaFeedbackVC ()
{
    SZTextView *feedbackText;
}
@end

@implementation XLEIdeaFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavgation];
    [self loadTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadNavgation
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"意见反馈" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:nil LeftButtonBool:NO];
    [self.view addSubview:navigationView];
    
    navigationView.backgroundColor = RGBACOLOR(147, 183, 74, 1);
    
    for (UIView *subview in navigationView.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            btn.hidden = YES;
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            [label setTextColor:[UIColor whiteColor]];
        }
    }
    
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 30, IOSVERSIONSIZE, 30, 44);
    backBtn.tag = 1;
    //    backBtn.titleLabel.text = @"push";
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backToPreviousView:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
}

-(void)loadTextView
{
    feedbackText = [[SZTextView alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 88)];
    feedbackText.placeholder = @"～在这愉快的吐槽吧～";
    //        biographyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    //        biographyText.delegate = self;
    feedbackText.textContainer.maximumNumberOfLines = 5;
//    [feedbackText.layoutManager textContainerChangedGeometry:feedbackText.textContainer];
    feedbackText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:feedbackText];
}

-(void)backToPreviousView:(id)sender
{
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
