//
//  XLEOrderDetailViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/2/9.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEOrderDetailViewController.h"

@interface XLEOrderDetailViewController ()
{
    UILabel *orderTimeLabel;
    UIImageView *teacherHead;
    UILabel *teacherNameLabel;
    UILabel *coureLabel;
    UILabel *priceLabel;
    
    UILabel *orderIDLabel;
    
    UILabel *orderStatusLabel;
    UILabel *totalPrice;
    UILabel *classTotalPeriod;
    UILabel *classDonePeriod;
    UILabel *remainMoney;
    UIProgressView *progressView;
    
    UIButton *leftBtn;
    UIButton *rightBtn;
    
    XLEViewOrderRequest *orderDetailRequest;
}

@end

@implementation XLEOrderDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigation];
    
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    [self initSubViews];
    [self initOrerDetailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initOrerDetailRequest
{
    orderDetailRequest = [[XLEViewOrderRequest alloc] init];
    orderDetailRequest.delegate = self;
    
    [orderDetailRequest requestOrderDetail:self.orderIDStr];
    
}

-(void)initNavigation
{
    NavigationView *nav = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"订单详情" LeftNavigationTitle:@"订单" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO];
    nav.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    [self.view addSubview:nav];
    
    UIButton *purchaseAgainBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 88  - 10, IOSVERSIONSIZE, 88, 44)];
    [purchaseAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [purchaseAgainBtn setTitleColor:RGBACOLOR(60, 171, 206, 1) forState:UIControlStateNormal];
    [purchaseAgainBtn addTarget:self action:@selector(purchaseAgain:) forControlEvents:UIControlEventTouchUpInside];
    purchaseAgainBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:purchaseAgainBtn];
}

-(void)initSubViews
{
    UIView *whiteZone = [[UIView alloc] initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, 164)];
    whiteZone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteZone];
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 102, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    [self initFirstArea:whiteZone];
  
    //second area
    switch (_orderStatus) {
        case 0:
            [self initCompletedOrderSecondZone];
            break;
        case 1:
            [self initUnpaidOrderSecondZone];
            break;
        case 2:
            [self initOngoingOrderSecondZone];
            break;
        case 3:
            [self initCancleOrderSecondZone];
            break;
        default:
            break;
    }


}

-(void)initFirstArea:(UIView *)parentView
{
    orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, self.view.frame.size.width - 20, 20)];
    orderTimeLabel.text = _orderTimeStr;
    orderTimeLabel.textColor = RGBACOLOR(181, 181, 181, 1);
    orderTimeLabel.font = [UIFont systemFontOfSize:10];
    [parentView addSubview:orderTimeLabel];
    
    teacherHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 33, 60, 60)];
    teacherHead.layer.masksToBounds = YES;
    teacherHead.layer.cornerRadius = 30;
    teacherHead.layer.borderColor = [UIColor grayColor].CGColor;
    teacherHead.layer.borderWidth = 3.0f;
    teacherHead.layer.shouldRasterize = YES;
    teacherHead.clipsToBounds = YES;
    teacherHead.image = _teacherHeadImage;
    [parentView addSubview:teacherHead];
    
    teacherNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 52, 250, 30)];
    teacherNameLabel.text = _teacherNameStr;
    teacherNameLabel.textColor = [UIColor blackColor];
    teacherNameLabel.font = [UIFont systemFontOfSize:20];
    [parentView addSubview:teacherNameLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 111, 70, 15)];
    label.text = @"购买课程：";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGBACOLOR(138, 138, 138, 1);
    [parentView addSubview:label];
    
    coureLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 111, 250, 15)];
    coureLabel.text = _coureStr;
    coureLabel.textColor = [UIColor blackColor];
    coureLabel.font = [UIFont systemFontOfSize:15];
    [parentView addSubview:coureLabel];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 140, 250, 15)];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor blackColor];
    
    NSString *str = [NSString stringWithFormat:@"¥%ld/小时",_price];
    priceLabel.text = str;
    [parentView addSubview:priceLabel];
    
    UIButton *callBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 32, 46, 32, 32)];
    callBtn.layer.cornerRadius = 16;
    callBtn.clipsToBounds = YES;
    [callBtn setImage:[UIImage imageNamed:@"phone_icon"] forState:UIControlStateNormal];
