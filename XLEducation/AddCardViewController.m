//
//  AddCardViewController.m
//  XLEducation
//
//  Created by kin on 15/3/13.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AddCardViewController.h"
#import "BankViewController.h"
#import "ASIFormDataRequest.h"
#import "XLQuestWork.h"
@interface AddCardViewController ()<BankViewdelegate,ASIHTTPRequestDelegate>
{
    UITextField *tishiField;
    UITextField *cardField;
    UIButton *Bankcard;
    UITextField *bankcardField;
    UIButton *addBankcard;
}

@end

@implementation AddCardViewController

@synthesize cardNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    
    [self NavigationSetting];
    [self ControlsGenerate];
}
-(void)NavigationSetting
{
    self.title = @"添加银行卡";
    NSDictionary *titleDictionary = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:LoinFont};
    [self.navigationController.navigationBar setTitleTextAttributes:titleDictionary];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"right_return"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftClicked)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
}
-(void)ControlsGenerate
{
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:(CGRectMake(15, (IOSNAVIGATIONSIZE), (Screen_Width)-15, 44))];
    tishiLabel.text = @"绑定银行卡后才能提现哦！";
    tishiLabel.font = cellFont;
    tishiLabel.textColor = treeColor;
    [self.view addSubview:tishiLabel];
    
    NSArray *titleArray = @[@"户 主",@"卡 号",@"银 行"];
    for (int i =0; i < 3; i++) {
        UILabel *backLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, (IOSNAVIGATIONSIZE)+44+51*i, (Screen_Width), 50))];
        backLabel.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backLabel];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:(CGRectMake(15, (IOSNAVIGATIONSIZE)+44+51*i, 80, 50))];
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.textColor = oneColor;
        [self.view addSubview:titleLabel];

    }
    
    tishiField = [[UITextField alloc] initWithFrame:CGRectMake(80,(IOSNAVIGATIONSIZE)+44,(Screen_Width)-90,50)];
    tishiField.placeholder= @"请输入银行卡户名";
    tishiField.tag = 9;
    tishiField.delegate = self;
    tishiField.font = NAMEFont;
    [self.view addSubview:tishiField];
    
    cardField = [[UITextField alloc] initWithFrame:CGRectMake(80,(IOSNAVIGATIONSIZE)+95,(Screen_Width)-90, 50)];
    cardField.tag = 10;
    cardField.delegate = self;
    cardField.placeholder= @"请输入银行卡号";
    cardField.keyboardType = UIKeyboardTypeNumberPad;
    cardField.font = NAMEFont;
    [self.view addSubview:cardField];
    
    bankcardField = [[UITextField alloc] initWithFrame:CGRectMake(80,(IOSNAVIGATIONSIZE)+149,(Screen_Width)-90, 50)];
    bankcardField.placeholder= @"请选择银行";
    bankcardField.enabled = YES;
    bankcardField.font = NAMEFont;
    [self.view addSubview:bankcardField];
    
    
    Bankcard = [UIButton buttonWithType:(UIButtonTypeCustom)];
    Bankcard.frame = CGRectMake(0,(IOSNAVIGATIONSIZE)+149,(Screen_Width), 50);
    [Bankcard addTarget:self action:@selector(addBankCardClike) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:Bankcard];
    
    
    UIImageView *backImage = [[UIImageView alloc]init];
    backImage.frame = CGRectMake((Screen_Width)-35,(IOSNAVIGATIONSIZE)+149+17.5,10, 15);
    backImage.image = [UIImage imageNamed:@"more"];
    [self.view addSubview:backImage];

    
    addBankcard = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addBankcard.frame = CGRectMake(10, 280, (Screen_Width)-20, 45);
    addBankcard.titleLabel.font = titleFont;
    [addBankcard setTitle:@"绑定银行卡" forState:(UIControlStateNormal)];
    addBankcard.layer.masksToBounds = YES;
    addBankcard.layer.backgroundColor = zshColor.CGColor;
    addBankcard.layer.cornerRadius = 3;
    addBankcard.enabled = NO;
    [addBankcard addTarget:self action:@selector(addCard) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addBankcard];
}

