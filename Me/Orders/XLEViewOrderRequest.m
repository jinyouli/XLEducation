//
//  XLEViewOrderRequest.m
//  XLEducation
//
//  Created by xiliedu on 15/2/9.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEViewOrderRequest.h"
#import "ASIFormDataRequest.h"

@implementation XLEViewOrderRequest
-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestOrderListPage:(NSInteger)page type:(NSInteger)type;//request 10 items
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xsw100.com/Order/OrderList?pagesize=10&page=%ld&type=%ld",page,type];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    request.tag = 1;
    
    [request startAsynchronous];
}

-(void)requestOrderDetail:(NSString *)orderID
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xsw100.com/Order/GetOrder?order_id=%@",orderID];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    request.tag = 2;
   
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    
//    [request setRequestMethod:@"POST"];
//    [request setPostValue:orderID forKey:@"order_id"];
//    [request setPostValue:@"1" forKey:@"pagesize"];
//    [request setPostValue:@"1" forKey:@"page"];
//    request.tag = 2;
    
    [request setDelegate:self];
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
    if ([self.delegate respondsToSelector:@selector(handSucceedOrderListRequest:)] && request.tag == 1) {
        [self.delegate handSucceedOrderListRequest:request];
    }
    
    if ([self.delegate respondsToSelector:@selector(handSucceedOrderDetailRequest:)] && request.tag == 2) {
        [self.delegate handSucceedOrderDetailRequest:request];
    }
    
    DBG(@"%s",__FUNCTION__);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBG(@"%s %@",__FUNCTION__,[request error]);
//    [_comments removeAllObjects];
}
@end