//    [callBtn.layer setBorderWidth:1.0f];
//    [callBtn.layer setBorderColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1].CGColor];
    [callBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    callBtn.tag = 4;
    [parentView addSubview:callBtn];
}

-(void)initBottomBtn:(UIView *)parentView
{
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 154, (self.view.frame.size.width - 30)/2, 38)];
    leftBtn.tag = 1;
    [leftBtn.layer setBorderWidth:1.0f];
    [leftBtn.layer setBorderColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1].CGColor];
    [leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.backgroundColor = RGBACOLOR(250, 250, 250, 1);
    leftBtn.layer.cornerRadius = 4;
    leftBtn.clipsToBounds = YES;
    [parentView addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + (self.view.frame.size.width - 30)/2, 154, (self.view.frame.size.width - 30)/2, 38)];
    
    if (_orderStatus == 1) {
        rightBtn.tag = 3;
        [rightBtn setTitle:@"前往支付" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.backgroundColor = RGBACOLOR(252, 110, 35, 1);
    }
    else if(_orderStatus == 2)
    {
        rightBtn.tag = 2;
        [rightBtn setTitle:@"发起约课" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.backgroundColor = RGBACOLOR(124, 178, 14, 1);
    }
   
    rightBtn.layer.cornerRadius = 4;
    rightBtn.clipsToBounds = YES;
    [parentView addSubview:rightBtn];
    
    [leftBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)initCancleOrderSecondZone
{
    UIView *whiteZone = [[UIView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 164 + 10, self.view.frame.size.width, 44)];
    whiteZone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteZone];
    orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 16)];
    orderStatusLabel.text = @"已取消";
    orderStatusLabel.font = [UIFont systemFontOfSize:16];
    orderStatusLabel.textColor = [UIColor blackColor];
    [whiteZone addSubview:orderStatusLabel];
    
    totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(155, 17, self.view.frame.size.width - 155 - 10, 13)];
    totalPrice.font = [UIFont systemFontOfSize:12];
    totalPrice.textColor = RGBACOLOR(170, 170, 170, 1);
    CGFloat amountPrice = _price * _classHours;
    NSString *str = [NSString stringWithFormat:@"支付总额：¥%.2f",amountPrice];
    totalPrice.text = str;
    totalPrice.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:totalPrice];
    
    orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 218, self.view.frame.size.width, 20)];
    orderIDLabel.textColor = RGBACOLOR(177, 177, 177, 1);
    
    str = [NSString stringWithFormat:@"订单号：%@",_orderIDStr];
    orderIDLabel.text = str;
    orderIDLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:orderIDLabel];
}

-(void)initOngoingOrderSecondZone
{
   UIView * whiteZone = [[UIView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 164 + 10, self.view.frame.size.width, 203)];
    whiteZone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteZone];
    orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 16)];
    orderStatusLabel.text = @"进行中";
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 138, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    orderStatusLabel.font = [UIFont systemFontOfSize:16];
    orderStatusLabel.textColor = [UIColor blackColor];
    [whiteZone addSubview:orderStatusLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 62, 60, 13)];
    label.text = @"课程总时长：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, 112, 40, 13)];
    label.text = @"已完成：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(155, 17, self.view.frame.size.width - 155 - 10, 13)];
    totalPrice.font = [UIFont systemFontOfSize:12];
    totalPrice.textColor = RGBACOLOR(170, 170, 170, 1);
    
    CGFloat amountPrice = _price * _classHours;
    NSString *str = [NSString stringWithFormat:@"支付总额：¥%.2f",amountPrice];
    totalPrice.text = str;
    totalPrice.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:totalPrice];
    
    classTotalPeriod = [[UILabel alloc] initWithFrame:CGRectMake(70, 60, 100, 15)];
    classTotalPeriod.font = [UIFont systemFontOfSize:15];
    classTotalPeriod.textColor = [UIColor blackColor];
    str = [NSString stringWithFormat:@"%ld课时",_classHours];
    classTotalPeriod.text = str;
    [whiteZone addSubview:classTotalPeriod];
    
    classDonePeriod = [[UILabel alloc] initWithFrame:CGRectMake(50, 109, 100, 15)];
    classDonePeriod.font = [UIFont systemFontOfSize:15];
    classDonePeriod.textColor = [UIColor blackColor];
    
    str = [NSString stringWithFormat:@"%ld/%ld课时",_classHours - _classHoursRemain,_classHours];
    classDonePeriod.text = str;
    [whiteZone addSubview:classDonePeriod];
    
    remainMoney = [[UILabel alloc] initWithFrame:CGRectMake(155, 111, self.view.frame.size.width - 10 - 155, 12)];
    remainMoney.font = [UIFont systemFontOfSize:15];
    remainMoney.textColor = RGBACOLOR(170, 170, 170, 1);
    
    amountPrice = _classHoursRemain * _price;
    str = [NSString stringWithFormat:@"剩余课时费：¥%.2f",amountPrice];
    remainMoney.text = str;
    remainMoney.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:remainMoney];
    
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 88, self.view.frame.size.width - 20, 8)];
    [progressView setProgress:(_classHours - _classHoursRemain) * 1.0 / _classHours];
    [whiteZone addSubview:progressView];
    
    [self initBottomBtn:whiteZone];
    
    orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 380, self.view.frame.size.width, 20)];
    orderIDLabel.textColor = RGBACOLOR(177, 177, 177, 1);
    
    str = [NSString stringWithFormat:@"订单号：%@",_orderIDStr];
    orderIDLabel.text = str;
    orderIDLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:orderIDLabel];
}

