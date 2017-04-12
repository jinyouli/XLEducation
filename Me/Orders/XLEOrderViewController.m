//
//  XLEOrderViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEOrderViewController.h"
#import "NavigationView.h"
#import "XLEOrderTableViewCell.h"
#import "XLEOrderDetailViewController.h"

@interface XLEOrderViewController ()
{
    UILabel *movingLine;
    NSMutableArray *toolBarItems;
    NSMutableArray *numberIndicators;
    UITableView *orderTable;
    
    XLEViewOrderRequest *requestOrderList;
    NSMutableArray *ordersData;
    
}

@end

@implementation XLEOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavgation];
    [self initTopToolBar];
    [self initOrderTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavgation
{
    NavigationView *nav = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"订单" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO];
//    nav.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    [self.view addSubview:nav];
    
}

-(void)backToPrevousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTopToolBar
{
    UILabel *lineBack = [[UILabel alloc]initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 45, self.view.frame.size.width, 1.5)];
    lineBack.backgroundColor = RGBACOLOR(124, 178, 15, 0.2);
    [self.view addSubview:lineBack];
    
    movingLine = [[UILabel alloc]initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 45, self.view.frame.size.width / 3, 2)];
    movingLine.backgroundColor = RGBACOLOR(124, 178, 15, 1);
    [self.view addSubview:movingLine];
    
    toolBarItems = [[NSMutableArray alloc] initWithCapacity:3];
    numberIndicators = [[NSMutableArray alloc] initWithCapacity:2];
    NSArray *TitleArray = @[@"全部",@"待支付",@"进行中"];
    for (NSInteger i = 0; i < [TitleArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[TitleArray objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:RGBACOLOR(124, 178, 15, 1) forState:UIControlStateSelected];
        button.tag = 1 + i;
        button.frame=CGRectMake(self.view.frame.size.width/3*i, (IOSNAVIGATIONSIZE), self.view.frame.size.width/3, 45);
        if (button.tag == 1) {
            button.selected = YES;
        }
        else
        {
            [button setTitleEdgeInsets:(UIEdgeInsetsMake(15, 0, 30, 0))];
            UILabel *numberIndicator;
            numberIndicator = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4, (IOSNAVIGATIONSIZE) + 25, self.view.frame.size.width/4, 15)];
            numberIndicator.textAlignment = NSTextAlignmentCenter;
            numberIndicator.font = [UIFont systemFontOfSize:13];
//            nuberIndicator.textColor = WORDLCOLOR;
            [self.view addSubview:numberIndicator];
            [numberIndicators addObject:numberIndicator];
        }
        
        [button addTarget:self action:@selector(showOrders:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [toolBarItems addObject:button];
    }
    
}

-(void)showOrders:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag - 1;
    
    movingLine.frame = CGRectMake(index * self.view.frame.size.width / 3, (IOSNAVIGATIONSIZE) + 45, self.view.frame.size.width / 3, 2);
    
    for (UIButton *item in toolBarItems) {
        item.selected = NO;
    }
    btn.selected = YES;
    if (index == 0) {
        [requestOrderList requestOrderListPage:1 type:0];
    }
    else if (index == 1)
    {
        [requestOrderList requestOrderListPage:1 type:2];
    }
    else if(index == 2)
    {
        [requestOrderList requestOrderListPage:1 type:1];
    }
    
}

