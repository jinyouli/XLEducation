//
//  XLETeachersComments.m
//  XLEducation
//
//  Created by xiliedu on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLETeachersComments.h"

@implementation XLETeachersComments
-(id)init
{
    self = [super init];
    if (self) {
        _comments = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(void)requestCommentsPage:(NSInteger)page type:(NSInteger)type;//request 10 items
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xsw100.com/Credit/CreditList?pagesize=10&page=%ld&type=%ld",(long)page,(long)type];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    
    [request startAsynchronous];
}
#pragma mark - ASIHTTPRequest Delegate
- (void)requestStarted:(ASIHTTPRequest *)request
{
    DBG(@"%s",__FUNCTION__);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSInteger ret = [[jsonData objectForKey:@"ret"] intValue];
    [_comments removeAllObjects];
    if(ret == 0 && [self.delegate respondsToSelector:@selector(updateCommentUI)] && [jsonData count] >= 3)
    {
        NSSet *datas = [jsonData objectForKey:@"datas"];
        for (id item in datas)
        {
            [_comments addObject:item];
        }
            [self.delegate updateCommentUI];
    }
    else if([self.delegate respondsToSelector:@selector(updateCommentUI)])
    {
        [self.delegate updateCommentUI];
    }
    DBG(@"%s",__FUNCTION__);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBG(@"%s %@",__FUNCTION__,[request error]);
    [_comments removeAllObjects];
}

@end
