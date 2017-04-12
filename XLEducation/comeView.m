////
////  comeView.m
////  XLEducation
////
////  Created by kin on 15/2/3.
////  Copyright (c) 2015年 kin. All rights reserved.
////
//
//#import "comeView.h"
//#import "UIImageView+WebCache.h"
//
//@implementation comeView
//
//-(id)initWithFrame:(CGRect)frame teachDic:(NSDictionary*)newTeachDic;
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        UIImageView *UserImage=[[UIImageView alloc] init];
//        UserImage.frame = CGRectMake(10, 25/2, 80, 80);
//        UserImage.layer.masksToBounds = YES;
//        UserImage.layer.cornerRadius = 5;
//        UserImage.contentMode = UIViewContentModeScaleToFill;
//        if (![[newTeachDic objectForKey:@"face"] isEqualToString:@""]) {
//            [UserImage sd_setImageWithURL:[NSURL URLWithString:[newTeachDic objectForKey:@"face"]] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            //            self.LogoImageView.urlString = [newTeachDic objectForKey:@"face"];
//        }
//        else
//        {
//            if ([[newTeachDic objectForKey:@"sex"] intValue] == 1)
//            {
//                [UserImage sd_setImageWithURL:[NSURL URLWithString:@"http://oss.new.968666.net/face/default/face_male.jpg"] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            }
//            else
//            {
//                [UserImage sd_setImageWithURL:[NSURL URLWithString:@"http://oss.new.968666.net/face/default/face_female.jpg"] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            }
//        }
//        [self addSubview:UserImage];        
//
//        
//        UILabel *nameLabel = [[UILabel alloc]init];
//        NSString *textString = [newTeachDic objectForKey:@"realname"];
//        nameLabel.font = Screen_Person;
//        NSDictionary *dic=@{NSFontAttributeName:nameLabel.font};
//        CGSize sized=[textString boundingRectWithSize:CGSizeMake(320, 40) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic
//                                              context:nil].size;
//        nameLabel.frame=CGRectMake(100, 8, sized.width, sized.height);
//        nameLabel.text = textString;
//        nameLabel.textColor = RGBACOLOR(30, 30, 30, 1);
//        [self addSubview:nameLabel];
//        
//        
//        UILabel *classLabel = [[UILabel alloc]init];
//        classLabel.font = Screen_FontNaviTitle;
//        NSString *TeachDic = [NSString stringWithFormat:@"￥%@",[newTeachDic objectForKey:@"price_lowest"]];
//        //        NSDictionary *dicon1 =@{NSFontAttributeName:classLabel.font};
//        //        CGSize sizedcon =[TeachDic boundingRectWithSize:CGSizeMake((Screen_Width)-70, 25) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dicon1
//        //                                                context:nil].size;
//        classLabel.frame = CGRectMake((Screen_Width)-180,3,150,25);
//        classLabel.textAlignment = NSTextAlignmentRight;
//        classLabel.textColor = [UIColor redColor];
//        classLabel.text = TeachDic;
//        [self addSubview:classLabel];
//
//        
//        UILabel *qiLabel = [[UILabel alloc]init];
//        qiLabel.font = Screen_Money;
//        qiLabel.textColor = RGBACOLOR(100, 100, 100, 1);
//        qiLabel.frame=CGRectMake((Screen_Width)-30, 5,25,25);
//        qiLabel.text = @"起";
//        [self addSubview:qiLabel];
//        
//        
//        UILabel *StudtyLabel = [[UILabel alloc]init];
//        StudtyLabel.font = Screen_WORLD;
//        StudtyLabel.textColor = RGBACOLOR(30, 30, 30, 1);
//        StudtyLabel.frame=CGRectMake(100, sized.height+8, (Screen_Width)-108,30);
//        StudtyLabel.text = [newTeachDic objectForKey:@"teach_grade_course"];
//        [self addSubview:StudtyLabel];
//        
//        UILabel *contionLabel = [[UILabel alloc]init];
//        contionLabel.font = Screen_MOrder;
//        contionLabel.frame=CGRectMake(100, 34+sized.height, (Screen_Width)-108,20);
//        contionLabel.text = [newTeachDic objectForKey:@"intro_short"];
//        contionLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        [self addSubview:contionLabel];
//        
//        UILabel *AddLabel = [[UILabel alloc]init];
//        AddLabel.font = Screen_MOrder;
//        AddLabel.frame=CGRectMake(100, 53+sized.height, (Screen_Width)-108,20);
//        AddLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        AddLabel.text =[NSString stringWithFormat:@"现住：%@-%@",[newTeachDic objectForKey:@"addr_area"],[newTeachDic objectForKey:@"addr_detail"]];
//        [self addSubview:AddLabel];
//        
////        UILabel *StudtyLabel = [[UILabel alloc]init];
////        StudtyLabel.textAlignment = NSTextAlignmentCenter;
////        StudtyLabel.layer.masksToBounds = YES;
////        StudtyLabel.layer.cornerRadius =2;
////        StudtyLabel.layer.backgroundColor = WORDLCOLOR.CGColor;
////        StudtyLabel.textColor = [UIColor whiteColor];
////        NSString *StudtyString = [NSString stringWithFormat:@"%@年教龄",newClassAge];
////        StudtyLabel.font = Screen_MoneyName;
////        NSDictionary *studtydicon=@{NSFontAttributeName:contionLabel.font};
////        CGSize sizedStudty =[StudtyString boundingRectWithSize:CGSizeMake((Screen_Width)-95, 40) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:studtydicon
////                                                 context:nil].size;
////        StudtyLabel.frame=CGRectMake(90, contionLabel.frame.origin.y+contionLabel.frame.size.height+5, sizedStudty.width+20, 25);
////        StudtyLabel.text = StudtyString;
////        [self addSubview:StudtyLabel];
//        
////        for (int i = 0;i < newImageUnmber; i++) {
////            UIImageView *imageView = [[UIImageView alloc] init];
////            imageView.tag = i;
////            imageView.frame = CGRectMake(8+i*12, 68, 9, 9);
////            if (imageView.tag < 4) {
////                imageView.image = [UIImage imageNamed:@"smallstar_green.png"];
////            }else{
////                imageView.image = [UIImage imageNamed:@"smallstar_gray.png"];
////            }
////            imageView.contentMode = UIViewContentModeScaleAspectFill;
////            [self addSubview:imageView];
////        }
//        
//        UIImageView *lineImage = [[UIImageView alloc]init];
//        lineImage.frame=CGRectMake(10,103,(Screen_Width)-20,1);
//        lineImage.image = [UIImage imageNamed:@"rule.png"];
//        [self addSubview:lineImage];
//        
//        NSString *teachType = [newTeachDic objectForKey:@"type"];
//        int type = [teachType intValue];
//        NSString *teachWork;
//        switch (type) {
//            case 0:
//                teachWork = @"其他";
//                break;
//            case 1:
//                teachWork = [newTeachDic objectForKey:@"edu_school"];
//                break;
//            case 2:
//                teachWork = @"在职老师";
//                break;
//            case 3:
//                teachWork = @"机构老师";
//                break;
//            default:
//                break;
//        }
//        
//        NSArray *timeArray = [[newTeachDic objectForKey:@"identify"] componentsSeparatedByString:@","];
//        UILabel *infoLabel = [[UILabel alloc]init];
//        infoLabel.font = Screen_MOrder;
////        infoLabel.backgroundColor = RGBACOLOR(223, 241, 249, 0.3);
//        infoLabel.frame=CGRectMake(0, 103,Screen_Width,28);
//        infoLabel.text = [NSString stringWithFormat:@"  %lu项认证 · %@年教龄 · %@",(unsigned long)[timeArray count],[newTeachDic objectForKey:@"teach_age"],teachWork];
////        %@评论[newTeachDic objectForKey:@"total_score"]
//        infoLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        [self addSubview:infoLabel];
//
//        self.frame = CGRectMake(0, 0, Screen_Width, infoLabel.frame.origin.y +infoLabel.frame.size.height);
//
//    }
//    return self;
//}
//
//
//
//-(id)initWithFrame:(CGRect)frame teachListDic:(NSDictionary*)newTeachListDic
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        UIImageView *UserImage=[[UIImageView alloc] init];
//        UserImage.frame = CGRectMake(10, 25/2, 80, 80);
//        UserImage.layer.masksToBounds = YES;
//        UserImage.layer.cornerRadius = 5;
//        UserImage.contentMode = UIViewContentModeScaleToFill;
//        if (![[newTeachListDic objectForKey:@"face"] isEqualToString:@""]) {
//            [UserImage sd_setImageWithURL:[NSURL URLWithString:[newTeachListDic objectForKey:@"face"]] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            //            self.LogoImageView.urlString = [newTeachDic objectForKey:@"face"];
//        }
//        else
//        {
//            if ([[newTeachListDic objectForKey:@"sex"] intValue] == 1)
//            {
//                [UserImage sd_setImageWithURL:[NSURL URLWithString:@"http://oss.new.968666.net/face/default/face_male.jpg"] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            }
//            else
//            {
//                [UserImage sd_setImageWithURL:[NSURL URLWithString:@"http://oss.new.968666.net/face/default/face_female.jpg"] placeholderImage:[UIImage imageNamed:@"icon_no_gravatar"]];
//            }
//        }        [self addSubview:UserImage];
//        
//        UILabel *nameLabel = [[UILabel alloc]init];
//        NSString *textString = [newTeachListDic objectForKey:@"realname"];
//        nameLabel.font = Screen_Person;
//        NSDictionary *dic=@{NSFontAttributeName:nameLabel.font};
//        CGSize sized=[textString boundingRectWithSize:CGSizeMake(320, 40) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic
//                                              context:nil].size;
//        nameLabel.frame=CGRectMake(100, 8, sized.width, sized.height);
//        nameLabel.text = textString;
//        nameLabel.textColor = RGBACOLOR(17, 17, 17, 1);
//        [self addSubview:nameLabel];
//        
//        
//        UILabel *classLabel = [[UILabel alloc]init];
//        classLabel.font = Screen_FontNaviTitle;
//        NSString *TeachDic = [NSString stringWithFormat:@"￥%@",[newTeachListDic objectForKey:@"price_lowest"]];
////        NSDictionary *dicon1 =@{NSFontAttributeName:classLabel.font};
////        CGSize sizedClass =[TeachDic boundingRectWithSize:CGSizeMake((Screen_Width)-70, 25) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dicon1 context:nil].size;
////        classLabel.frame = CGRectMake((Screen_Width)-70,3, sizedClass.width,25);
//        classLabel.frame = CGRectMake((Screen_Width)-180,3,150,25);
//        classLabel.textColor = [UIColor redColor];
//        classLabel.textAlignment = NSTextAlignmentRight;
//        classLabel.text = TeachDic;
//        [self addSubview:classLabel];
//        
//        UILabel *qiLabel = [[UILabel alloc]init];
//        qiLabel.font = Screen_Money;
//        qiLabel.textColor = RGBACOLOR(100, 100, 100, 1);
//        qiLabel.frame=CGRectMake((Screen_Width)-30, 5, 25,25);
////        qiLabel.frame=CGRectMake(classLabel.frame.origin.x+classLabel.frame.size.width, 5, 35,25);
//        qiLabel.text = @"起";
//        [self addSubview:qiLabel];
//
//        
//        
//        UILabel *contionLabel = [[UILabel alloc]init];
//        contionLabel.font = Screen_WORLD;
//        contionLabel.frame=CGRectMake(100,sized.height+12, (Screen_Width)-108,25);
//        contionLabel.text = [newTeachListDic objectForKey:@"intro_short"];
//        contionLabel.textColor = RGBACOLOR(10, 10, 10, 1);
//        [self addSubview:contionLabel];
//        
//        UILabel *StudtyLabel = [[UILabel alloc]init];
//        StudtyLabel.font = Screen_MOrder;
//        StudtyLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        StudtyLabel.frame=CGRectMake(100, contionLabel.frame.origin.y+contionLabel.frame.size.height-7, (Screen_Width)-108,30);
//        StudtyLabel.text =[NSString stringWithFormat:@"语言：%@",[newTeachListDic objectForKey:@"teach_language"]];
//        [self addSubview:StudtyLabel];
//
//        
//        UILabel *AddLabel = [[UILabel alloc]init];
//        AddLabel.font = Screen_MOrder;
//        AddLabel.frame=CGRectMake(100, 55+sized.height, (Screen_Width)-108,20);
//        AddLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        AddLabel.text =[NSString stringWithFormat:@"现住：%@-%@",[newTeachListDic objectForKey:@"addr_area"],[newTeachListDic objectForKey:@"addr_detail"]];
//        [self addSubview:AddLabel];
//        
//        UIImageView *lineImage = [[UIImageView alloc]init];
//        lineImage.frame=CGRectMake(10, 99,(Screen_Width)-20,1);
//        lineImage.image = [UIImage imageNamed:@"rule.png"];
//        [self addSubview:lineImage];
//        
//        NSString *teachType = [newTeachListDic objectForKey:@"type"];
//        int type = [teachType intValue];
//        NSString *teachWork;
//        switch (type) {
//            case 0:
//                teachWork = @"其他";
//                break;
//            case 1:
//                teachWork = [newTeachListDic objectForKey:@"edu_school"];
//                break;
//            case 2:
//                teachWork = @"在职老师";
//                break;
//            case 3:
//                teachWork = @"机构老师";
//                break;
//            default:
//                break;
//        }
//
//
//        
//        NSArray *timeArray = [[newTeachListDic objectForKey:@"identify"] componentsSeparatedByString:@","];
//        UILabel *infoLabel = [[UILabel alloc]init];
//        infoLabel.font = Screen_MOrder;
////        infoLabel.backgroundColor = RGBACOLOR(223, 241, 249, 0.3);
//        infoLabel.frame=CGRectMake(0, 100,Screen_Width,28);
//        infoLabel.text = [NSString stringWithFormat:@"  %lu项认证 · %@年教龄 · %@",(unsigned long)[timeArray count],[newTeachListDic objectForKey:@"teach_age"],teachWork];
//        infoLabel.textColor = RGBACOLOR(170, 170, 170, 1);
//        [self addSubview:infoLabel];
//
//        
//        
//        self.frame = CGRectMake(0, 0,Screen_Width, infoLabel.frame.origin.y+infoLabel.frame.size.height);
//        
////        for (int i = 0;i < newUnmber; i++) {
////            UIImageView *imageView = [[UIImageView alloc] init];
////            imageView.tag = i;
////            imageView.frame = CGRectMake(10+i*12, UserImage.frame.origin.y+UserImage.frame.size.height+3, 9, 9);
////            if (imageView.tag < 4) {
////                imageView.image = [UIImage imageNamed:@"smallstar_green.png"];
////                
////            }else{
////                imageView.image = [UIImage imageNamed:@"smallstar_gray.png"];
////            }
////            imageView.contentMode = UIViewContentModeScaleAspectFill;
////            [self addSubview:imageView];
////        }
//
//
//    }
//    return self;
//}
//
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
