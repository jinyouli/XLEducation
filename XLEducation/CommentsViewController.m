//
//  CommentsViewController.m
//  XLEducation
//
//  Created by kin on 15/2/5.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "CommentsViewController.h"
#import "PersonView.h"
#import "AllCommentsView.h"
#import "HighPraiseView.h"
#import "EvaluationView.h"
#import "ReviewView.h"
@interface CommentsViewController ()<UIScrollViewDelegate,AllCommentsdelegate,HighPraisedelegate,Evaluationdelegate,Reviewdelegate>
{
    NavigationView*navigationView;
    PersonView *person;
}

@end

@implementation CommentsViewController

@synthesize seleButtonArray,lineMove,teachingId,teachingImage,teachingName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    [self NavigationSetting];
    [self ControlsGenerate];
}
-(void)NavigationSetting
{
    navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:@"详情" CNavigationTitle:@"评价" RNavigationTitle:@"" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LAction:@selector(LeftClicked) WithRightTarget:self RAction:@selector(RigthClicked)  buttonColor:WORDLCOLOR];
    [self.view addSubview:navigationView];
}
-(void)ControlsGenerate
{
    person = [[PersonView alloc]initWithFrame:CGRectMake(0, IOSNAVIGATIONSIZE, Screen_Width, 80) perteachImage:teachingImage teachName:teachingName];
    person.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:person];
    self.seleButtonArray = [[NSMutableArray alloc]init];
    NSArray *TitleArray = @[@"全部(0)",@"好评(0)",@"中评(0)",@"差评(0)"];
    for (int i = 0; i < [TitleArray count]; i++)
    {
        UIButton  *seleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        seleButton.frame = CGRectMake(self.view.frame.size.width/4*i,person.frame.size.height+(IOSNAVIGATIONSIZE)+1, self.view.frame.size.width/4, 45);
        seleButton.backgroundColor = [UIColor whiteColor];
        seleButton.tag = i;
        seleButton.titleLabel.text = [TitleArray objectAtIndex:i];
        seleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [seleButton setTitle:seleButton.titleLabel.text forState:(UIControlStateNormal)];
        [self.seleButtonArray addObject:seleButton];
        [seleButton addTarget:self action:@selector(seleBUttonTitle:) forControlEvents:(UIControlEventTouchUpInside)];
        if (seleButton.tag == 0)
        {
            [seleButton setTitleColor:WORDLCOLOR forState:(UIControlStateNormal)];
        }
        else
        {
            [seleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        [self.view addSubview:seleButton];
    }
    UILabel *lineBack = [[UILabel alloc]initWithFrame:CGRectMake(0,person.frame.size.height+(IOSNAVIGATIONSIZE)+46, self.view.frame.size.width, LINESIZE)];
    lineBack.backgroundColor = RGBACOLOR(124, 178, 15, 0.2);
    [self.view addSubview:lineBack];
    self.lineMove = [[UILabel alloc]initWithFrame:CGRectMake(0,person.frame.size.height+(IOSNAVIGATIONSIZE)+46, self.view.frame.size.width/4, LINESIZE)];
    self.lineMove.backgroundColor = WORDLCOLOR;
    [self.view addSubview:self.lineMove];
    
    self.XLCourseScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, lineBack.frame.origin.y+lineBack.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-lineBack.frame.origin.y+lineBack.frame.size.height)];
    self.XLCourseScrollview.contentSize=CGSizeMake( self.view.frame.size.width*4, self.view.frame.size.height-lineBack.frame.origin.y+lineBack.frame.size.height-50);
    [self.XLCourseScrollview setShowsVerticalScrollIndicator:NO];
    [self.XLCourseScrollview setShowsHorizontalScrollIndicator:NO];
    self.XLCourseScrollview.delegate=self;
    self.XLCourseScrollview.bounces = NO;
    self.XLCourseScrollview.pagingEnabled=YES;
    [self.view addSubview:self.XLCourseScrollview];
    
    
    AllCommentsView *AllComments = [[AllCommentsView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.XLCourseScrollview.frame.size.height) teachingId:teachingId];
    AllComments.delegate = self;
    [self.XLCourseScrollview addSubview:AllComments];
    
    HighPraiseView *HighPraise = [[HighPraiseView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.XLCourseScrollview.frame.size.height) teachingId:teachingId];
    HighPraise.delegate = self;
    [self.XLCourseScrollview addSubview:HighPraise];
    
    EvaluationView *Evaluation = [[EvaluationView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.XLCourseScrollview.frame.size.height) teachingId:teachingId];
    Evaluation.delegate = self;
    [self.XLCourseScrollview addSubview:Evaluation];
    
    ReviewView *Review = [[ReviewView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3, 0, self.view.frame.size.width, self.XLCourseScrollview.frame.size.height) teachingId:teachingId];
    Review.delegate = self;
    [self.XLCourseScrollview addSubview:Review];
}

