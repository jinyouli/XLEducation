//
//  UIViewController+XLESemiModalView.m
//  XLEducation
//
//  Created by xiliedu on 15/1/31.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "UIViewController+XLESemiModalView.h"
#import "XLEBirthDayViewController.h"
#import "XLEHeadPortraitViewController.h"

//@implementation UIViewController (XLESemiModalView)

@interface UIViewController()

@property (readonly) CGPoint offscreenCenter;

@end

@implementation UIViewController (TDSemiModalExtension)

#pragma mark -
#pragma mark Properties

- (CGPoint) offscreenCenter
{
    CGPoint offScreenCenter = CGPointZero;
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
    if(orientation == UIInterfaceOrientationLandscapeLeft
       || orientation == UIInterfaceOrientationLandscapeRight)
    {
        offScreenCenter = CGPointMake(offSize.height / 2.0, offSize.width * 1.5);
    } else {
        offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    }
    
    return offScreenCenter;
}

#pragma mark -
#pragma mark Insntance methods

// Use this to show the modal view (pops-up from the bottom)
- (void) presentSemiModalViewController:(XLEBirthDayViewController*)vc
{
    UIView *rootView = [[UIApplication sharedApplication] keyWindow];
    [self presentSemiModalViewController:vc inView:rootView];
}

- (void) presentSemiModalViewController:(XLEBirthDayViewController*)vc
                                 inView:(UIView *)rootView
{
    UIView* modalView = vc.view;
    UIView* coverView = vc.coverView;
    
    coverView.frame = rootView.bounds;
    coverView.alpha = 0.0f;
    
    modalView.frame = rootView.bounds;
    modalView.center = self.offscreenCenter;
    
    [rootView addSubview:coverView];
    [rootView addSubview:modalView];
    
    [UIView animateWithDuration:.6 animations:^{
        modalView.frame = CGRectMake(0,
                                     0,
                                     modalView.frame.size.width,
                                     modalView.frame.size.height);
        coverView.alpha = 0.5;
    }];
}

-(void) dismissSemiModalViewController:(XLEBirthDayViewController*)vc
{
    double animationDelay = 0.7;
    UIView* modalView = vc.view;
    UIView* coverView = vc.coverView;
    
    [UIView animateWithDuration:animationDelay animations:^{
        modalView.center = self.offscreenCenter;
        coverView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [coverView removeFromSuperview];
            [modalView removeFromSuperview];
        }
    }];
}


- (void)presentSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc
{
    UIView *rootView = [[UIApplication sharedApplication] keyWindow];
    [self presentSemiModalPhotoViewController:vc inView:rootView];
}
- (void)presentSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc
                                     inView:(UIView *)rootView
{
    UIView* modalView = vc.view;
    UIView* coverView = vc.coverView;
    
    coverView.frame = rootView.bounds;
    coverView.alpha = 0.0f;
    
    modalView.frame = rootView.bounds;
    modalView.center = self.offscreenCenter;
    
    [rootView addSubview:coverView];
    [rootView addSubview:modalView];
    
    [UIView animateWithDuration:.6 animations:^{
        modalView.frame = CGRectMake(0,
                                     0,
                                     modalView.frame.size.width,
                                     modalView.frame.size.height);
        coverView.alpha = 0.5;
    }];
}
- (void)dismissSemiModalPhotoViewController:(XLEHeadPortraitViewController*)vc
{
    double animationDelay = 0.7;
    UIView* modalView = vc.view;
    UIView* coverView = vc.coverView;
    
    [UIView animateWithDuration:animationDelay animations:^{
        modalView.center = self.offscreenCenter;
        coverView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        if (finished) {
            [coverView removeFromSuperview];
            [modalView removeFromSuperview];
        }
    }];
}

@end
