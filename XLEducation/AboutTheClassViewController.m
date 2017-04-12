//
//  AboutTheClassViewController.m
//  XLEducation
//
//  Created by kin on 15/4/1.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AboutTheClassViewController.h"
#import "ASIFormDataRequest.h"
#import "SeletionSubectView.h"
#import "subjecTimeView.h"
//#import "CalendarHomeViewController.h"
#import "XLWatchTime.h"
#import "XLQuestWork.h"
@interface AboutTheClassViewController ()<ASIHTTPRequestDelegate,subjecTimedelegate,SeletionSubectdelegate>
{
    UITextField *classField[3];
    UIButton *seleButton[3];
    UIImageView *lineImage[3];
    subjecTimeView *timeView;
    SeletionSubectView *SubectView;
}

@end

@implementation AboutTheClassViewController

@synthesize teachInfoDictionary,teachcellDictionary,teachUid;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NavigationSetting];
    [self ControlsGenerate];
}
-(void)NavigationSetting
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"约 课" LeftNavigationTitle:@"" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backButton) LeftButtonBool:NO];
    [self.view addSubview:navigationView];
}
-(void)ControlsGenerate
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10,(IOSNAVIGATIONSIZE)+20, (Screen_Width)-20, 260)];
    backView.backgroundColor = RGBACOLOR(238,238,238,1);
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 10;
    [self.view addSubview:backView];
    
    UIView *backcView = [[UIView alloc]initWithFrame:CGRectMake(0,0, (Screen_Width), 45)];
    backcView.backgroundColor = WORDLCOLOR;
    [backView addSubview:backcView];


    NSArray *ClassArray = @[@"订\t\t单:",@"日期时间:",@"预约课时:"];
    
    for (int i = 0 ; i < 3; i ++) {
        UILabel *classLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (IOSNAVIGATIONSIZE)+95+60*i, 80, 35)];
        classLabel.text = [ClassArray objectAtIndex:i];
        classLabel.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:classLabel];
    }
    
    NSArray *TextFieldArray = @[@" 请您选择订单",@" 请您选择时间",@" 请您选择课时"];
    for (int i = 0 ; i < 3; i ++) {
        classField[i] = [[UITextField alloc]initWithFrame:CGRectMake(105, (IOSNAVIGATIONSIZE)+95+60*i, (Screen_Width)-125, 35)];
        classField[i].backgroundColor = [UIColor whiteColor];
        classField[i].layer.masksToBounds = YES;
        classField[i].layer.borderWidth = 1;
        classField[i].layer.borderColor = GREECOLOR.CGColor;
        classField[i].placeholder = [TextFieldArray objectAtIndex:i];
        classField[i].font = [UIFont systemFontOfSize:15];
        [self.view addSubview:classField[i]];
        
        lineImage[i] = [[UIImageView alloc]init];
        lineImage[i].frame = CGRectMake((Screen_Width)-45,(IOSNAVIGATIONSIZE)+102+60*i,20, 20);
        lineImage[i].image = [UIImage imageNamed:@"price@2x.jpg"];
        [self.view addSubview:lineImage[i]];
        
        seleButton[i] = [UIButton buttonWithType:(UIButtonTypeCustom)];
        seleButton[i].frame = CGRectMake(105, (IOSNAVIGATIONSIZE)+95+60*i, (Screen_Width)-125, 35);
        seleButton[i].tag = i;
        seleButton[i].selected = YES;
        [seleButton[i] addTarget:self action:@selector(seleButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:seleButton[i]];
    }
    
        UIButton *upWeekButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        upWeekButton.frame = CGRectMake(15, 400, (Screen_Width)-30, 45);
        upWeekButton.layer.masksToBounds = YES;
        upWeekButton.layer.cornerRadius = 3;
        upWeekButton.layer.backgroundColor = WORDLCOLOR.CGColor;
        [upWeekButton setTitle:@"确认发起" forState:(UIControlStateNormal)];
        [upWeekButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [upWeekButton addTarget:self action:@selector(sureButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:upWeekButton];
    
        SubectView = [[SeletionSubectView alloc]initWithFrame:CGRectMake(105, (IOSNAVIGATIONSIZE)+95+35, (Screen_Width)-125, 35*5) teachId:[teachUid length] > 0 ? teachUid :[teachInfoDictionary objectForKey:@"teacher_uid"]];
        SubectView.delegate = self;
        SubectView.hidden = YES;
        [self.view addSubview:SubectView];
    
        timeView = [[subjecTimeView alloc]initWithFrame:CGRectMake(105, (IOSNAVIGATIONSIZE)+130+60*2, (Screen_Width)-125, 35*5)];
        timeView.delegate = self;
        timeView.hidden = YES;
        [self.view addSubview:timeView];
//    requestCoolkit = [XLQuestWork stardowlop];

}

-(void)sureButton
{

    NSString *time = [XLWatchTime changeTime];
    DBG(@"=======time========%@",time);
    NSString *booking = [classField[1].text substringFromIndex:1];
    NSString *booking_time = [NSString stringWithFormat:@"%@ %@",booking,time];
    DBG(@"=====booking_time===%@",booking_time);
    NSString *class_hours = [classField[2].text substringWithRange:NSMakeRange(1, 1)];
    DBG(@"=====class_hours===%@",class_hours);

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@booking/booking",XLNETWORKREQUESTSURLDomain]]];
    [request setRequestMethod:@"POST"];
    [request setPostValue:IPHNOEPHPSESSID forKey:@"PHPSESSID"];
    [request setPostValue:[self.teachcellDictionary objectForKey:@"order_id"] forKey:@"orderId"];
    [request setPostValue:booking_time forKey:@"bookingTime"];
    [request setPostValue:class_hours forKey:@"classHours"];
    [request setDelegate:self];
//    [requestCoolkit requestCookie];
    [request startAsynchronous];
    
    
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSString *msg = [jsonData objectForKey:@"msg"];
    UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil, nil];
    [AlertView show];
    DBG(@"=====约课返回=====%@",jsonData);
}
-(void)seleButton:(UIButton *)sender
{
    
    if (sender.tag == 0) {
        
        if (seleButton[0].selected == YES)
        {
            [self rotateArrow:0 with:M_PI_2];
            SubectView.hidden = NO;
            seleButton[0].selected = NO;

        }else
        {
            [self rotateArrow:0 with:0];
            SubectView.hidden = YES;
            seleButton[0].selected = YES;
        }

    }
    else if (sender.tag == 1) {
//        CalendarHomeViewController *chvc = [[CalendarHomeViewController alloc]init];
//        chvc.calendartitle = @"日历";
//        [chvc setAirPlaneToDay:365 ToDateforString:nil];
//        [self.navigationController pushViewController:chvc animated:YES];
//        
//        chvc.calendarblock = ^(CalendarDayModel *model){
//            classField[1].text =[NSString stringWithFormat:@" %@",[model toString]];;
////            NSLog(@"1星期 %@",[model getWeek]);
//            NSLog(@"2字符串 %@",[model toString]);
////            NSLog(@"3节日  %@",model.holiday);
//        };
    }
    else if(sender.tag == 2)
    {
        if (seleButton[2].selected == YES)
        {
            timeView.hidden = NO;
            seleButton[2].selected = NO;
            [self rotateArrow:2 with:M_PI_2];

        }else
        {
            timeView.hidden = YES;
            seleButton[2].selected = YES;
            [self rotateArrow:2 with:0];

        }
    }
    DBG(@"===========%ld",(long)sender.tag);
}
-(void) rotateArrow:(int)tagBt with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        lineImage[tagBt].layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}


