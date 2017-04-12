//
//  XLEGenderViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEGenderViewController.h"

@interface XLEGenderViewController ()
{
    UITableView *genderTableView;
}
@end

@implementation XLEGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
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

-(void)backToPrevousView:(id)sender
{
    //    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(setGender:)]) {
            [self.delegate setGender:(BOOL)self.selectedRow];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initView
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"性别" LeftNavigationTitle:@"个人信息" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPrevousView:) LeftButtonBool:NO LeftTileLength:100];
    [self.view addSubview:navigationView];
    
//    UIButton  *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    backBtn.frame = CGRectMake(30, 20, 60, 44);
//    backBtn.tag = 1;
//    //    backBtn.titleLabel.text = @"push";
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [backBtn setTitle:@"个人信息" forState:(UIControlStateNormal)];
//    [backBtn addTarget:self action:@selector(backToPrevousView:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:backBtn];
    
    genderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,(IOSNAVIGATIONSIZE) + 20, self.view.frame.size.width, 88)];
    genderTableView.delegate = self;
    genderTableView.dataSource = self;
    [self.view addSubview:genderTableView];
    
    self.tabBarController.view.hidden = YES;
}

#pragma mark - datasource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self generateCell:@"男" cellForRowAtIndexPath:indexPath];
    } else {
         return [self generateCell:@"女" cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *) generateCell:(NSString *)manOrWoman cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[genderTableView dequeueReusableCellWithIdentifier: manOrWoman];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:manOrWoman];
        cell.contentView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        cell.textLabel.text = manOrWoman;
    }
    if (indexPath.row == self.selectedRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRow = indexPath.row;
    [tableView reloadData];
}

@end