-(void)initUnpaidOrderSecondZone
{
    UIView * whiteZone = [[UIView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 164 + 10, self.view.frame.size.width, 203)];
    whiteZone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteZone];
    orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 16)];
    orderStatusLabel.text = @"待支付";
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 138, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    orderStatusLabel.font = [UIFont systemFontOfSize:16];
    orderStatusLabel.textColor = [UIColor blackColor];
    [whiteZone addSubview:orderStatusLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 62, 60, 13)];
    label.text = @"课程总时长：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, 112, 40, 13)];
    label.text = @"已完成：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(155, 17, self.view.frame.size.width - 155 - 10, 13)];
    totalPrice.font = [UIFont systemFontOfSize:12];
    totalPrice.textColor = RGBACOLOR(170, 170, 170, 1);
    
    CGFloat amountPrice = _price * _classHours;
    NSString *str = [NSString stringWithFormat:@"支付总额：¥%.2f",amountPrice];
    totalPrice.text = str;
    totalPrice.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:totalPrice];
    
    classTotalPeriod = [[UILabel alloc] initWithFrame:CGRectMake(70, 60, 100, 15)];
    classTotalPeriod.font = [UIFont systemFontOfSize:15];
    classTotalPeriod.textColor = [UIColor blackColor];
    str = [NSString stringWithFormat:@"%ld课时",_classHours];
    classTotalPeriod.text = str;
    [whiteZone addSubview:classTotalPeriod];
    
    classDonePeriod = [[UILabel alloc] initWithFrame:CGRectMake(50, 109, 100, 15)];
    classDonePeriod.font = [UIFont systemFontOfSize:15];
    classDonePeriod.textColor = [UIColor blackColor];
    
    str = [NSString stringWithFormat:@"%ld/%ld课时",_classHours - _classHoursRemain,_classHours];
    classDonePeriod.text = str;
    [whiteZone addSubview:classDonePeriod];
    
    remainMoney = [[UILabel alloc] initWithFrame:CGRectMake(155, 111, self.view.frame.size.width - 10 - 155, 12)];
    remainMoney.font = [UIFont systemFontOfSize:15];
    remainMoney.textColor = RGBACOLOR(170, 170, 170, 1);
    
    amountPrice = _classHoursRemain * _price;
    str = [NSString stringWithFormat:@"剩余课时费：¥%.2f",amountPrice];
    remainMoney.text = str;
    remainMoney.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:remainMoney];
    
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 88, self.view.frame.size.width - 20, 8)];
    [progressView setProgress:(_classHours - _classHoursRemain) * 1.0 / _classHours];
    [whiteZone addSubview:progressView];
    
    [self initBottomBtn:whiteZone];
    
    orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 380, self.view.frame.size.width, 20)];
    orderIDLabel.textColor = RGBACOLOR(177, 177, 177, 1);
    
    str = [NSString stringWithFormat:@"订单号：%@",_orderIDStr];
    orderIDLabel.text = str;
    orderIDLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:orderIDLabel];
}

