//
//  AppDelegate.m
//  XLEducation
//
//  Created by kin on 15/1/22.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "AppDelegate.h"
#import "NextWorkReachObjc.h"
#import "MobClick.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APService.h"
#import "Encryption.h"
#import "XLCourseViewController.h"
#import "WalletViewController.h"
#import "OrderViewController.h"
#import "XLOrderViewController.h"

#import "ChatViewController.h"
#import "EMChatManagerDelegate.h"
#import "XLSoundTool.h"
#import "FindPassWordViewController.h"

#import "MobileVersionInformation.h"
#import "XLCheckUpdate.h"
#import "XLCheckOnline.h"

#import <AdSupport/ASIdentifierManager.h>
#import "CancellationLanding.h"

#define EaseMobKEY @"51xuanshi#xuanshiwuyou"
//#define EaseMobKEY @"51xuanshi#xuanshiwuyoutest"

@implementation AppDelegate
{
    NSDictionary *jsonDicUserInfo;
    NSInteger badge;
    NSString *typeMesslaunchOptions;
    NSTimer *timer;
    NSString *appCurVersion;
    NSString* deviceName;
    NSString* phoneVersion;
}

@synthesize jsonDictionary,tencentOAuth;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    

    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [self UIDeviceInfoVersion];
    
    LoginPostNotificationName;
    
     NSString*RetLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"LOGINRET"];
    if ([RetLogin isEqualToString:@"LOGINSUCESS"])
    {
        [self XSonline];
        [self XLNetWorkQuestURLIMlonding];
    }
    [self updateUserStats];
    [self GenerateAllTheNavigation];

    NSDictionary *LaunchOptionsRemote = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [application setApplicationIconBadgeNumber:0];
    
    [[EaseMob sharedInstance]registerSDKWithAppKey:EaseMobKEY apnsCertName:@""];
    [self APServicePUSH:LaunchOptionsRemote];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)UIDeviceInfoVersion
{
    deviceName = [[UIDevice currentDevice] systemName];
    phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *deviceArray = @[deviceName,phoneVersion,appCurVersion];
    [[NSUserDefaults standardUserDefaults]setObject:deviceArray forKey:@"UIDeviceInfo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)APServicePUSH:(NSDictionary *)senderLaunchOptions
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    } else {
        //categories nil
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#else
         //categories nil
         categories:nil];
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#endif
         // Required
         categories:nil];
    }
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [senderLaunchOptions valueForKey:@"aps"];
    badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    
//        NSString *typeMess = [senderLaunchOptions objectForKey:@"type"];
//        DBG(@"=====senderLaunchOptions======%@",senderLaunchOptions);
//        
//        if ([typeMess isEqual:@"A"]) {
//            AllTabBar.selectedIndex=3;
//            //        self.NotionNameLabel.text = @"系统通知";
//        }
//        else if ([typeMess isEqual:@"B"])
//        {
//            AllTabBar.selectedIndex=0;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelOrderView" object:self userInfo:senderLaunchOptions];
//            //        self.NotionNameLabel.text = @"订单通知";
//        }
//        else if  ([typeMess isEqual:@"C"])
//        {
//            AllTabBar.selectedIndex=0;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelOrderView" object:self userInfo:senderLaunchOptions];
//            //        self.NotionNameLabel.text = @"支付通知";
//        }
//        else if  ([typeMess isEqual:@"D"])
//        {
//            AllTabBar.selectedIndex=0;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"xlOrderView" object:self userInfo:senderLaunchOptions];
//        }
//        else if  ([typeMess isEqual:@"F"])
//        {
//            AllTabBar.selectedIndex=0;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"PushWalletViewController" object:self userInfo:senderLaunchOptions];
//        }

    [APService setupWithOption:senderLaunchOptions];
}

