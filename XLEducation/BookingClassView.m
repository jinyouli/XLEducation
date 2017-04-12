//
//  BookingClassView.m
//  XLEducation
//
//  Created by kin on 15/2/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "BookingClassView.h"
#import "SeleButtonView.h"
@implementation BookingClassView

@synthesize buttonArray,seletionArray,unmberLabel,mLabel,pcImage,myscrollView,ButtonView,buttonIamge,moneyLabel,moneyDictionary,KeyButton;

//-(id)initWithFrame:(CGRect)frame userImage:(UIImage*)newUserImage money:(NSString *)newMoney;
-(id)initWithFrame:(CGRect)frame teachId:(NSString *)newTeachId
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        unmberPM = 0;
        UIButton *classButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        classButton.frame = CGRectMake(((Screen_Width)-35) , 5,30, 30);
        [classButton setTitle:classButton.titleLabel.text forState:(UIControlStateNormal)];
        [classButton setImage:[UIImage imageNamed:@"close_icon.png"] forState:(UIControlStateNormal)];
        [classButton addTarget:self action:@selector(backButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:classButton];
        
        
        KeyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        KeyButton.frame = CGRectMake(5 ,5,30, 30);
        [KeyButton setTitle:classButton.titleLabel.text forState:(UIControlStateNormal)];
        [KeyButton setImage:[UIImage imageNamed:@"Text@2x.png"] forState:(UIControlStateNormal)];
        KeyButton.hidden = YES;
        [KeyButton addTarget:self action:@selector(keyButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:KeyButton];

        

//        UIImageView *UserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 60, 60)];
//        UserImageView.layer.masksToBounds = YES;
//        UserImageView.layer.cornerRadius = 30;
//        UserImageView.layer.borderWidth = 1;
//        UserImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        UserImageView.image = newUserImage;
//        [self addSubview:UserImageView];
//        
//        UILabel *moneyLabel = [[UILabel alloc]init];
//        moneyLabel.textColor = [UIColor redColor];
//        moneyLabel.frame=CGRectMake(80,5,(Screen_Width)-90,20);
//        moneyLabel.text = @"￥1000.00";
//        moneyLabel.font = [UIFont systemFontOfSize:18];
//        [self addSubview:moneyLabel];
//        
        UILabel *classLabel = [[UILabel alloc]init];
        classLabel.textColor = [UIColor grayColor];
        classLabel.textAlignment = NSTextAlignmentCenter;
        classLabel.frame = CGRectMake(60,0,(Screen_Width)-120,35);
        classLabel.text = @"请老师上门上课";
        classLabel.font = Screen_FontName;
        [self addSubview:classLabel];
        
        UIImageView *lineImage = [[UIImageView alloc]init];
        lineImage.frame = CGRectMake(0,35,Screen_Width, 1);
        lineImage.image = [UIImage imageNamed:@"rule.png"];
        [self addSubview:lineImage];
        
        self.myscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,36,Screen_Width, self.frame.size.height)];
        self.myscrollView.backgroundColor = [UIColor whiteColor];
        [self.myscrollView setContentSize:CGSizeMake(Screen_Width, 315)];
        self.myscrollView.delegate=self;
        self.myscrollView.showsHorizontalScrollIndicator=NO;
        self.myscrollView.showsVerticalScrollIndicator=NO;
        [self addSubview:self.myscrollView];