-(void)bankCellInfo:(NSDictionary *)newCellInfo bankName:(NSString *)newBankName
{
    self.cardNumber = newBankName;
    bankcardField.text = [newCellInfo objectForKey:newBankName];
    if ([tishiField.text length] > 0 && [cardField.text length] > 0 && [bankcardField.text length] > 0   ) {
        addBankcard.layer.backgroundColor = editioncolor.CGColor;
        addBankcard.enabled = YES;
    }else{
        addBankcard.layer.backgroundColor = titlecolor.CGColor;
        addBankcard.enabled = NO;
    }

}
-(void)addCard
{
    NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:@"seleCity"];
    DBG(@"====city===%@",city);
    if ([tishiField.text length] > 0 && [bankcardField.text length] > 0 && [cardField.text length] > 8) {
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@money/bindbankcard?PHPSESSID=%@&cp=2",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID]]];
        [request setRequestMethod:@"POST"];
        [request setPostValue:tishiField.text forKey:@"accountName"];
        [request setPostValue:cardField.text forKey:@"account"];
        [request setPostValue:self.cardNumber forKey:@"bankCode"];
        [request setPostValue:IPHNOEPHPSESSID forKey:@"PHPSESSID"];
        [request setPostValue:city forKey:@"region"];
        [request setDelegate:self];
        [request startSynchronous];
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示!" message:@"请输入户名及大于8位帐号、银行名" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    DBG(@"========jsonData1111====%@",jsonData);
    if ([[jsonData objectForKey:@"ret"] integerValue] == 0) {
        NSDictionary *cardDictionary = @{@"userCard":bankcardField.text,@"bankCard":cardField.text,@"carNumber":self.cardNumber};
        [[NSUserDefaults standardUserDefaults]setObject:cardDictionary forKey:@"userBankCard"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.delegate AddCardHidde];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        NSString *allmsg = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"msg"]];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示！" message:allmsg delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([tishiField.text length] > 0 && [cardField.text length] > 0 && [bankcardField.text length] > 0   ) {
        addBankcard.layer.backgroundColor = editioncolor.CGColor;
        addBankcard.enabled = YES;
    }else{
        addBankcard.layer.backgroundColor = zshColor.CGColor;
        addBankcard.enabled = NO;

    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([tishiField.text length] > 0 && [cardField.text length] > 0 && [bankcardField.text length] > 0   ) {
        addBankcard.layer.backgroundColor = editioncolor.CGColor;
        addBankcard.enabled = YES;

    }else{
        addBankcard.layer.backgroundColor = zshColor.CGColor;
        addBankcard.enabled = NO;

    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([tishiField.text length] > 0 && [cardField.text length] > 0 && [bankcardField.text length] > 0   ) {
        addBankcard.layer.backgroundColor = editioncolor.CGColor;
        addBankcard.enabled = YES;
    }else{
        addBankcard.layer.backgroundColor = zshColor.CGColor;
        addBankcard.enabled = NO;
    }
    return YES;

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([tishiField.text length] > 0 && [cardField.text length] > 0 && [bankcardField.text length] > 0   ) {
        addBankcard.layer.backgroundColor = editioncolor.CGColor;
        addBankcard.enabled = YES;

    }else{
        addBankcard.layer.backgroundColor = zshColor.CGColor;
        addBankcard.enabled = NO;

    }
    
    if (textField.tag == 10) {
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
        {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4)
            {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        if (newString.length >= 24)
        {
            return NO;
        }
        [textField setText:newString];
        return NO;
    }
    else
    {
        return YES;
    }
}
-(void)LeftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)RigthClicked
{
    return;
}
-(void)addBankCardClike
{
    [tishiField resignFirstResponder];
    [cardField resignFirstResponder];
    BankViewController *bankView = [[BankViewController alloc]init];
    bankView.delegate = self;
    [self.navigationController pushViewController:bankView animated:YES];
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
