//
//  Encryption.h
//  49SwimSDK
//
//  Created by kin on 14-3-31.
//  Copyright (c) 2014年 49SwimNextWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject


+ (NSString *)base64StringFromText:(NSString *)text;
+ (NSString *)textFromBase64String:(NSString *)base64;

//加密
//+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
//解密
//+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key


@end
