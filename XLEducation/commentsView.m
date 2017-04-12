//
//  commentsView.m
//  XLEducation
//
//  Created by kin on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "commentsView.h"
@implementation commentsView

@synthesize heigthComment,LogoImageView;

-(id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)commentImage:(NSString *)newCommentImage commentUserName:(NSString *)newCommentUserName  commentContion:(NSString *)newCommentContion commentData:(NSString *)newCommentData commentClass:(NSString *)newCommentClass commentTime:(NSString *)newCommentTime;
{
//        UIImageView *UserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
//        UserImageView.layer.masksToBounds = YES;
//        UserImageView.layer.cornerRadius = 20;
//        UserImageView.image = [UIImage imageNamed:newCommentImage];
//        [self addSubview:UserImageView];
    
    AsyncImageView *UserImage=[[AsyncImageView alloc]init];
    UserImage.frame = CGRectMake(10, 5, 40, 40);
    UserImage.layer.masksToBounds = YES;
    UserImage.layer.cornerRadius = 20;
    UserImage.contentMode = UIViewContentModeScaleToFill;
    self.LogoImageView=UserImage;
    if (![newCommentImage isEqualToString:@""]) {
//        self.LogoImageView.urlString = [NSString stringWithFormat:@"%@%@",XLNETWORKREQUESTSURL,newCommentImage];
        self.LogoImageView.urlString = newCommentImage;
//        DBG(@"====urlString====%@",self.LogoImageView.urlString);
    }else{
        self.LogoImageView.image = [UIImage imageNamed:@"default_use_image2.png"];
    }
    [self addSubview:UserImage];

    
        UILabel *nameLabel = [[UILabel alloc]init];
        NSString *textString = newCommentUserName;
        nameLabel.font = [UIFont systemFontOfSize:17];
        NSDictionary *dic=@{NSFontAttributeName:nameLabel.font};
        CGSize sizedd=[textString boundingRectWithSize:CGSizeMake(320, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic
                                              context:nil].size;
        nameLabel.frame=CGRectMake(60, 18, sizedd.width, sizedd.height);
        nameLabel.text = textString;
        nameLabel.textColor = RGBACOLOR(17, 17, 17, 1);
        [self addSubview:nameLabel];
        
//        for (int i = 0;i < 5; i++) {
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.tag = i;
//            imageView.frame = CGRectMake(65+sizedd.width+i*13, 23, 10, 10);
//            if (imageView.tag < 4) {
//                imageView.image = [UIImage imageNamed:@"star_green.png"];
//            }else{
//                imageView.image = [UIImage imageNamed:@"smallstar_gray.png"];
//            }
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
//            [self addSubview:imageView];
//        }
    
        UILabel *plLabel = [[UILabel alloc]init];
        NSString *plString = newCommentContion;
        plLabel.font = [UIFont systemFontOfSize:17];
        plLabel.numberOfLines = 0;
        plLabel.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *pldic=@{NSFontAttributeName:plLabel.font};
        CGSize sizepl=[plString boundingRectWithSize:CGSizeMake((Screen_Width)-30, 2000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:pldic
                                              context:nil].size;
        plLabel.frame=CGRectMake(15, 50, (Screen_Width)-30, sizepl.height);
        plLabel.text = [NSString stringWithFormat:@"\t%@",plString];
        plLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        plLabel.textAlignment = NSTextAlignmentJustified;
        [self addSubview:plLabel];
        
        NSArray *titleArray = @[newCommentData,newCommentClass,newCommentTime];
        for (int i = 0; i < 3; i++) {
            UILabel *timeLabel = [[UILabel alloc]init];
            timeLabel.frame = CGRectMake(10+(Screen_Width)/3*i, 5+plLabel.frame.origin.y+plLabel.frame.size.height, (Screen_Width)/3, 20);
            timeLabel.text = [titleArray objectAtIndex:i];
            timeLabel.font = [UIFont systemFontOfSize:13];
            if (i > 0) {
                timeLabel.textAlignment = NSTextAlignmentCenter;
            }
            timeLabel.textColor = RGBACOLOR(100, 100, 100, 1);
            [self addSubview:timeLabel];
        }
    
    self.heigthComment = 30+plLabel.frame.origin.y+plLabel.frame.size.height;
    self.frame = CGRectMake(0, 0, Screen_Width, self.heigthComment);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
