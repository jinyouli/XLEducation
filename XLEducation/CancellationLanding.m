//
//  CancellationLanding.m
//  XLEducation
//
//  Created by kin on 16/1/28.
//  Copyright © 2016年 kin. All rights reserved.
//

#import "CancellationLanding.h"

@implementation CancellationLanding



-(void)CancellationUrl:(NSString *)requestUrl requestSuccess:(void (^)(NSURLResponse*response, NSData *data, NSError *connectionError))Success
{
    NSURL *url=[NSURL URLWithString:requestUrl];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        Success(response, data, connectionError);
    }];
}


@end
