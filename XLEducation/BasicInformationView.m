//
//  BasicInformationView.m
//  XLEducation
//
//  Created by kin on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "BasicInformationView.h"
#import "CityRegion.h"

@implementation BasicInformationView

@synthesize heigth;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)BasicInforidentify:(NSDictionary *)newidentify  teachAchNum:(NSDictionary*)newteachAchNum cityId:(NSArray *)subArray;
{
    DBG(@"====newteachAchNum====%@======newidentify===%@==",newteachAchNum,newidentify);
    
    UILabel *sjLabel = [[UILabel alloc]init];
    sjLabel.frame=CGRectMake(10*(UIDeviceWidth),0,85*(UIDeviceWidth),45*(UIDeviceWidth));
    sjLabel.textColor =  RGBACOLOR(150, 150, 150, 1);
    sjLabel.text = @"教    龄:";
    sjLabel.font = listFont;
    [self addSubview:sjLabel];
    
    UILabel *yearLabel = [[UILabel alloc]init];
    yearLabel.frame = CGRectMake(95*(UIDeviceWidth),0,100,45*(UIDeviceWidth));
    int type = [[newidentify objectForKey:@"type"] intValue];
    if (type == 2) {
        yearLabel.text = [NSString stringWithFormat:@"%@年",[newidentify objectForKey:@"teachAge"]];
    }else
    {
        yearLabel.text = @"在校大学生";
    }
    yearLabel.font = listFont;
    [self addSubview:yearLabel];
    
    UIImageView *lineImage1 = [[UIImageView alloc]init];
    lineImage1.frame = CGRectMake(0,45, Screen_Width, 0.5);
    lineImage1.image = [UIImage imageNamed:@"rule.png"];
    [self addSubview:lineImage1];
    
    
    UILabel *schoolLabel = [[UILabel alloc]init];
    schoolLabel.frame=CGRectMake(10*(UIDeviceWidth),46,Screen_Width,45*(UIDeviceWidth));
    schoolLabel.textColor =  RGBACOLOR(150, 150, 150, 1);
    schoolLabel.text = @"院    校:";
    schoolLabel.font = listFont;
    [self addSubview:schoolLabel];
    
    UILabel *lblSchool = [[UILabel alloc]init];
    lblSchool.frame=CGRectMake(95*(UIDeviceWidth), 46,Screen_Width-50,45*(UIDeviceWidth));
    lblSchool.textColor = [UIColor blackColor];
    lblSchool.text = [newidentify objectForKey:@"eduSchool"];
    lblSchool.font = listFont;
    [self addSubview:lblSchool];
    
    
    
    //    CityRegion *CityRe = [[CityRegion alloc]init];
    //    NSArray *subArray = [CityRe cityPathId:SeleCityId];
    
    
    
    //    NSArray *areArray = [[newidentify objectForKey:@"teach_area"] componentsSeparatedByString:@","];
    //    DBG(@"=======areArray======%@",areArray);
    //    NSMutableArray *areAdd = [[NSMutableArray alloc]init];
    //
    //    for (int i = 0; i < [areArray count]; i++) {
    //        for (int j = 0 ; j < [subArray count]; j++) {
    //            if ([[areArray objectAtIndex:i] isEqualToString:[[subArray objectAtIndex:j] objectForKey:@"id"]])
    //            {
    //                [areAdd addObject:[[subArray objectAtIndex:j] objectForKey:@"name"]];
    //                DBG(@"======areAdd=========%@",areAdd);
    //            }
    //        }
    //    }
    
    UIImageView *lineImage2 = [[UIImageView alloc]init];
    lineImage2.frame = CGRectMake(0,schoolLabel.frame.origin.y+schoolLabel.frame.size.height, Screen_Width, 0.5);
    lineImage2.image = [UIImage imageNamed:@"rule.png"];
    [self addSubview:lineImage2];
    
    
    self.heigth = lineImage2.frame.origin.y+lineImage2.frame.size.height;
    
    if ([[newidentify objectForKey:@"eduMajor"] length] > 0) {
        UILabel *majorLabel = [[UILabel alloc]init];
        majorLabel.frame=CGRectMake(10*(UIDeviceWidth), lineImage2.frame.origin.y+lineImage2.frame.size.height,Screen_Width,45*(UIDeviceWidth));
        majorLabel.textColor =  RGBACOLOR(150, 150, 150, 1);
        majorLabel.text = @"专    业:";
        majorLabel.font = listFont;
        [self addSubview:majorLabel];
        
        UILabel *lblMajor = [[UILabel alloc]init];
        lblMajor.frame=CGRectMake(95*(UIDeviceWidth), lineImage2.frame.origin.y+lineImage2.frame.size.height,Screen_Width-50,45*(UIDeviceWidth));
        lblMajor.textColor = [UIColor blackColor];
        lblMajor.text = [newidentify objectForKey:@"eduMajor"];
        lblMajor.font = listFont;
        [self addSubview:lblMajor];
        
        self.heigth = lblMajor.frame.origin.y+lblMajor.frame.size.height;
    }
    
    UIImageView *lineImage3 = [[UIImageView alloc]init];
    lineImage3.frame = CGRectMake(0,self.heigth, Screen_Width, 0.5);
    lineImage3.image = [UIImage imageNamed:@"rule.png"];
    [self addSubview:lineImage3];
    
    UILabel *skLabel = [[UILabel alloc]init];
    skLabel.textColor = RGBACOLOR(150, 150, 150, 1);
    skLabel.frame = CGRectMake(10*(UIDeviceWidth),self.heigth,220*(UIDeviceWidth),45*(UIDeviceWidth));
    skLabel.text = @"授课范围:";
    skLabel.font = listFont;
    [self addSubview:skLabel];
    
    
    NSString *add = [newidentify objectForKey:@"teachAreaName"];
    UILabel *dqLabel = [[UILabel alloc]init];
    dqLabel.numberOfLines = 0;
    dqLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSString *dqString = add;
    dqLabel.font = listFont;
    NSDictionary *dqdic=@{NSFontAttributeName:dqLabel.font};
    CGSize dqsized=[dqString boundingRectWithSize:CGSizeMake((Screen_Width)-((Screen_Height) > 700 ?115:100), 300) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dqdic
                                          context:nil].size;
    dqLabel.frame=CGRectMake(95*(UIDeviceWidth),self.heigth+14,dqsized.width, dqsized.height);
    dqLabel.text = dqString;
    [self addSubview:dqLabel];
    
    self.heigth = dqLabel.frame.origin.y+dqLabel.frame.size.height+10;
    
    self.frame = CGRectMake(0, self.frame.origin.y, Screen_Width, self.heigth);
    
    //
    //
    //    UILabel *rzLabel = [[UILabel alloc]init];
    //    rzLabel.textColor = RGBACOLOR(0, 0, 0, 1);
    //    rzLabel.frame=CGRectMake(10*(UIDeviceWidth),lineImage2.frame.origin.y+lineImage2.frame.size.height,100,45);
    //    rzLabel.text = @"认证信息:";
    //    rzLabel.font = titleFont;
    //    [self addSubview:rzLabel];
    //
    //    NSArray *rzArray = [[newidentify objectForKey:@"identify"] componentsSeparatedByString:@","];
    //    NSMutableArray *timeArray = [[NSMutableArray alloc]init];
    //
    //    for (int i = 0 ; i < [rzArray count]; i++)
    //    {
    //        if (![[rzArray objectAtIndex:i] isEqualToString:@"teacher_info"])
    //        {
    //            [timeArray addObject:[rzArray objectAtIndex:i]];
    //        }
    //    }
    //    for (int i = 0; i < [timeArray count]; i++)
    //    {
    //        UIImageView *imagepannar =[[UIImageView alloc]initWithFrame:CGRectMake(100*(UIDeviceWidth)+35*i, lineImage2.frame.origin.y+lineImage2.frame.size.height+10, 25, 25)];
    //        imagepannar.image = [UIImage imageNamed:[timeArray objectAtIndex:i]];
    //        imagepannar.contentMode = UIViewContentModeScaleAspectFit;
    //        [self addSubview:imagepannar];
    //    }
    //
    //    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowsright_teachhome@2x.png"]];
    //    imageView.frame = CGRectMake((Screen_Width)-25,lineImage2.frame.origin.y+lineImage2.frame.size.height+40/2, 8, 12);
    //    [self addSubview:imageView];
    //
    //    UIButton *rzButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    rzButton.frame=CGRectMake(0,lineImage2.frame.origin.y+lineImage2.frame.size.height,(Screen_Width),45);
    //    [rzButton addTarget:self action:@selector(rzButtonClike) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self addSubview:rzButton];
    //
    //    UIImageView *lineImage3 = [[UIImageView alloc]init];
    //    lineImage3.frame = CGRectMake(0,rzButton.frame.origin.y+rzButton.frame.size.height, Screen_Width, 0.5);
    //    lineImage3.image = [UIImage imageNamed:@"rule.png"];
    //    [self addSubview:lineImage3];
    //    self.heigth = lineImage3.frame.origin.y+lineImage3.frame.size.height;
    //
    //
    //    if ([[newteachAchNum objectForKey:@"commentNum"] intValue] > 0) {
    //        UILabel *pjLabel = [[UILabel alloc]init];
    //        pjLabel.textColor = RGBACOLOR(0, 0, 0, 1);
    //        pjLabel.frame=CGRectMake(10*(UIDeviceWidth),lineImage3.frame.origin.y+lineImage3.frame.size.height,100*(UIDeviceWidth),45);
    //        pjLabel.text = @"评价信息:";
    //        pjLabel.font = titleFont;
    //        [self addSubview:pjLabel];
    //
    //        UILabel *xLabel = [[UILabel alloc]init];
    //        xLabel.frame=CGRectMake(100*(UIDeviceWidth),lineImage3.frame.origin.y+lineImage3.frame.size.height,100*(UIDeviceWidth),45);
    //        xLabel.textColor =   [UIColor blackColor];
    //        xLabel.font = titleFont;
    //        xLabel.text = [NSString stringWithFormat:@"%@条评价",[newteachAchNum objectForKey:@"commentNum"]];
    //        [self addSubview:xLabel];
    //
    //
    //        UIImageView *pjimageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowsright_teachhome@2x.png"]];
    //        pjimageView.frame = CGRectMake((Screen_Width)-25,lineImage3.frame.origin.y+lineImage3.frame.size.height+40/2, 8, 12);
    //        [self addSubview:pjimageView];
    //
    //        UIButton *pjButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //        pjButton.frame=CGRectMake(0,lineImage3.frame.origin.y+lineImage3.frame.size.height,(Screen_Width),45);
    //        [pjButton addTarget:self action:@selector(pjButtonClike) forControlEvents:(UIControlEventTouchUpInside)];
    //        [self addSubview:pjButton];
    //
    //        UIImageView *lineImage4 = [[UIImageView alloc]init];
    //        lineImage4.frame = CGRectMake(0,xLabel.frame.origin.y+xLabel.frame.size.height, Screen_Width, 0.5);
    //        lineImage4.image = [UIImage imageNamed:@"rule.png"];
    //        [self addSubview:lineImage4];
    //
    //        self.heigth = lineImage4.frame.origin.y+lineImage4.frame.size.height;
    //
    //    }
    //
    //
    //    float LabelHeith;
    //    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    //    if ([[newteachAchNum objectForKey:@"teacherAchv"] count] > 0)
    //    {
    //        UILabel *bqLabel = [[UILabel alloc]init];
    //        bqLabel.textColor =  RGBACOLOR(0, 0, 0, 1);
    //        bqLabel.frame=CGRectMake(10*(UIDeviceWidth),self.heigth,100*(UIDeviceWidth),45);
    //        bqLabel.text = @"个人标签:";
    //        bqLabel.font = titleFont;
    //        [self addSubview:bqLabel];
    //
    //        for (int i = 0 ; i < [[newteachAchNum objectForKey:@"teacherAchv"] count]; i++)
    //        {
    //            [titleArray addObject:[[[newteachAchNum objectForKey:@"teacherAchv"] objectAtIndex:i] objectForKey:@"title"]];
    //        }
    //        NSString *sizeLenth[[titleArray count]];
    //        UILabel *perLabel[[titleArray count]];
    //        a = 0;
    //        b = -1;
    //
    //        float worldLength;
    //        for (int i  = 0; i < [titleArray count]; i++)
    //        {
    //            CGSize size = [self XSLabelFont:[UIFont systemFontOfSize:17] LabelText:[titleArray objectAtIndex:i] LabelWitd: ((Screen_Width)-100*(UIDeviceWidth)) LabelHieth:21];
    //            sizeLenth[i] = [[NSString alloc]initWithFormat:@"%f",size.width+10];
    //
    //             worldLength =  [self worldLength:[sizeLenth[i] floatValue] DiveWith:[sizeLenth[i] floatValue]];
    //
    //            perLabel[i] = [[UILabel alloc]init];
    //            perLabel[i].frame = CGRectMake(100*(UIDeviceWidth)+worldLength-[sizeLenth[i] floatValue]+5*b,  (self.heigth+10+25*a), (size.width+10), 21);
    //            perLabel[i].textAlignment = NSTextAlignmentCenter;
    //            perLabel[i].layer.masksToBounds = YES;
    //            perLabel[i].layer.cornerRadius = 2;
    //            perLabel[i].layer.borderWidth = 0.3;
    //            perLabel[i].layer.borderColor =  [UIColor blackColor].CGColor;
    //            perLabel[i].textColor=  [UIColor blackColor];
    //            perLabel[i].text = [titleArray objectAtIndex:i];
    //            [self addSubview:perLabel[i]];
    //        }
    //
    //        LabelHeith = self.heigth+40+25*a;
    //
    //        UIImageView *lineImage5 = [[UIImageView alloc]init];
    //        lineImage5.frame = CGRectMake(0,LabelHeith, Screen_Width, 0.5);
    //        lineImage5.image = [UIImage imageNamed:@"rule.png"];
    //        [self addSubview:lineImage5];
    //
    //
    //        self.heigth = lineImage5.frame.origin.y+lineImage5.frame.size.height;
    //
    //    }
    //
    //
    //    int consult = 0,student = 0,teacher = 0;
    //    NSArray *teacherCourseArray = [newteachAchNum objectForKey:@"teacherCourse"];
    //    for (int i = 0; i< [teacherCourseArray count]; i++) {
    //        NSString *price_consult = [[teacherCourseArray objectAtIndex:i] objectForKey:@"price_consult"];
    //        NSString *price_student = [[teacherCourseArray objectAtIndex:i] objectForKey:@"price_student_visit"];
    //        NSString *price_teacher =[[teacherCourseArray objectAtIndex:i] objectForKey:@"price_teacher_visit"];
    //        if ([price_consult isEqualToString:@"1"])
    //        {
    //            consult++;
    //        }
    //        if ([price_student isEqualToString:@"1"])
    //        {
    //            student++;
    //        }
    //        if ([price_teacher isEqualToString:@"1"])
    //        {
    //            teacher++;
    //        }
    //        if (consult > 0 && student > 0 && teacher > 0) {
    //            break;
    //        }
    //    }
    //
    //    NSMutableArray *classType = [[NSMutableArray alloc]init];
    //    if (consult > 0) {
    //        [classType addObject:@"协商地点"];
    //    }
    //    if (student) {
    //        [classType addObject:@"学生上门"];
    //    }
    //    if (teacher > 0) {
    //        [classType addObject:@"老师上门"];
    //    }
    //    DBG(@"===classType=====%@",classType);
    //    UILabel *studtyLabel;
    //    if ([classType count] > 0) {
    //        studtyLabel = [[UILabel alloc]init];
    //        studtyLabel.textColor = RGBACOLOR(0, 0, 0, 1);
    //        studtyLabel.frame=CGRectMake(10*(UIDeviceWidth),self.heigth,100*(UIDeviceWidth),45);
    //        studtyLabel.text = @"上课方式:";
    //        studtyLabel.font = titleFont;
    //        [self addSubview:studtyLabel];
    //
    //        for (int i = 0 ; i < [classType count]; i++)
    //        {
    //            UILabel *stpyLabel = [[UILabel alloc]init];
    //            stpyLabel.frame=CGRectMake(100*(UIDeviceWidth)+90*i*(UIDeviceWidth),self.heigth+10,80*(UIDeviceWidth),25);
    //            stpyLabel.textAlignment = NSTextAlignmentCenter;
    //            stpyLabel.layer.masksToBounds = YES;
    //            stpyLabel.layer.cornerRadius = 3;
    //            stpyLabel.layer.borderWidth = 0.3;
    //            stpyLabel.layer.borderColor = [UIColor blackColor].CGColor;
    //            stpyLabel.text = [classType objectAtIndex:i];
    //            stpyLabel.textColor =  [UIColor blackColor];
    //            stpyLabel.font = listFont;
    //            [self addSubview:stpyLabel];
    //        }
    //        self.heigth = studtyLabel.frame.origin.y+studtyLabel.frame.size.height;
    //    }
    //    self.frame = CGRectMake(0, self.frame.origin.y, Screen_Width, self.heigth);
    
}
//-(void)rzButtonClike
//{
//    [self.delegate rzPushcontrollerPush:0];
//}
//-(void)pjButtonClike
//{
//    [self.delegate rzPushcontrollerPush:1];
//
//}
//-(CGSize)XSLabelFont:(UIFont*)FontSize LabelText:(NSString *)textString LabelWitd:(float)witd LabelHieth:(float)Hieth
//{
//    
//    NSDictionary *dicFont =@{NSFontAttributeName:FontSize};
//    CGSize LabelSize=[textString boundingRectWithSize:CGSizeMake(witd, Hieth) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dicFont
//                                              context:nil].size;
//    return LabelSize;
//}
//-(float)worldLength:(int)newLength DiveWith:(float)newDiveWith
//{
//    worldSize += newDiveWith;
//    float Lenthg= ((Screen_Width)-100*(UIDeviceWidth)-5*b) - worldSize;
//    if (Lenthg < 0) {
//        worldSize = newDiveWith;
//        a++;
//        b=0;
//    }
//    else{
//        b++;
//    }
//    return worldSize;
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