-(void)subjecTimeHide:(NSString *)number
{
    classField[2].text = [NSString stringWithFormat:@" %@",number];
    timeView.hidden = YES;
    seleButton[2].selected = YES;
    [self rotateArrow:2 with:0];

}

-(void)SeletionSubectHide:(NSDictionary *)number
{
    [self rotateArrow:0 with:0];
    self.teachcellDictionary = number;
    int course = [[number objectForKey:@"course"] intValue];
    
    NSString *Studcourse;
    switch (course) {
        case 1:
            Studcourse = @"语文";
            break;
        case 2:
            Studcourse = @"数学";
            break;
        case 3:
            Studcourse = @"地理";
            break;
        case 4:
            Studcourse = @"英语";
            break;
        case 5:
            Studcourse = @"物理";
            break;
        case 6:
            Studcourse = @"化学";
            break;
        case 7:
            Studcourse = @"生物";
            break;
        case 8:
            Studcourse = @"政治";
            break;
        case 9:
            Studcourse = @"历史";
            break;
        default:
            break;
    }
    int grade = [[number objectForKey:@"grade"] intValue];
    
    NSString *Studgrade;
    switch (grade) {
        case 1:
            Studgrade = @"小学";
            break;
        case 2:
            Studgrade = @"小升初";
            break;
        case 3:
            Studgrade = @"初中";
            break;
        case 4:
            Studgrade = @"中考";
            break;
        case 5:
            Studgrade = @"高中";
            break;
        case 6:
            Studgrade = @"高考";
            break;
            
        default:
            break;
    }
    classField[0].text = [NSString stringWithFormat:@" %@%@  剩余:%@课时",Studgrade,Studcourse,[number objectForKey:@"class_hours_remain"]];
    SubectView.hidden = YES;
    seleButton[0].selected = YES;

}
-(void)backButton
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
