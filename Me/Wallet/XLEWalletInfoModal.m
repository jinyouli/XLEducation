//
//  XLEWalletInfoModal.m
//  XLEducation
//
//  Created by xiliedu on 15/2/13.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEWalletInfoModal.h"

@implementation XLEWalletInfoModal


-(id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
-(void)requestBalance
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xsw100.com/money/GetBalance?"];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    request.tag = 1;
    
    [request startAsynchronous];
}
-(void)requestTransactionRecords
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xsw100.com/money/SwiftList?pagesize=10&page=1"];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    request.tag = 2;
    
    [request startAsynchronous];
}

#pragma mark - ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSInteger ret = [[jsonData objectForKey:@"ret"] intValue];
    if (request.tag == 1 && ret == 0 && [jsonData count] >= 2 && ![[jsonData objectForKey:@"datas"] isKindOfClass:([NSString class])]) {
        self.balance = [[[jsonData objectForKey:@"datas"] objectForKey:@"balance"] floatValue];
        if ([self.delegate respondsToSelector:@selector(handleSucceedRequest:)]) {
            [self.delegate  handleSucceedRequest:request];
        }
        
    }
    
    if (request.tag == 2 && ret == 0 && ![[jsonData objectForKey:@"datas"] isKindOfClass:([NSString class])]) {
        _transactionRecords = [jsonData objectForKey:@"datas"];
        if ([self.delegate respondsToSelector:@selector(handleSucceedRequest:)]) {
            [self.delegate  handleSucceedRequest:request];
        }
    }
    DBG(@"%s",__FUNCTION__);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBG(@"%s %@",__FUNCTION__,[request error]);
//    [_comments removeAllObjects];
}
@end
