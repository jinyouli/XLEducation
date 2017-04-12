//
//  commentsView.h
//  XLEducation
//
//  Created by kin on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface commentsView : UIView
{
    float heigthComment;
}

@property(assign,nonatomic)float heigthComment;
@property(retain,nonatomic) AsyncImageView *LogoImageView;


-(void)commentImage:(NSString *)newCommentImage commentUserName:(NSString *)newCommentUserName  commentContion:(NSString *)newCommentContion commentData:(NSString *)newCommentData commentClass:(NSString *)newCommentClass commentTime:(NSString *)newCommentTime;


@end