//        
//        UILabel *xieKeLabel = [[UILabel alloc]init];
//        xieKeLabel.textColor = RGBACOLOR(100, 100, 100, 1);
//        xieKeLabel.frame = CGRectMake(10,0,(Screen_Width)-90,30);
//        xieKeLabel.text = [NSString stringWithFormat:@"教学科目(%@/小时起)",newMoney];
//        xieKeLabel.font = [UIFont systemFontOfSize:15];
//        [myscrollView addSubview:xieKeLabel];
//
//        NSArray *classgray = @[@"初中英语",@"高中英语",@"高考英语",@"中考英语",@"小学数学",@"初中数学",@"高中数学",@"显示更多"];
//        self.buttonArray = [[NSMutableArray alloc]init];
//        for (int i = 0; i < [classgray count]; i++) {
//            UIButton *classButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            classButton.tag = i;
//            if (i < 4) {
//                classButton.frame = CGRectMake(10 + (((Screen_Width)-50)/4+10)*i, 125-81,((Screen_Width)-50)/4, 35);
//            }
//            else{
//                classButton.frame = CGRectMake(10 + (((Screen_Width)-50)/4+10)*(i-4), 175-81,((Screen_Width)-50)/4, 35);
//            }
//            classButton.titleLabel.text = [classgray objectAtIndex:i];
//            classButton.titleLabel.font = [UIFont systemFontOfSize:13];
//            [classButton setTitle:classButton.titleLabel.text forState:(UIControlStateNormal)];
//            if (i  < 7) {
//                classButton.layer.masksToBounds = YES;
//                classButton.layer.borderWidth = 0.5;
//                classButton.layer.cornerRadius = 5;
//                classButton.backgroundColor = [UIColor whiteColor];
//                [classButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//                [self.buttonArray addObject:classButton];
//            }else{
//                [classButton setTitleColor:WORDLCOLOR forState:(UIControlStateNormal)];
//            }
//            [classButton addTarget:self action:@selector(classButton:) forControlEvents:(UIControlEventTouchUpInside)];
//            [myscrollView addSubview:classButton];
//        }
//
        
        UILabel *kmLabel = [[UILabel alloc]init];
        kmLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        kmLabel.frame = CGRectMake(10,5,(Screen_Width)-90,30);
        kmLabel.text = @"教学科目";
        kmLabel.font = Screen_Font;
        [self.myscrollView addSubview:kmLabel];


        UILabel *ksLabel = [[UILabel alloc]init];
        ksLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        ksLabel.frame = CGRectMake(10,80,(Screen_Width)-90,20);
        ksLabel.text = @"请选择教学时长";
        ksLabel.font = Screen_Font;
        [self.myscrollView addSubview:ksLabel];
        
        NSArray *seleArray = @[@"10个课时",@"20个课时",@"30个课时",@"自定义课时"];
        self.seletionArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < [seleArray count]; i++) {
            UIButton *classButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            classButton.tag = i;
            classButton.frame = CGRectMake(10 + (((Screen_Width)-50)/4+10)*i, 105,((Screen_Width)-50)/4, 35);
            classButton.layer.masksToBounds = YES;
            classButton.layer.borderWidth = 0.5;
            classButton.layer.cornerRadius = 5;
            classButton.titleLabel.text = [seleArray objectAtIndex:i];
            classButton.titleLabel.font = Screen_Font;
            classButton.backgroundColor = [UIColor whiteColor];
            [classButton setTitle:classButton.titleLabel.text forState:(UIControlStateNormal)];
            [classButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [classButton addTarget:self action:@selector(seletiButton:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.seletionArray addObject:classButton];
            [self.myscrollView addSubview:classButton];
        }
        
//        UIImageView *line1Image = [[UIImageView alloc]init];
//        line1Image.frame = CGRectMake(0,310-81,Screen_Width, 1);
//        line1Image.image = [UIImage imageNamed:@"rule.png"];
//        [myscrollView addSubview:line1Image];
        
        self.mLabel = [[UILabel alloc]init];
        self.mLabel.hidden = YES;
        self.mLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        self.mLabel.frame = CGRectMake((Screen_Width)-280,165,100,30);
        self.mLabel.textAlignment = NSTextAlignmentRight;
        self.mLabel.text = @"填写课时:";
        self.mLabel.font = Screen_Font;
        [self.myscrollView addSubview:self.mLabel];
        
        UIView *backVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 215, Screen_Width, 55)];
        backVeiw.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        [self.myscrollView addSubview:backVeiw];
        
        UILabel *mtLabel = [[UILabel alloc]init];
        mtLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        mtLabel.frame = CGRectMake(10 ,225,ControllerNumber(100,70), 30);
        mtLabel.text = @"订单总价:";
        mtLabel.font = Screen_Font;
        [self.myscrollView addSubview:mtLabel];
        
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.textColor = [UIColor redColor];
        self.moneyLabel.frame = CGRectMake(ControllerNumber(100,70),223,200, 35);
        self.moneyLabel.text = @"￥0.00";
        self.moneyLabel.font = Screen_FontNaviTitle;
        [self.myscrollView addSubview:self.moneyLabel];


        UIButton *suerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        suerButton.frame = CGRectMake((Screen_Width)-90 ,225,80, 35);
        suerButton.layer.masksToBounds = YES;
        suerButton.layer.cornerRadius = 5;
        suerButton.titleLabel.text = @"确 定";
        suerButton.titleLabel.font = Screen_FontName;
        [suerButton setTitle:suerButton.titleLabel.text forState:(UIControlStateNormal)];
        [suerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        suerButton.backgroundColor = WORDLCOLOR;
        [suerButton addTarget:self action:@selector(suerClikButton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.myscrollView addSubview:suerButton];
        
        
        self.pcImage = [[UIImageView alloc]init];
        self.pcImage.frame = CGRectMake((Screen_Width)-180,165,170, 30);
        self.pcImage.userInteractionEnabled = YES;
        self.pcImage.hidden = YES;
        self.pcImage.image = [UIImage imageNamed:@"plus_minus_control_bg.png"];
        [self.myscrollView addSubview:self.pcImage];
        
        for (int i = 0; i < 2; i++) {
            suButton[i] = [UIButton buttonWithType:(UIButtonTypeCustom)];
            suButton[i].backgroundColor = [UIColor clearColor];
            suButton[i].tag = i;
            suButton[i].hidden = YES;
            if (suButton[i].tag == 0) {
                suButton[i].frame = CGRectMake(0, 0,45, 30);
                [suButton[i] setImage:[UIImage imageNamed:@"minus_icon.png"] forState:(UIControlStateNormal)];
            }
            else{
                suButton[i].frame = CGRectMake(125,0,45, 30);
                [suButton[i] setImage:[UIImage imageNamed:@"plus_icon.png"] forState:(UIControlStateNormal)];
            }
            [suButton[i] addTarget:self action:@selector(pmClikButton:) forControlEvents:(UIControlEventTouchUpInside)];
            [pcImage addSubview:suButton[i]];
        }
        
        self.unmberLabel = [[UITextField alloc]init];
        self.unmberLabel.hidden = YES;
        self.unmberLabel.delegate = self;
        self.unmberLabel.keyboardType = UIKeyboardTypeNumberPad;
        self.unmberLabel.frame = CGRectMake(35,0,95,30);
        self.unmberLabel.text = [NSString stringWithFormat:@"%ld",(long)unmberPM];
        self.unmberLabel.font = Screen_FontName;
        self.unmberLabel.textAlignment = NSTextAlignmentCenter;
        [pcImage addSubview:self.unmberLabel];
        
//        self.ButtonView = [[SeleButtonView alloc]initWithFrame:CGRectMake(10, 70, (Screen_Width)-20, 135) teachingId:newTeachId];
//        self.ButtonView.delegate = self;
//        self.ButtonView.layer.masksToBounds = YES;
//        self.ButtonView.layer.cornerRadius = 3;
//        self.ButtonView.layer.borderWidth = 0.3;
//        self.ButtonView.layer.borderColor = WORDLCOLOR.CGColor;
//        self.ButtonView.hidden = YES;
//        [self.myscrollView addSubview:self.ButtonView];
        
        UIImageView *selecPricImage = [[UIImageView alloc]init];
        selecPricImage.frame = CGRectMake(10,35,(Screen_Width)-20, 40);
        selecPricImage.userInteractionEnabled = YES;
        selecPricImage.image = [UIImage imageNamed:@"drop_down_green@2x.png"];
        [self.myscrollView addSubview:selecPricImage];
        
        self.buttonIamge = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonIamge.frame = CGRectMake(0, 0,(Screen_Width)-20, 40);
        self.buttonIamge.selected = YES;
        [self.buttonIamge setTitle:@"请选择教学科目" forState:(UIControlStateNormal)];
        [self.buttonIamge setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.buttonIamge setTitleEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, (Screen_Width)-250))];
        [self.buttonIamge addTarget:self action:@selector(seleTableView:) forControlEvents:(UIControlEventTouchUpInside)];
        [selecPricImage addSubview:self.buttonIamge];
        
    }
    return self;
}