-(void)GenerateAllTheNavigation
{
    [MobClick startWithAppkey:@"54f6a607fd98c5b27e000abb"];
    [WXApi registerApp:@"wx105b70d3818b86a6"];
    
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1104578740" andDelegate:nil];
    AllTabBar = [[CustomTabBarController alloc]init];
    AllTabBar.delegate = self;
    self.window.rootViewController=AllTabBar;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    DBG(@"=====applicationurl=====%@",url);
     if ([url.host isEqualToString:@"wechat"])
     {
         return [WXApi handleOpenURL:url delegate:self];
     }
    else
    {
        return [TencentOAuth HandleOpenURL:url];
    }
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    DBG(@"=====url111=====%@",url);
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             DBG(@"result = %@",resultDic);
                                             NSString *resultStr = resultDic[@"result"];
                                             DBG(@"====resultStr = %@",resultStr);
                                         }];
    }
    else if ([url.host isEqualToString:@"wechat"])
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    else
    {
        return [TencentOAuth HandleOpenURL:url];

    }
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

     if (alertView.tag == 15)
    {
        if (buttonIndex == 0)
        {
            NSString *typeMess = [jsonDicUserInfo objectForKey:@"type"];
            DBG(@"=====jsonDicUserInfo123======%@",jsonDicUserInfo);

            if ([typeMess isEqual:@"A"]) {
                AllTabBar.selectedIndex=3;
                //        self.NotionNameLabel.text = @"系统通知";
            }
            else if ([typeMess isEqual:@"B"])
            {
                AllTabBar.selectedIndex=0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelOrderView" object:self userInfo:jsonDicUserInfo];                
                //        self.NotionNameLabel.text = @"订单通知";
            }
            else if  ([typeMess isEqual:@"C"])
            {
                AllTabBar.selectedIndex=0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelOrderView" object:self userInfo:jsonDicUserInfo];                
                //        self.NotionNameLabel.text = @"支付通知";
            }
            else if  ([typeMess isEqual:@"D"])
            {
                AllTabBar.selectedIndex=0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"xlOrderView" object:self userInfo:jsonDicUserInfo];
            }
            else if  ([typeMess isEqual:@"F"])
            {
                AllTabBar.selectedIndex=0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PushWalletViewController" object:self userInfo:jsonDicUserInfo];
            }
            else if  ([typeMess isEqual:@"H"])
            {
                NSString *typeMessSub = [jsonDicUserInfo objectForKey:@"typeSub"];
                if ([typeMessSub intValue] == 0) {// 发现首页
                    
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"FoundViewControlle" object:self userInfo:jsonDicUserInfo];
                }
                else if ([typeMessSub intValue] == 1) {// 活动首页
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CompanyActivities" object:self userInfo:jsonDicUserInfo];
                }
                else if ([typeMessSub intValue] == 2) {// 活动内容页
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"XLCompanyWebView" object:self userInfo:jsonDicUserInfo];
                }
                else if ([typeMessSub intValue] == 3) {// 签到内容页
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"XLSignView" object:self userInfo:jsonDicUserInfo];

                }
                else if ([typeMessSub intValue] == 7) {// 资讯页
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoodInformation" object:self userInfo:jsonDicUserInfo];
                }
                else if ([typeMessSub intValue] == 8) {// 资讯内容页
                    AllTabBar.selectedIndex=0;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"XLWebComView" object:self userInfo:jsonDicUserInfo];
                }
            }
        }
    }
    else if (alertView.tag == 21)
    {
        if (buttonIndex == 0)
        {
            [self cancellationLandingURLRequest];
            AllTabBar.selectedIndex=0;
            LOGINSEXITHiddePost;
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PHPSESSID"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userImage"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"HXUID"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PASSWORD"];
            [[NSUserDefaults standardUserDefaults]setObject:@"LOGINSEXIT" forKey:@"LOGINRET"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            AllTabBar.selectedIndex=3;
            FINDEHiddePost;
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"FINDEHiddePost"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    else if (alertView.tag == 22)
    {
        if (buttonIndex == 0)
        {
            NSString *telUrl = @"telprompt:400-612-5351";
            NSURL *url = [[NSURL alloc] initWithString:telUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            [self cancellationLandingURLRequest];
            AllTabBar.selectedIndex=0;
            LOGINSEXITHiddePost;
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PHPSESSID"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"userImage"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"HXUID"];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"PASSWORD"];
            [[NSUserDefaults standardUserDefaults]setObject:@"LOGINSEXIT" forKey:@"LOGINRET"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }
    else if (alertView.tag ==23)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"GXDefaults"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (buttonIndex == 1)
        {
            NSString *urlStr2 = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/xuan-shi-wu-you-jia-zhang-ban/id1032937897?mt=8"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr2]];
        }
    }
}
-(void)cancellationLandingURLRequest
{
    NSString *hanleURL = [NSString stringWithFormat:@"%@account/logout?PHPSESSID=%@&cp=2",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID];
    [[[CancellationLanding alloc]init] CancellationUrl:hanleURL requestSuccess:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //        if (data) {
        //            NSDictionary *hanle=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        //        }
    }];
    
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

    NSLog(@"==============deviceToken ========%@",deviceToken);
    [APService registerDeviceToken:deviceToken];
    NSString *apsID = [APService registrationID];
    NSLog(@"==============apsID ========%@",apsID);

    [[NSUserDefaults standardUserDefaults]setObject:apsID forKey:@"APServiceID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//        NSString *deviceTok = [[[[deviceToken description]
//                               stringByReplacingOccurrencesOfString:@"<" withString:@""]
//                              stringByReplacingOccurrencesOfString:@">" withString:@""]
//                             stringByReplacingOccurrencesOfString: @" " withString: @""];
//    NSLog(@"==============deviceToken ========%@",deviceTok);
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
        jsonDicUserInfo = userInfo;
        DBG(@"=====userInfo333======%@",jsonDicUserInfo);
        // 取得 APNs 标准信息内容
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
        //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
        [application setApplicationIconBadgeNumber:badge];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"选师无忧消息推送" message:content delegate:self cancelButtonTitle:@"详情" otherButtonTitles:@"忽略", nil];
        alertView.tag = 15;
        [alertView show];
        [APService handleRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSDictionary *LaunchOptionsRemote = [userInfo valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

    // 取得 APNs 标准信息内容
    NSDictionary *aps = [LaunchOptionsRemote valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    [application setApplicationIconBadgeNumber:badge];

    
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);

    // Required
    [APService handleRemoteNotification:userInfo];

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"＝＝＝＝Error in registration. Error: ＝＝＝%@", err);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    // 环信
    [[EaseMob sharedInstance] applicationWillResignActive:application];

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"GXDefaults"];
    [application setApplicationIconBadgeNumber:0];
    // 环信
    [[EaseMob sharedInstance]applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    // 环信
    [[EaseMob sharedInstance]applicationWillEnterForeground:application];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    // 环信
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];


    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    // 环信
    [[EaseMob sharedInstance]applicationWillTerminate:application];

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)XLUserLonginViewHidde
{
    [self XLNetWorkQuestURLIMlonding];
    [self XSonline];
    [self updateUserStats];
}
-(void)XLNetWorkQuestURLIMlonding
{
    NSString *HXpassword = [[NSUserDefaults standardUserDefaults]objectForKey:@"HXpassword"];
    NSString *HXUID = [[NSUserDefaults standardUserDefaults]objectForKey:@"HXUID"];
    [self loginWithUsername:HXUID password:HXpassword];
    
}
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    //异步登陆账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         if (loginInfo && !error) {
             //获取群组列表
             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             //设置是否自动登录
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             //将2.1.0版本旧版的coredata数据导入新的数据库
             EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             if (!error) {
                 error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             }
             //发送自动登陆状态通知
             [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
         }
//         else
//         {
//         }
     } onQueue:nil];
    [self XLsharedInstance];
    [self registerNotifications];
}
#pragma mark===环信
#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];
}
-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}
#pragma mark - IChatManagerDelegate 登录状态变化
- (void)didLoginFromOtherDevice
{
    NSString *seleType = [[NSUserDefaults standardUserDefaults] objectForKey:@"Notice"];

    if ([seleType isEqualToString:@"SOUCE"]) {
        XLSoundTool *soundTool = [[XLSoundTool alloc] initSystemSoundWithName:@"sms-received1" SoundType:@"caf"];
        [soundTool play];
    }
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            DBG(@"退出成功");
            DBG(@"=====asdfasdinfo===%@",info);
        }
    } onQueue:nil];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的帐号在另一设备登录，您已被迫下线" delegate:self cancelButtonTitle:@"退出登录" otherButtonTitles:@"修改密码", nil];
    alertView.delegate = self;
    alertView.tag = 21;
    [alertView show];
}
-(void)didRemovedFromServer
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的帐号异常已被禁止登录，如有疑问请联系客服400-612-5351" delegate:self cancelButtonTitle:@"联系客服" otherButtonTitles:@"退 出", nil];
    alertView.delegate = self;
    alertView.tag = 22;
    [alertView show];
}
-(void)XLsharedInstance
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}
-(void)XSonline
{
    
    timer= [NSTimer scheduledTimerWithTimeInterval: 60*10
                                                     target: self
                                                   selector: @selector(handleTimer:)
                                                   userInfo: nil repeats: YES];

}
- (void)handleTimer:(NSTimer *) timer
{
    NSString *hanleURL = [NSString stringWithFormat:@"%@im/up?PHPSESSID=%@",XLNETWORKREQUESTSURLDomain,IPHNOEPHPSESSID];
    [[[XLCheckOnline alloc]init] CheckOnlineURL:hanleURL requestSuccess:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data) {
//            NSDictionary *hanle=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        }
    }];
}
-(void)updateUserStats
{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSString* devicemodel = [[UIDevice currentDevice] model];
    NSString *resolution = [NSString stringWithFormat:@"StudentDevice %0.0fx%0.0f",(Screen_Width),(Screen_Height)];
    NSString *StudentappCurVersion = [[NSString stringWithFormat:@"ios Student v%@",appCurVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    
    NSString *inforMationURL = [NSString stringWithFormat:@"%@stats/updateuserstats?uid=%@&channel=%@&model=%@&osVer=%@&appVer=%@&resolution=%@&cp=2&imei=%@&channelName=APPStore",XLNETWORKREQUESTSURLDomain,[XLUserID length] > 0?XLUserID:@"",[XLUserYQUNMBER length] > 0?XLUserYQUNMBER:@"",devicemodel,phoneVersion,StudentappCurVersion,resolution,adId];
    
    DBG(@"===inforMationURL=====%@",inforMationURL);

    
    [[MobileVersionInformation VersionInformation]MobileVersionInformationURL:inforMationURL requestSuccess:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data) {
//            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            DBG(@"===dict00000=====%@",dict);
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self UpgradeTest];
        });
    }];
}
-(void)UpgradeTest
{
    NSString *upgradeURL = [NSString stringWithFormat:@"%@stats/upgradetest?type=10&userType=3&versionCode=20&cp=2",XLNETWORKREQUESTSURLDomain];
    [[[XLCheckUpdate alloc]init] CheckUpdateURL:upgradeURL requestSuccess:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *UpgradeTestDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            DBG(@"=====UpgradeTestDic====%@",UpgradeTestDic);
            
            NSString *GXDefault = [[NSUserDefaults standardUserDefaults]objectForKey:@"GXDefaults"];
            if (![GXDefault isEqual:@"1"]) {
                if ([[UpgradeTestDic  objectForKey:@"ret"] intValue]==40001)
                {
                    [[UpgradeTestDic objectForKey:@"datas"] objectForKey:@"content"];
                    
                    NSMutableString *tishiString = [[NSMutableString alloc]init];
                    for (int i=0; i < [[[UpgradeTestDic objectForKey:@"datas"] objectForKey:@"content"]count]; i++) {
                        NSString *sdf = [[[UpgradeTestDic objectForKey:@"datas"] objectForKey:@"content"]objectAtIndex:i];
                        [tishiString appendFormat:@"%@\v",sdf];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *AlertView  = [[UIAlertView alloc]initWithTitle:@"版本更新提示！" message:tishiString delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"更新版本", nil];
                        AlertView.tag = 23;
                        [AlertView show];
                    });
                }
            }
        }
    }];
}

@end
