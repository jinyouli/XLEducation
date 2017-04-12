//
//  XLETeachersCommentViewController.m
//  XLEducation
//
//  Created by xiliedu on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLETeachersCommentViewController.h"
#import "NavigationView.h"
#import "XLETeachersCommetsTableViewCell.h"

@interface XLETeachersCommentViewController ()
{
    UILabel *movingLine;
    NSMutableArray *buttonItems;
    UITableView *commentTableView;
    
    XLETeachersComments *allComments;
    NSInteger rows;
}

@end

@implementation XLETeachersCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadNavgation];
    [self loadToolBar];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadNavgation
{
    NavigationView *navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) CNavigationTitle:@"老师的教学日志" LeftNavigationTitle:@"我" LeftTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LeftAction:@selector(backToPreviousView:) LeftButtonBool:NO];
    [self.view addSubview:navigationView];
    
    navigationView.backgroundColor = RGBACOLOR(125, 176, 38, 1);
    for (UIView *subview in navigationView.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            [label setTextColor:[UIColor whiteColor]];
        }
    }
    
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
}

-(void)loadToolBar
{
    UILabel *lineBack = [[UILabel alloc]initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 60, self.view.frame.size.width, 1.5)];
    lineBack.backgroundColor = RGBACOLOR(124, 178, 15, 0.2);
    [self.view addSubview:lineBack];
    
    movingLine = [[UILabel alloc]initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 60, self.view.frame.size.width / 4, 2)];
    movingLine.backgroundColor = RGBACOLOR(124, 178, 15, 1);
    [self.view addSubview:movingLine];
    
    buttonItems = [[NSMutableArray alloc] initWithCapacity:4];
    NSArray *TitleArray = @[@"全部",@"好评",@"中评",@"差评"];
    for (NSInteger i = 0; i < [TitleArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[TitleArray objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:RGBACOLOR(124, 178, 15, 1) forState:UIControlStateSelected];
        button.tag = 1 + i;
        if (button.tag == 1) {
            button.selected = YES;
        }
        button.frame=CGRectMake(self.view.frame.size.width/4*i, (IOSNAVIGATIONSIZE), self.view.frame.size.width/4, 60);
        [button addTarget:self action:@selector(showComments:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [buttonItems addObject:button];
    }
}

-(void)initTableView
{
    commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (IOSNAVIGATIONSIZE) + 60 + 2, self.view.frame.size.width, self.view.frame.size.height - ((IOSNAVIGATIONSIZE) + 60 + 2))];
    commentTableView.dataSource = self;
    commentTableView.delegate = self;
    [self.view addSubview:commentTableView];
    
    allComments = [[XLETeachersComments alloc] init];
    [allComments requestCommentsPage:1 type:0];
    allComments.delegate = self;
    
    if ([commentTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [commentTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([commentTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [commentTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - selectors

-(void)backToPreviousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];    
}

-(void)showComments:(id)sender
{
    UIButton *button = (UIButton *)sender;
    for (UIButton * item in buttonItems) {
        item .selected = NO;
    }
    button.selected = YES;
    movingLine.frame = CGRectMake((button.tag - 1) * self.view.frame.size.width / 4, (IOSNAVIGATIONSIZE) + 60, self.view.frame.size.width / 4, 2);
    [allComments requestCommentsPage:1 type:(button.tag - 1)];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger ret = [allComments.comments count];
    if (ret == 0) {
        commentTableView.hidden = YES;
    }
    else
    {
        commentTableView.hidden = NO;
        commentTableView.frame = CGRectMake(0, (IOSNAVIGATIONSIZE) + 60 + 2, self.view.frame.size.width, ret * CELLHEIGHT);
    }
    return ret;//will return dynamic value
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHEIGHT;
}

- (XLETeachersCommetsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell";
    XLETeachersCommetsTableViewCell *cell=[commentTableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil) {
        cell = [[XLETeachersCommetsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = self.view.backgroundColor;
    }
    NSDictionary *comment = [allComments.comments objectAtIndex:indexPath.row];
    cell.commentLable.text = [comment objectForKey:@"comment_student"];
//    cell.commentLable.text = @"好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好";
    cell.nameLabel.text = [[ comment objectForKey:@"orderInfo"] objectForKey:@"teacher_name"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[comment objectForKey:@"booking_time"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.dateLabel.text = [dateFormatter stringFromDate:date];
    
    NSString *course = [NSString stringWithFormat:@"%@%@",[comment objectForKey:@"grade_name"],[comment objectForKey:@"course_name"]];
    cell.courseLabel.text = course;
    
    [self setStarImages:cell.starIndicators score:[[comment objectForKey:@"score_student"] integerValue]];

    NSString *str = @"http://api.xsw100.com/account/face/";
    NSString *urlStr = [str stringByAppendingString:[comment objectForKey:@"teacher_uid"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    cell.headImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return cell;
}

-(void)setStarImages:(NSMutableArray *)starsArray score:(NSInteger)score
{
    for (int i = 0; i< score; i++) {
        UIImageView *imageView = (UIImageView *)[starsArray objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"smallstar_green"];
    }
    for (int i = score; i < 5; i++) {
        UIImageView *imageView = (UIImageView *)[starsArray objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"smallstar_gray" ];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Comments Delegate Method
-(void)updateCommentUI
{
    DBG(@"%s",__FUNCTION__);
    [commentTableView reloadData];
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
