
//
//  XLEBirthDayViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEBirthDayViewController.h"
#import "UIViewController+XLESemiModalView.h"

@interface XLEBirthDayViewController ()

@end

@implementation XLEBirthDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.coverView = nil;
}

-(void)initView
{
    self.coverView = [[UIView alloc]
                      initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coverView.backgroundColor  = UIColor.blackColor;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:self.coverView];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 216,self.view.frame.size.width,-1)];
    self.datePicker.date = [NSDate date];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_cn"]; ;
    for (UIView* subview in self.datePicker.subviews) {
        subview.frame = self.datePicker.bounds;
    }
    [self.view addSubview:self.datePicker];
    
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.frame = CGRectMake(0, self.view.frame.size.height -216 - 44, self.view.frame.size.width, 44);
    self.toolbar.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    UIBarButtonItem *bi1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToPrevousView:)];
    bi1.width = 45;
    bi1.tag = 1;
    [buttons addObject:bi1];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    space.width = self.toolbar.frame.size.width - 45 * 2 - 40;
    [buttons addObject:space];
    
    UIBarButtonItem *bi2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(backToPrevousView:)];
    bi2.width = 45;
    bi2.tag = 2;
    [buttons addObject:bi2];
    
    [self.toolbar setItems:buttons animated:NO];
    
//    [[self.toolbar.subviews objectAtIndex:1] setFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:self.toolbar];

}

-(void)backToPrevousView:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
//    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(datePickerSetDate:)] && button.tag == 2) {
        
        [self.delegate datePickerSetDate:self];
    }
    else if ([self.delegate respondsToSelector:@selector(datePickerCancel:)] && button.tag == 1)
    {
        [self.delegate datePickerCancel:self];
    }
    else
    {
        [self dismissSemiModalViewController:self];
    }
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
