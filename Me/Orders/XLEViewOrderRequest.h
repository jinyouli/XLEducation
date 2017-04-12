//
//  XLEViewOrderRequest.h
//  XLEducation
//
//  Created by xiliedu on 15/2/9.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol HandleRequestDelegat <NSObject>

@optional
-(void)handSucceedOrderListRequest:(ASIHTTPRequest *)request;
-(void)handSucceedOrderDetailRequest:(ASIHTTPRequest *)request;

@end

@interface XLEViewOrderRequest : NSObject
@property(nonatomic,weak)id<HandleRequestDelegat> delegate;
-(void)requestOrderListPage:(NSInteger)page type:(NSInteger)type;//request 10 items
-(void)requestOrderDetail:(NSString *)orderID;
@end