-(void)seleBUttonTitle:(UIButton *)sender
{
    for (int i = 0; i < [seleButtonArray count]; i++)
    {
        if (sender == [self.seleButtonArray objectAtIndex:i])
        {
            [[self.seleButtonArray objectAtIndex:i] setTitleColor:WORDLCOLOR forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.2 animations:^{
                self.lineMove.frame = CGRectMake(self.view.frame.size.width/4*i,80+(IOSNAVIGATIONSIZE)+46, self.view.frame.size.width/4, LINESIZE);
            }];
            [self.XLCourseScrollview setContentOffset:CGPointMake(self.view.frame.size.width*i,0) animated:YES];
        }
        else
        {
            [[self.seleButtonArray objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x=scrollView.contentOffset.x;
    CGFloat w=scrollView.bounds.size.width;
    int j=x/w;
    
    for (int i = 0; i < [seleButtonArray count]; i++)
    {
        if (i == j)
        {
            [[self.seleButtonArray objectAtIndex:i] setTitleColor:WORDLCOLOR forState:(UIControlStateNormal)];
            [UIView animateWithDuration:0.2 animations:^{
                self.lineMove.frame = CGRectMake(self.view.frame.size.width/4*i,(IOSNAVIGATIONSIZE)+126, self.view.frame.size.width/4, LINESIZE);
            }];
            [self.XLCourseScrollview setContentOffset:CGPointMake(self.view.frame.size.width*i,0) animated:YES];
        }
        else
        {
            [[self.seleButtonArray objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
    }
    if(j==3)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineMove.frame = CGRectMake(self.view.frame.size.width/4*3,(IOSNAVIGATIONSIZE)+126, self.view.frame.size.width/4, LINESIZE);
        }];
        
    }
    else if(j==2)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineMove.frame = CGRectMake(self.view.frame.size.width/4*2,(IOSNAVIGATIONSIZE)+126, self.view.frame.size.width/4, LINESIZE);
        }];
        
    }
    else if(j==1)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineMove.frame = CGRectMake(self.view.frame.size.width/4,(IOSNAVIGATIONSIZE)+126, self.view.frame.size.width/4, LINESIZE);
        }];
        
    }
    else if(j==0)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineMove.frame = CGRectMake(0,(IOSNAVIGATIONSIZE)+126, self.view.frame.size.width/4, LINESIZE);
        }];
    }
}

-(void)AllCommentsdelegate:(NSString *)Number
{
    [[self.seleButtonArray objectAtIndex:0] setTitle:[NSString stringWithFormat:@"全部(%@)",Number] forState:(UIControlStateNormal)];
    [person plLabelNumber:Number];
}
-(void)HighPraiseNumber:(NSString *)Number
{
    [[self.seleButtonArray objectAtIndex:1] setTitle:[NSString stringWithFormat:@"好评(%@)",Number] forState:(UIControlStateNormal)];
}
-(void)EvaluationNumber:(NSString *)Number
{
    [[self.seleButtonArray objectAtIndex:2] setTitle:[NSString stringWithFormat:@"中评(%@)",Number] forState:(UIControlStateNormal)];
}
-(void)ReviewNumber:(NSString *)Number
{
    [[self.seleButtonArray objectAtIndex:3] setTitle:[NSString stringWithFormat:@"差评(%@)",Number] forState:(UIControlStateNormal)];
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
