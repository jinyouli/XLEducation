//
//  KCPictureRepeatView.h
//  无线循环图片轮播器demo
//
//  Created by xiliedu on 15/8/28.
//  Copyright (c) 2015年 xiliedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCBanner.h"
@class KCBannerView;
@protocol KCBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(KCBannerView *)bannerView didSelectBannerAtIndex:(NSInteger)index;

@end

@interface KCBannerView : UIView

// 页数控件
@property (nonatomic, weak, readonly) UIPageControl *pageControl;

// 存放KCBanner模型数据数组
@property (nonatomic, strong) NSArray *banners;

// 代理
@property (nonatomic, weak) id<KCBannerViewDelegate> delegate;

// 循环间隔
@property (nonatomic, assign) CGFloat timeInterval;

// 是否循环轮播，默认为YES，当数据数组个数少于等于1时此值为NO
@property (nonatomic, assign, getter=isRepeat) BOOL repeat;

@end
