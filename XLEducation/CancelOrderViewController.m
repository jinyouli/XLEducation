//
//  CancelOrderViewController.m
//  XLEducation
//
//  Created by kin on 15/3/24.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "CancelOrderViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "XLQuestWork.h"
#import "Common.h"
#import "CancellationLanding.h"

@interface CancelOrderViewController ()<ASIHTTPRequestDelegate,UIAlertViewDelegate>
{
    NavigationView *navigationView;
    UITextView *contionTextView;
    UIView *backView;
    NSArray *contionArray;
    UIImageView *radioImageView;
    UIButton *button[4];
    
}
@property(retain,nonatomic)NSMutableData *XLAllCoursesData;
@end

@implementation CancelOrderViewController

@synthesize buttonArray,CancelOrderDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self NavigationSetting];
    [self ControlsGenerate];
}

-(void)NavigationSetting
{
    self.title = @"取消订单";
    NSDictionary *titleDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:LoinFont};
    [self.navigationController.navigationBar setTitleTextAttributes:titleDictionary];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right_return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftClicked)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc]initWithTitle:@"确认" style:0 target:self action:@selector(RigthClicked)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
    
    
    //    navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IOSNAVIGATIONSIZE) LNavigationTitle:@"详情" CNavigationTitle:@"取消订单" RNavigationTitle:@"确认取消" RLTitleHeith:IOSVERSIONSIZE WithLeftTarget:self LAction:@selector(LeftClicked) WithRightTarget:self RAction:@selector(RigthClicked) buttonColor:WORDLCOLOR];
    //    [self.view addSubview:navigationView];
}
-(void)ControlsGenerate
{
    backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, IOSNAVIGATIONSIZE, self.view.frame.size.width, self.view.frame.size.height-navigationView.frame.size.height);
    [self.view addSubview:backView];
    [self.view insertSubview:navigationView aboveSubview:backView];
    
    buttonArray = [[NSMutableArray alloc]init];
    contionArray =@[@"联系不上老师",@"时间和老师对不上",@"对老师授课过程不满意",@"其它原因"];
    for (int i = 0 ; i < 4; i++) {
        UIImageView *useImageView = [[UIImageView alloc] init];
        useImageView.frame = CGRectMake(0,45*(i+1), self.view.frame.size.width, 1);
        useImageView.image = [UIImage imageNamed:@"rule.png"];
        [backView addSubview:useImageView];
        
        UILabel *tNameLabel = [[UILabel alloc]init];
        tNameLabel.frame = CGRectMake(15, 45*i, self.view.frame.size.width-100, 45);
        tNameLabel.textAlignment = NSTextAlignmentLeft;
        tNameLabel.text = [contionArray objectAtIndex:i];
        tNameLabel.font = [UIFont systemFontOfSize:15];
        tNameLabel.textColor = [UIColor grayColor];
        [backView addSubview:tNameLabel];
        
        
        UIImageView *rigthImageView = [[UIImageView alloc] init];
        rigthImageView.frame = CGRectMake((Screen_Width-40),10+45*i, 25, 25);
        rigthImageView.image = [UIImage imageNamed:@"radio_box_empty.png"];
        [backView addSubview:rigthImageView];
        
        
        button[i] = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button[i].tag = i;
        button[i].selected = YES;
        button[i].frame = CGRectMake(0,45*i, Screen_Width, 45);
        //        button.frame = CGRectMake((Screen_Width-40),10+45*i, 25, 25);
        [button[i] addTarget:self action:@selector(buttonClik:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.buttonArray addObject:button[i]];
        [backView addSubview:button[i]];
    }
    
    
    
    radioImageView = [[UIImageView alloc] init];
    radioImageView.frame = CGRectMake((Screen_Width-40),10+45, 25, 25);
    radioImageView.image = [UIImage imageNamed:@"radio_box.png"];
    radioImageView.hidden = YES;
    [backView addSubview:radioImageView];
    
    
    
    contionTextView = [[UITextView alloc]init];
    contionTextView.frame = CGRectMake(0,185, self.view.frame.size.width, self.view.frame.size.height-100);
    contionTextView.hidden = YES;
    contionTextView.textAlignment = NSTextAlignmentLeft;
    contionTextView.font = [UIFont systemFontOfSize:15];
    contionTextView.text = @"请输入其它原因（选填）";
    contionTextView.delegate = self;
    contionTextView.backgroundColor = [UIColor whiteColor];
    contionTextView.textColor = [UIColor grayColor];
    [backView addSubview:contionTextView];
    
    UIButton *btnFirst = [self.buttonArray objectAtIndex:0];
    radioImageView.frame = CGRectMake((Screen_Width-40),10, 25, 25);
    radioImageView.hidden = NO;
    btnFirst.selected = YES;
    contionTextView.hidden = YES;
}
-(void)buttonClik:(UIButton *)sender
{
    for (int i = 0; i < [self.buttonArray count]; i++)
    {
        if (sender == [self.buttonArray objectAtIndex:i])
        {
            if (sender.selected == YES)
            {
                radioImageView.hidden = NO;
                radioImageView.frame = CGRectMake((Screen_Width-40),10+45*i, 25, 25);
                sender.selected = NO;
                if (sender.tag == 3)
                {
                    contionTextView.hidden = NO;
                    contionTextView.text = @"请输入其它原因（选填）";
                }
                else
                {
                    contionTextView.hidden = YES;
                    [contionTextView resignFirstResponder];
                }
                seletionButton = i;
            }else
            {
                radioImageView.hidden = YES;
                radioImageView.frame = CGRectMake((Screen_Width-40),10+45*i, 25, 25);
                sender.selected = YES;
                contionTextView.hidden = YES;
            }
        }
        else{
            button[i].selected = YES;
            DBG(@"%@",button[i]);
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    contionTextView.text = @"";
    if ((Screen_Height) < 700) {
        [UIView animateWithDuration:0.3 animations:^{
            backView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-navigationView.frame.size.height);
        }];
    }
}
-(void)LeftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)RigthClicked
{
    NSString * contione;
    if (![contionTextView.text isEqualToString:@"请输入其它原因（选填）"]) {
        contione = [NSString stringWithFormat:@"%@",contionTextView.text];
    }else{  
        if (seletionButton == 3) {
            [Common addAlertWithTitle:@"请填写原因"];
            return;
        }
        contione = [contionArray objectAtIndex:seletionButton];
    }
    DBG(@"===========contione====%@",[contione stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    NSString *postString = [contione stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@order/cancel?PHPSESSID=%@&orderId=%@&remark=%@",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID,[self.CancelOrderDic objectForKey:@"orderId"],postString];

    NSURL *url = [NSURL URLWithString:string];
    //
    //
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    //        NSString *url = [NSString stringWithFormat:@"%@order/cancel?PHPSESSID=%@&orderId=%@&remark=%@",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID,[self.CancelOrderDic objectForKey:@"orderId"],contione];
    //
    //    NSLog(@"两件：%@",url);
    //
    //    [[[CancellationLanding alloc]init] CancellationUrl:url requestSuccess:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    //        if (data) {
    //
    //            //NSLog(@"数据：%@", [response responseString]);
    //            NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //
    //            if ([[[jsonData objectForKey:@"datas"] objectForKey:@"ret"] integerValue] == 0) {
    //                NSString *msg = @"取消成功";
    //
    //                [Common addAlertWithTitle:msg];
    //                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    //
    //                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrder" object:nil];
    //            }else{
    //                NSString *msg = [jsonData objectForKey:@"msg"];
    //                [Common addAlertWithTitle:msg];
    //
    //            }
    //        }
    //    }];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError) {
        
        //    NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //    NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data) {
                
                if ([[[jsonData objectForKey:@"datas"] objectForKey:@"ret"] integerValue] == 0) {
                    NSString *msg = @"取消成功";
                    
                    [Common addAlertWithTitle:msg];
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrder" object:nil];
                }else{
                    NSString *msg = [jsonData objectForKey:@"msg"];
                    [Common addAlertWithTitle:msg];
                }
            }else{
                [Common addAlertWithTitle:@"网络错误"];
            }
            
        });
        
    }];
    
    /*
     ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@order/cancel",XLNETWORKREQUESTSURLDomain]]];
     [request setPostValue:IPHNOEPHPSESSID forKey:@"PHPSESSID"];
     [request setPostValue:[self.CancelOrderDic objectForKey:@"orderId"] forKey:@"orderId"];
     [request setPostValue:contione forKey:@"remark"];
     [request setDelegate:self];
     [request startAsynchronous];
     */
    
    //    NSLog(@"取消订单接口：%@",[NSString stringWithFormat:@"%@order/cancel",XLNETWORKREQUESTSURLDomain]);
    //    NSLog(@"参数：%@",IPHNOEPHPSESSID);
    //    NSLog(@"参数：%@",[self.CancelOrderDic objectForKey:@"orderId"]);
    //    NSLog(@"参数：%@",contione);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse{
    self.XLAllCoursesData =[[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.XLAllCoursesData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    [Common addAlertWithTitle:@"网络错误"];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *asyReturn = [[NSString alloc] initWithData:self.XLAllCoursesData encoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[asyReturn dataUsingEncoding:(NSUTF8StringEncoding)] options:kNilOptions error:nil];
    DBG(@"=======jsonDataschool=======%@",jsonDictionary);
    
    
    if ([[jsonDictionary objectForKey:@"ret"] integerValue] == 0)
    {
        NSLog(@"测试%@",jsonDictionary);
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *jsonDatas;
    jsonDatas = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    //    ONESREQUESTWORKINGPostNotificationName;
    DBG(@"==111=asdfsdjsonData===%@",jsonDatas);
    
    /*
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
     
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[jsonDatas objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
     
     
     [self presentViewController:alertController animated:YES completion:nil];
     */
    
    
    NSString *msg;
    if ([[jsonDatas objectForKey:@"ret"] integerValue] == 0) {
        
        msg = @"取消成功";
        
        [Common addAlertWithTitle:msg];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrder" object:nil];
    }else{
        msg = [jsonDatas objectForKey:@"msg"];
        [Common addAlertWithTitle:msg];
    }
    
    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"  温馨提示！" message: msg delegate:self cancelButtonTitle:@"确 认"  otherButtonTitles:nil, nil];
    //    alertView.tag = 23;
    //    [alertView show];
    
    /*
     if(([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)){
     
     NSString *title = @"温馨提示！";
     NSString *message = msg;
     NSString *okButtonTitle = @"确定";
     
     // 初始化
     UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     
     [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrder" object:nil];
     }];
     
     [alertDialog addAction:okAction];
     
     [self presentViewController:alertDialog animated:YES completion:nil];
     
     }else
     {
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"  温馨提示！" message: msg delegate:self cancelButtonTitle:@"确 认"  otherButtonTitles:nil, nil];
     alertView.tag = 23;
     [alertView show];
     }
     */
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 23)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshOrder" object:nil];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    DBG(@"==111=asdfsdjsonData===%@",[request error]);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [contionTextView resignFirstResponder];
    if ((Screen_Height) < 700) {
        [UIView animateWithDuration:0.3 animations:^{
            backView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    
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
