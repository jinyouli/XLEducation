//
//  birthdayView.m
//  XLEducation
//
//  Created by kin on 15/3/3.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "birthdayView.h"

@implementation birthdayView
@synthesize datePicker,dateString;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        bView.backgroundColor = RGBACOLOR(10, 10, 10, 0.3);
        [self addSubview:bView];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, (Screen_Height)-230, Screen_Width, 230)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 20, 320, 230)];
        self.datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        [datePicker addTarget:self action:@selector(pickerDidchage) forControlEvents:(UIControlEventValueChanged)];
        [backView addSubview:self.datePicker];
        
        NSArray *titlArray = @[@"取消",@"确定"];
        for (int i = 0; i < 2; i++) {
            UIButton *button=[UIButton buttonWithType:(UIButtonTypeCustom)];
            button.backgroundColor = RGBACOLOR(238, 238, 238, 1);
            button.frame=CGRectMake((Screen_Width)/2*i , 0, (Screen_Width)/2, 45);
            button.tag = i;
            button.titleLabel.text = [titlArray objectAtIndex:i];
            button.titleLabel.font=[UIFont boldSystemFontOfSize:20];
            [button setTitle:button.titleLabel.text forState:(UIControlStateNormal)];
            [button setTitleColor:RGBACOLOR(55, 170, 208, 1) forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(suebutton:) forControlEvents:(UIControlEventTouchUpInside)];
            [backView addSubview:button];
        }
    }
    return self;
}
-(void)suebutton:(UIButton *)sender
{
//    if (sender.tag == 0) {
//        [self.delegate birthday:@""];
//    }else
//    {
        if ([self.dateString length] > 0) {
            [self.delegate birthday:self.dateString];
        }else{
            [self.delegate birthday:@""];
        }
//    }
}
-(void)birthdayPicker:(NSString *)birthdayString
{
    self.dateString = birthdayString;
}
-(void)pickerDidchage
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM—dd"];
    self.dateString=[formatter stringFromDate:self.datePicker.date];
    NSLog(@"=====self.dateString===%@",self.dateString);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
