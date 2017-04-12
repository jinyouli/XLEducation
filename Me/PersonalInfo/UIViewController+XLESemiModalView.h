//
//  UIViewController+XLESemiModalView.h
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLEBirthDayViewController;
@class XLEHeadPortraitViewController;

@interface UIViewController (XLESemiModalView)
- (void)presentSemiModalViewController:(XLEBirthDayViewController*)vc;
- (void)presentSemiModalViewController:(XLEBirthDayViewController*)vc
                                inView:(UIView *)rootView;
- (void)dismissSemiModalViewController:(XLEBirthDayViewController*)vc;

- (void)presentSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc;
- (void)presentSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc
                                inView:(UIView *)rootView;
- (void)dismissSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc;
@end
