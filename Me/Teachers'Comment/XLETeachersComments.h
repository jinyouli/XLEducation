//
//  XLETeachersComments.h
//  XLEducation
//
//  Created by xiliedu on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol CommentsDelagate <NSObject>
@optional
-(void)updateCommentUI;
@end

@interface XLETeachersComments : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic,retain)NSMutableArray *comments;
@property(nonatomic,weak)id<CommentsDelagate> delegate;
-(void)requestCommentsPage:(NSInteger)page type:(NSInteger)type;//request 10 items
@end