-(void)initOrderTable
{
    orderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 45 + 2, self.view.frame.size.width, self.view.frame.size.height - (IOSNAVIGATIONSIZE) - 45 )];
    [self.view addSubview:orderTable];
    
    orderTable.delegate = self;
    orderTable.dataSource = self;
    [orderTable setSeparatorColor:RGBACOLOR(238, 238, 238, 1)];
    if ([orderTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [orderTable setSeparatorInset:UIEdgeInsetsZero];
    }
    
//    if ([orderTable respondsToSelector:@selector(setLayoutMargins:)]) {
//        [orderTable setLayoutMargins:UIEdgeInsetsZero];
//    }
    
    ordersData = [[NSMutableArray alloc] initWithCapacity:10];
    requestOrderList = [[XLEViewOrderRequest alloc] init];
    requestOrderList.delegate = self;
    [requestOrderList requestOrderListPage:1 type:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *CELL_ID2 = @"SOME_STUPID_ID2";
//    // even rows will be invisible
//    if (indexPath.row % 2 == 1)
//    {
//        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:CELL_ID2];
//        
//        if (cell2 == nil)
//        {
//            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:CELL_ID2];
//            [cell2.contentView setAlpha:0];
//            [cell2 setUserInteractionEnabled:NO]; // prevent selection and other stuff
//        }
//        return cell2;
//    }
//    
//    [ccTableView setBackgroundColor:[UIColor clearColor]];
//    cardsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cardsCell"];
//    
//    if(cell == nil){
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cardsCell" owner:self options:nil];
//        cell = [topLevelObjects objectAtIndex:0];
//    }
//    
//    // Use indexPath.row/2 instead of indexPath.row for the visible section to get the correct datasource index (number of rows is increased to add the invisible rows)
//    NSString *nmCard = [[self.cards valueForKeyPath:@"cards.name"] objectAtIndex:(indexPath.row/2)];
//    cell.descCardLabel.text = nmCard;
//    
//    return cell;
//}
//
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    // two times minus one (invisible at even rows => visibleCount == invisibleCount+1)
//    return [[self.cards valueForKeyPath:@"cards"] count] * 2 - 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row % 2 == 1)
//        return 40;
//    return 162;
//}

#pragma mark - OrderTableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger num = [ordersData count];
    if (num <= 0) {
        tableView.hidden = YES;
    }
    else
    {
        tableView.hidden = NO;
    }
    return num;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ORDER_CELL_HEIGHT;
}

- (XLEOrderTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *reuseIdentifier = @"cell";
    XLEOrderTableViewCell *cell=[orderTable dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil) {
        cell = [[XLEOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    NSDictionary *cellData = [ordersData objectAtIndex:indexPath.row];
    
    cell.orderTimeLabel.text = [cellData objectForKey:@"order_time"];
    
    cell.teacherName.text = [cellData objectForKey:@"teacher_name"];
    
    NSString *str = [NSString stringWithFormat:@"¥%@",[cellData objectForKey:@"price"]];
    cell.pricelabel.text = str;
    
    str = @"http://api.xsw100.com/account/face/";
    NSString *urlStr = [str stringByAppendingString:[cellData objectForKey:@"teacher_uid"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    cell.teacherHead.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    str = [NSString stringWithFormat:@"x%@",[cellData objectForKey:@"class_hours"]];
    cell.amountLabel.text = str;
    
    str = [NSString stringWithFormat:@"%@%@， %@课时",[cellData objectForKey:@"grade_name"],[cellData objectForKey:@"course_name"],[cellData objectForKey:@"class_hours"]];
    cell.courselabel.text = str;
    
    str = [NSString stringWithFormat:@"¥%@",[cellData objectForKey:@"price_total"]];
    cell.totalPricelabel.text = str;
    
    [cell.payOrInviteCourseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switch ([[cellData objectForKey:@"status"] integerValue]) {
        case 0:
        {
            cell.orderprocessLabel.text = @"已完成";
//            [cell.payOrInviteCourseBtn setTitle:@"已完成" forState:UIControlStateNormal];
            cell.payOrInviteCourseBtn.hidden = YES;
            break;
        }
        case 1:
        {
            cell.orderprocessLabel.text = @"待支付";
            [cell.payOrInviteCourseBtn setTitle:@"前往支付" forState:UIControlStateNormal];
            cell.payOrInviteCourseBtn.backgroundColor = RGBACOLOR(252, 110, 34, 1);
            break;
        }
        case 2:
        {
            cell.orderprocessLabel.text = @"进行中";
            [cell.payOrInviteCourseBtn setTitle:@"发起约课" forState:UIControlStateNormal];
            cell.payOrInviteCourseBtn.backgroundColor = RGBACOLOR(127, 171, 46, 1);
            break;
        }
        case 3:
        {
            cell.orderprocessLabel.text = @"已取消";
//            [cell.payOrInviteCourseBtn setTitle:@"已取消" forState:UIControlStateNormal];
            cell.payOrInviteCourseBtn.hidden = YES;
            break;
        }
        default:
            break;
    }
    
    cell.orderID = [cellData objectForKey:@"order_id"];
    cell.price = [[cellData objectForKey:@"price"] integerValue];
    cell.classHours = [[cellData objectForKey:@"class_hours"] integerValue];
    cell.classHoursRemain = [[cellData objectForKey:@"class_hours_remain"] integerValue];
    cell.orderStatus = [[cellData objectForKey:@"status"] integerValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    XLEOrderTableViewCell *cell = (XLEOrderTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XLEOrderDetailViewController *orderDetailVC = [[XLEOrderDetailViewController alloc] init];
    orderDetailVC.orderIDStr = cell.orderID;
    orderDetailVC.price = cell.price;
    orderDetailVC.classHours = cell.classHours;
    orderDetailVC.classHoursRemain = cell.classHoursRemain;
    orderDetailVC.orderStatus = cell.orderStatus;

    orderDetailVC.orderTimeStr = cell.orderTimeLabel.text;
    orderDetailVC.teacherHeadImage = cell.teacherHead.image;
    orderDetailVC.teacherNameStr = cell.teacherName.text;
    
    NSRange range;
    range.location = 0;
    range.length = [cell.courselabel.text rangeOfString:@"，"].location;
    orderDetailVC.coureStr = [cell.courselabel.text substringWithRange:range];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

#pragma mark - HandleRequestDelegat method;
-(void)handSucceedOrderListRequest:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSInteger ret = [[jsonData objectForKey:@"ret"] intValue];
    
    [ordersData removeAllObjects];
    if ([jsonData count] >= 5 && ret == 0) {
        [ordersData addObjectsFromArray:[jsonData objectForKey:@"datas"]];
    }
    
    [orderTable reloadData];
    
}
@end
