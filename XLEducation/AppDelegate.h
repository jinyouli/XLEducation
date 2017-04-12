//
//  AppDelegate.h
//  XLEducation
//
//  Created by kin on 15/1/22.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBarController.h"
#import "NextWorkReachObjc.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UIAlertViewDelegate,WXApiDelegate,IChatManagerDelegate, EMCallManagerDelegate>
{
    UINavigationController *XLPersonalNavitgation;
    CustomTabBarController *AllTabBar;
    NextWorkReachObjc * NextWorkReach;
    int payType;
}
@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSDictionary *jsonDictionary;
@property (retain, nonatomic) TencentOAuth *tencentOAuth;

@end