-(void)classButton:(UIButton *)sender
{
    for (int i = 0; i < [self.buttonArray count]; i++) {
        if (sender == [self.buttonArray objectAtIndex:i]) {
            [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            sender.backgroundColor = WORDLCOLOR;
        }else
        {
           UIButton *buttong = [self.buttonArray objectAtIndex:i];
            [buttong setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            buttong.backgroundColor = [UIColor whiteColor];
        }
    }
}
-(void)seletiButton:(UIButton *)sender
{
    if (sender.tag == 3) {
        self.mLabel.hidden = NO;
        self.pcImage.hidden = NO;
        self.unmberLabel.hidden = NO;
        suButton[0].hidden = NO;
        suButton[1].hidden = NO;
        buttonTag = 0;

    }
    else
    {
        self.mLabel.hidden = YES;
        self.pcImage.hidden = YES;
        self.unmberLabel.hidden = YES;
        suButton[0].hidden = YES;
        suButton[1].hidden = YES;
        
        if (sender.tag == 0) {
            buttonTag = 10;
             mtoal = moneyInteger*10;
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
        }
        else if (sender.tag == 1) {
            buttonTag = 20;
             mtoal = moneyInteger*20;
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
        }
        else if (sender.tag == 2) {
            buttonTag = 30;
             mtoal = moneyInteger*30;
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
        }
    }

    for (int i = 0; i < [self.seletionArray count]; i++) {
        if (sender == [self.seletionArray objectAtIndex:i]) {
            [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            sender.backgroundColor = WORDLCOLOR;
        }else
        {
            UIButton *buttong = [self.seletionArray objectAtIndex:i];
            [buttong setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            buttong.backgroundColor = [UIColor whiteColor];
        }
    }
}
-(void)suerClikButton
{
    if (mtoal > 0) {
        [self.delegate pushSuerMoney:moneyDictionary totelPrci:mtoal];
    }else
    {
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"温馨提示！" message:@"亲！请选择课程价钱！" delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
-(void)pmClikButton:(UIButton *)sender
{
    [self.unmberLabel resignFirstResponder];
    if (sender.tag == 0) {
        if (unmberPM > 0) {
            unmberPM--;
            self.unmberLabel.text = [NSString stringWithFormat:@"%ld",(long)unmberPM];
            NSString *nunmber =  self.unmberLabel.text;
            unmberPM = [nunmber integerValue];
             mtoal = moneyInteger*unmberPM;
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
        }
    }
    else if(sender.tag == 1){
        unmberPM++;
        self.unmberLabel.text = [NSString stringWithFormat:@"%ld",(long)unmberPM];
        NSString *nunmber =  self.unmberLabel.text;
        unmberPM = [nunmber integerValue];
         mtoal = moneyInteger*unmberPM;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.unmberLabel resignFirstResponder];
    [self.myscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.delegate scrollViewDragging];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.unmberLabel resignFirstResponder];
    [self.delegate scrollViewDragging];
}
-(void)backButton
{
    [self.unmberLabel resignFirstResponder];
    [self.delegate BookingClassHiedde];
    [self.myscrollView setContentOffset:CGPointMake(0, 0) animated:YES];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    KeyButton.hidden = NO;
    [self.delegate textFieldDiEditing];
    [self.myscrollView setContentOffset:CGPointMake(0, 160) animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *nunmber =  textField.text;
    unmberPM = [nunmber integerValue];
     mtoal = moneyInteger*unmberPM;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
}
-(void)seleTableView:(UIButton *)sender
{
    if (sender.selected == YES)
    {
        self.ButtonView.hidden = NO;
        sender.selected = NO;
    }else
    {
        self.ButtonView.hidden = YES;
        sender.selected = YES;
    }
}
-(void)SeleButtondCellInfo:(NSString *)cellInfo price:(NSDictionary *)newPrice
{
    moneyDictionary = newPrice;
    DBG(@"======moneyDictionary=====%@",moneyDictionary);
    moneyInteger = [[newPrice  objectForKey:@"price"] integerValue];
    NSString *mtext = self.unmberLabel.text;
    [self.buttonIamge setTitle:cellInfo forState:(UIControlStateNormal)];
    self.ButtonView.hidden = YES;
    self.buttonIamge.selected = YES;

    if (buttonTag == 0) {
         mtoal = moneyInteger*[mtext integerValue];
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
    }
    if (buttonTag == 10) {
         mtoal = moneyInteger*10;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
    }
    else if (buttonTag == 20) {
         mtoal = moneyInteger*20;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
    }
    else if (buttonTag == 30) {
         mtoal = moneyInteger*30;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%0.2lf",mtoal];
    }
}

-(void)keyButton
{
    [self.unmberLabel resignFirstResponder];
    [self.myscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    KeyButton.hidden = YES;
    [self.delegate scrollViewDragging];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
