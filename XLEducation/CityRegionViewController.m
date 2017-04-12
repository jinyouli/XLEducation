//
//  CityRegionViewController.m
//  XLEducation
//
//  Created by kin on 15/7/27.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "CityRegionViewController.h"
#import "CityRegion.h"


@interface CityRegionViewController ()

@end

@implementation CityRegionViewController
@synthesize cityID,subArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CityRegion *CityRe = [[CityRegion alloc]init];
    self.subArray = [CityRe cityPathId:@"440100"];
    
    UITableView *cityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,Screen_Width,(Screen_Height))];
    //    self.ArchitectMessageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cityTableView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    cityTableView.delegate=self;
    cityTableView.dataSource=self;
    [self.view addSubview:cityTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subArray  count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*(UIDeviceWidth);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *indenfault = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenfault];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:indenfault];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = listFont;
    cell.textLabel.text = [[subArray  objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
