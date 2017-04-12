//
//  CancellationLanding.h
//  XLEducation
//
//  Created by kin on 16/1/28.
//  Copyright © 2016年 kin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancellationLanding : NSObject

-(void)CancellationUrl:(NSString *)requestUrl requestSuccess:(void (^)(NSURLResponse*response, NSData *data, NSError *connectionError))Success;


@end
