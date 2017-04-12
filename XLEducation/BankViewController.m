//
//  BankViewController.m
//  XLEducation
//
//  Created by kin on 15/3/19.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController ()
{
    NSArray *bankDicArray;
    NSArray *BankArray;
    NSArray *bankIamge;
}
@end

@implementation BankViewController

@synthesize BankTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self NavigationSetting];
    [self ControlsGenerate];
}
-(void)NavigationSetting
{
    self.title = @"选择银行卡";
    NSDictionary *titleDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:LoinFont};
    [self.navigationController.navigationBar setTitleTextAttributes:titleDictionary];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right_return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftClicked)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    

//    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:@"添卡" CNavigationTitle:@"选择银行卡" RNavigationTitle:@"" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LAction:@selector(LeftClicked) WithRightTarget:self RAction:@selector(RigthClicked)  buttonColor:WORDLCOLOR];
//    [self.view addSubview:navigationView];
}
-(void)ControlsGenerate
{

    
//    bankDicArray = @[@{@"ICBCB2C":@"中国工商银行"},@{@"CMB":@"招商银行"},@{@"BOCB2C":@"中国银行"},@{@"CCB":@"中国建设银行"},@{@"BCM":@"中国交通银行"},@{@"ABC":@"中国农业银行"},@{@"GZRCB":@"广州农商银行"},@{@"SPDB":@"浦发银行"},@{@"CIB":@"兴业银行"},@{@"GDB":@"广发银行"},@{@"FDB":@"富滇银行"},@{@"CITIC":@"中信银行"},@{@"HZCBB2C":@"杭州银行"},@{@"SHBANK":@"上海银行"},@{@"NBBANK":@"宁波银行"},@{@"SPABANK":@"平安银行"},@{@"POSTGC":@"中国邮政储蓄银行"},@{@"CMBC":@"民生银行"},@{@"CEB":@"光大银行"},@{@"BJBANK":@"北京银行"},@{@"HXB":@"华夏银行"},@{@"CDBANK":@"成都银行"},@{@"CDRCB":@"成都农商银行"}];
//    BankArray = @[@"ICBCB2C",@"CMB",@"BOCB2C",@"CCB",@"BCM",@"ABC",@"GZRCB",@"SPDB",@"CIB",@"GDB",@"FDB",@"CITIC",@"HZCBB2C",@"SHBANK",@"NBBANK",@"SPABANK",@"POSTGC",@"CMBC",@"CEB",@"BJBANK",@"HXB",@"CDBANK",@"CDRCB"];

    bankDicArray = @[@{@"BOCB2C":@"中国银行"},@{@"CMB":@"招商银行"},@{@"ICBCB2C":@"中国工商银行"},@{@"ABC":@"中国农业银行"},@{@"CCB":@"中国建设银行"},@{@"POSTGC":@"中国邮政储蓄银行"},@{@"BCM":@"中国交通银行"},@{@"GZRCB":@"广州农商银行"}];

    BankArray = @[@"BOCB2C",@"CMB",@"ICBCB2C",@"ABC",@"CCB",@"POSTGC",@"BCM",@"GZRCB"];
    
    bankIamge = @[@"bocb2c@2x.png",@"cmb@2x.png",@"icbcb2c@2x.png",@"abc@2x.png",@"ccb@2x.png",@"postgc@2x.png",@"bcm@2x.png",@"gzrcb@2x.png"];
    
    self.BankTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height)) style:(UITableViewStyleGrouped)];
    self.BankTableView.delegate=self;
    self.BankTableView.dataSource=self;
    [self.view addSubview:self.BankTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [BankArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *indenty=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indenty];
        if (nil==cell)
        {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenty];
        }
//        cell.contentView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
        NSArray *arraycell=[cell.contentView subviews];
        for (UIView *coview in arraycell) {
            [coview removeFromSuperview];
        }
        UIImageView *bankImage = [[UIImageView alloc]init];
        bankImage.frame = CGRectMake(15,5,35, 35);
        bankImage.image = [UIImage imageNamed:[bankIamge objectAtIndex:indexPath.row]];
        bankImage.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:bankImage];
    
        UILabel*logingLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0,Screen_Width, 45)];
        logingLable.textColor = [UIColor blackColor];
        logingLable.text = [[bankDicArray objectAtIndex:indexPath.row] objectForKey:[BankArray objectAtIndex:indexPath.row]];
        logingLable.font = [UIFont systemFontOfSize:18];
        [cell.contentView addSubview:logingLable];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate bankCellInfo:[bankDicArray objectAtIndex:indexPath.row] bankName:[BankArray objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)LeftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)RigthClicked
{
    return;
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
