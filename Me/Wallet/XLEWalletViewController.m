////
////  XLEWalletViewController.m
////  XLEducation
////
////  Created by xiliedu on 15/2/11.
////  Copyright (c) 2015年 kin. All rights reserved.
////
//
//#import "XLEWalletViewController.h"
//#import "XLETransactionRecorderTableViewCell.h"
//
//@interface XLEWalletViewController ()
//{
//    UILabel *balanceLabel;
//    
//    UITableView *transactionRecordTV;
//    
//    XLEWalletInfoModal *walletInfo;
//}
//
//@end
//
//@implementation XLEWalletViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    [self initNavgation];
//    [self initBalance];
//    [self initTableView];
//    
//    [self initWalletRequest];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)initWalletRequest
//{
//    walletInfo = [[XLEWalletInfoModal alloc] init];
//    walletInfo.delegate = self;
//    [walletInfo requestBalance];
//    [walletInfo requestTransactionRecords];
//}
//-(void)initNavgation
//{
//    NavigationView *nav = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"钱包" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO];
//    //    nav.backgroundColor = RGBACOLOR(238, 238, 238, 1);
//    nav.backgroundColor = RGBACOLOR(124, 176, 38, 1);
//    [self.view addSubview:nav];
//    
//    for (UIView *subview in nav.subviews)
//    {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)subview;
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//        if ([subview isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel *)subview;
//            [label setTextColor:[UIColor whiteColor]];
//        }
//    }
//    
//}
//
//-(void)backToPrevousView:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//-(void)initBalance
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, 95)];
//    label.backgroundColor = RGBACOLOR(124, 176, 38, 1);
//    [self.view addSubview:label];
//    
//    label = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 20, 100, 14)];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:14];
//    label.text = @"当前余额";
//    [self.view  addSubview:label];
//    
//    balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (IOSNAVIGATIONSIZE) + 52, self.view.frame.size.width - 20, 20)];
//    balanceLabel.textColor = [UIColor whiteColor];
//    balanceLabel.font = [UIFont systemFontOfSize:20];
////    balanceLabel.text = @"10000.00";
//    [self.view  addSubview:balanceLabel];
//}
//
//-(void)initTableView
//{
//    transactionRecordTV = [[UITableView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 100, self.view.frame.size.width, self.view.frame.size.height - (IOSNAVIGATIONSIZE) - 60)];
//    transactionRecordTV.delegate = self;
//    transactionRecordTV.dataSource = self;
//    
//    if ([transactionRecordTV respondsToSelector:@selector(setSeparatorInset:)]) {
//        [transactionRecordTV setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([transactionRecordTV respondsToSelector:@selector(setLayoutMargins:)]) {
//        [transactionRecordTV setLayoutMargins:UIEdgeInsetsZero];
//    }
//    
//    [self.view addSubview:transactionRecordTV];
//}
//
//#pragma mark - OrderTableView Delegate
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    NSInteger num = [walletInfo.transactionRecords count];
//    if (num >0) {
//        tableView.hidden = NO;
//        return num;
//    }
//    else
//    {
//        tableView.hidden = YES;
//        return 0;
//    }
////    return 3;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return TRANSACTION_RECOREDER_ORDER_CELL_HEIGHT;
//}
//
//- (XLETransactionRecorderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *reuseIdentifier = @"XLETransactionRecorderTableViewCell";
//    XLETransactionRecorderTableViewCell *cell=[transactionRecordTV dequeueReusableCellWithIdentifier: reuseIdentifier];
//    if (cell == nil) {
//        cell = [[XLETransactionRecorderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
////        cell.serialNumLabel.text = @"流水号：1234567890";
////        cell.typeLabel.text = @"课程支付";
////        cell.timelabel.text = @"2015-02-05 11:00";
////        cell.amountlabel.text = @"－5000";
////        cell.teacherCourseClasshourLabel.text = @"仁中义－初中英语－10课时";
//        
//        NSDictionary *cellData = [walletInfo.transactionRecords objectAtIndex:indexPath.row];
//        NSString *str;
//        str = [NSString stringWithFormat:@"流水号：%@",[cellData objectForKey:@"swift_no"]];
//        cell.serialNumLabel.text = str;
//        
//        cell.timelabel.text = [cellData objectForKey:@"update_at"];
//        cell.amountlabel.text = [cellData objectForKey:@"fee"];
//        cell.typeLabel.text = [self parseTransactionType:[[cellData objectForKey:@"type"] intValue]];
//    }
//    
//
//    
//    return cell;
//}
//
//-(NSString *)parseTransactionType:(NSInteger)type
//{
//    switch (type) {
//        case 1:
//
//        case 2:
//            return @"提现";
//        case 3:
//            return @"教课收入";
//        case 4:
//            return @"订单支出";
//        case 5:
//            return @"约课支出";
//        default:
//            return @"未知";
//    }
//}
//
//-(void)handleSucceedRequest:(ASIHTTPRequest *)request
//{
//    if (request.tag == 1) {
//        balanceLabel.text = [NSString stringWithFormat:@"%.2f",walletInfo.balance];
//    }
//    if (request.tag == 2) {
//        [transactionRecordTV reloadData];
//    }
//}
//
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