-(void)initCompletedOrderSecondZone
{
    UIView * whiteZone = [[UIView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 164 + 10, self.view.frame.size.width, 203 - 64)];
    whiteZone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteZone];
    orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 16)];
    orderStatusLabel.text = @"已完成";
    
    UILabel *splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 44, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    splitLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 138, self.view.frame.size.width - 20, 1)];
    splitLine.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [whiteZone addSubview:splitLine];
    
    orderStatusLabel.font = [UIFont systemFontOfSize:16];
    orderStatusLabel.textColor = [UIColor blackColor];
    [whiteZone addSubview:orderStatusLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 62, 60, 13)];
    label.text = @"课程总时长：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, 112, 40, 13)];
    label.text = @"已完成：";
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = RGBACOLOR(170, 170, 170, 1);
    [whiteZone addSubview:label];
    
    totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(155, 17, self.view.frame.size.width - 155 - 10, 13)];
    totalPrice.font = [UIFont systemFontOfSize:12];
    totalPrice.textColor = RGBACOLOR(170, 170, 170, 1);
    
    CGFloat amountPrice = _price * _classHours;
    NSString *str = [NSString stringWithFormat:@"支付总额：¥%.2f",amountPrice];
    totalPrice.text = str;
    totalPrice.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:totalPrice];
    
    classTotalPeriod = [[UILabel alloc] initWithFrame:CGRectMake(70, 60, 100, 15)];
    classTotalPeriod.font = [UIFont systemFontOfSize:15];
    classTotalPeriod.textColor = [UIColor blackColor];
    str = [NSString stringWithFormat:@"%ld课时",_classHours];
    classTotalPeriod.text = str;
    [whiteZone addSubview:classTotalPeriod];
    
    classDonePeriod = [[UILabel alloc] initWithFrame:CGRectMake(50, 109, 100, 15)];
    classDonePeriod.font = [UIFont systemFontOfSize:15];
    classDonePeriod.textColor = [UIColor blackColor];
    
    str = [NSString stringWithFormat:@"%ld/%ld课时",_classHours - _classHoursRemain,_classHours];
    classDonePeriod.text = str;
    [whiteZone addSubview:classDonePeriod];
    
    remainMoney = [[UILabel alloc] initWithFrame:CGRectMake(155, 111, self.view.frame.size.width - 10 - 155, 12)];
    remainMoney.font = [UIFont systemFontOfSize:15];
    remainMoney.textColor = RGBACOLOR(170, 170, 170, 1);
    
    amountPrice = _classHoursRemain * _price;
    str = [NSString stringWithFormat:@"剩余课时费：¥%.2f",amountPrice];
    remainMoney.text = str;
    remainMoney.textAlignment = NSTextAlignmentRight;
    [whiteZone addSubview:remainMoney];
    
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 88, self.view.frame.size.width - 20, 8)];
    [progressView setProgress:(_classHours - _classHoursRemain) * 1.0 / _classHours];
    [whiteZone addSubview:progressView];
    
    orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 380 - 64, self.view.frame.size.width, 20)];
    orderIDLabel.textColor = RGBACOLOR(177, 177, 177, 1);
    
    str = [NSString stringWithFormat:@"订单号：%@",_orderIDStr];
    orderIDLabel.text = str;
    orderIDLabel.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:orderIDLabel];
}
-(void)buttonAction:(id)sender
{
    DBG(@"%s",__FUNCTION__);
    UIButton *btn = (UIButton *) sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            [self callingToTeacher];
            break;
            
        default:
            break;
    }
}

-(void)callingToTeacher
{
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.teacherPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

-(void)backToPrevousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)purchaseAgain:(id)sender
{
    DBG(@"%s",__FUNCTION__);
}

#pragma mark - HandleRequestDelegat Method
-(void)handSucceedOrderDetailRequest:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSInteger ret = [[jsonData objectForKey:@"ret"] intValue];
    
    self.teacherPhone = [[jsonData objectForKey:@"datas"] objectForKey:@"phone"];
    
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
