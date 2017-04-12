//
//  XLEWalletInfoModal.h
//  XLEducation
//
//  Created by xiliedu on 15/2/13.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

@protocol HandleWalletRequestDelegate <NSObject>

@optional
-(void)handleSucceedRequest:(ASIHTTPRequest *)request;

@end
@interface XLEWalletInfoModal : NSObject
@property(assign)float balance;
@property(nonatomic,retain)NSArray *transactionRecords;// for now,keep it in memory;at most 10 records. for later version,need use Core Data technology.

@property(nonatomic,weak)id<HandleWalletRequestDelegate> delegate;

-(void)requestBalance;
-(void)requestTransactionRecords;
@end
