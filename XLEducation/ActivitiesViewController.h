//
//  ActivitiesViewController.h
//  XLEducation
//
//  Created by kin on 15/8/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiesViewController : UIViewController<UIWebViewDelegate>


@property(retain,nonatomic)UIWebView *ActivitiesWebview;
@property(copy,nonatomic)NSString  *BannerUrl;
@property(copy,nonatomic)NSString  *remark;




@end
