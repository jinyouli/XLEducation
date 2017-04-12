//
//  ClassTimeView.m
//  XLEducation
//
//  Created by kin on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "ClassTimeView.h"

@implementation ClassTimeView


-(id)initWithFrame:(CGRect)frame teachTime:(NSString *)newTeachTime HTeachTime:(NSArray *)SeleTeachTime
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel*titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,10,100,20)];
        titleLabel.text = @" 授课时间";
        titleLabel.font = listFont;
        titleLabel.textColor= gredcolor;
        [self addSubview:titleLabel];
        

        UILabel*xltitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,40,Screen_Width,1)];
        xltitleLabel.backgroundColor = zshColor;
        [self addSubview:xltitleLabel];
        

        
        UIImageView *lineImage = [[UIImageView alloc]init];
        lineImage.frame = CGRectMake(10,55,(Screen_Width)-20, (Screen_Width)/2);
        lineImage.image = [UIImage imageNamed:@"teachtime_table"];
        [self addSubview:lineImage];
        
        NSArray *timeArray = [newTeachTime componentsSeparatedByString:@","];
        NSDictionary *teachTimeOne = @{@"0":@"A1",@"1":@"B1",@"2":@"C1",@"3":@"D1",@"4":@"E1",@"5":@"F1",@"6":@"G1"};
        NSDictionary *teachTimeTwo = @{@"7":@"A2",@"8":@"B2",@"9":@"C2",@"10":@"D2",@"11":@"E2",@"12":@"F2",@"13":@"G2"};
        NSDictionary *teachTimeTree = @{@"14":@"A3",@"15":@"B3",@"16":@"C3",@"17":@"D3",@"18":@"E3",@"19":@"F3",@"20":@"G3"};

        if ([timeArray count] > 0)
        {
            for (int i = 0; i < 21; i++)
            {
            UIImageView *DataImage = [[UIImageView alloc]init];
                DataImage.contentMode = UIViewContentModeScaleAspectFill;
            if (i < 7)
            {
                for (int j = 0; j < [timeArray count]; j++)
                {
                    if ([[timeArray objectAtIndex:j] isEqualToString:[teachTimeOne objectForKey:[NSString stringWithFormat:@"%d",i]]])
                    {
                        DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i+1)+((Screen_Width)-20)/32+8,58+((Screen_Width)-20)/8+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                        DataImage.image = [UIImage imageNamed:@"certificate_icon.png"];
                    }
                }
            }
            else if(i >= 7 && i < 14)
            {
                for (int j = 0; j < [timeArray count]; j++)
                {
                    if ([[timeArray objectAtIndex:j] isEqualToString:[teachTimeTwo objectForKey:[NSString stringWithFormat:@"%d",i]]])
                    {
                        DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i-6)+((Screen_Width)-20)/32+8,60+((Screen_Width)-20)/8*2+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                        DataImage.image = [UIImage imageNamed:@"certificate_icon.png"];

                    }
                }

            }
            else if(i >= 14 && i < 21)
            {
                for (int j = 0; j < [timeArray count]; j++) {
                    if ([[timeArray objectAtIndex:j] isEqualToString:[teachTimeTree objectForKey:[NSString stringWithFormat:@"%d",i]]]) {
                        DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i-13)+((Screen_Width)-20)/32+8,60+((Screen_Width)-20)/8*3+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                        DataImage.image = [UIImage imageNamed:@"certificate_icon.png"];

                    }
                }
            }
            [self addSubview:DataImage];
            }
        }
        
        if ([SeleTeachTime count] > 0)
        {
            for (int i = 0; i < 21; i++)
            {
                UIImageView *DataImage = [[UIImageView alloc]init];
                DataImage.contentMode = UIViewContentModeScaleAspectFill;
                if (i < 7)
                {
                    for (int j = 0; j < [SeleTeachTime count]; j++)
                    {
                        if ([[SeleTeachTime objectAtIndex:j] isEqualToString:[teachTimeOne objectForKey:[NSString stringWithFormat:@"%d",i]]])
                        {
                            DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i+1)+((Screen_Width)-20)/32+8,58+((Screen_Width)-20)/8+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                            DataImage.image = [UIImage imageNamed:@"certificate_red_icon"];
                        }
                    }
                }
                else if(i >= 7 && i < 14)
                {
                    for (int j = 0; j < [SeleTeachTime count]; j++)
                    {
                        if ([[SeleTeachTime objectAtIndex:j] isEqualToString:[teachTimeTwo objectForKey:[NSString stringWithFormat:@"%d",i]]])
                        {
                            DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i-6)+((Screen_Width)-20)/32+8,60+((Screen_Width)-20)/8*2+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                            DataImage.image = [UIImage imageNamed:@"certificate_red_icon"];
                            
                        }
                    }
                    
                }
                else if(i >= 14 && i < 21)
                {
                    for (int j = 0; j < [SeleTeachTime count]; j++) {
                        if ([[SeleTeachTime objectAtIndex:j] isEqualToString:[teachTimeTree objectForKey:[NSString stringWithFormat:@"%d",i]]]) {
                            DataImage.frame = CGRectMake(((Screen_Width)-20)/8*(i-13)+((Screen_Width)-20)/32+8,60+((Screen_Width)-20)/8*3+((Screen_Width)-20)/32,(Screen_Width)/16, (Screen_Width)/16);
                            DataImage.image = [UIImage imageNamed:@"certificate_red_icon"];
                            
                        }
                    }
                }
                [self addSubview:DataImage];
            }
        }

        
        UIImageView *chooseImage = [[UIImageView alloc]init];
        chooseImage.frame = CGRectMake(((Screen_Width)-260)/2,(Screen_Width)/2+65,260*(UIDeviceWidth), 15*(UIDeviceWidth));
        chooseImage.image = [UIImage imageNamed:@"tag_annotation"];
        [self addSubview:chooseImage];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
