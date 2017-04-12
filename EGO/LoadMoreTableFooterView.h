//
//  LoadMoreTableFooterView.h
//  SinaWeiBoSDKDemo
//
//  Created by Ibokan on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	FooterPullRefreshPulling = 0,
	FooterPullRefreshNormal,
	FooterPullRefreshLoading,
} FooterPullRefreshState;

@protocol  LoadMoreTableFooterViewDelegate;
@interface LoadMoreTableFooterView : UIView
{
	
	id _delegate;
	FooterPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
    
}
@property(nonatomic,assign) id <LoadMoreTableFooterViewDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)FooterRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)FooterRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)FooterRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol LoadMoreTableFooterViewDelegate
- (void)FooterRefreshTableHeaderDidTriggerRefresh:(LoadMoreTableFooterView*)view;
- (BOOL)FooterRefreshTableHeaderDataSourceIsLoading:(LoadMoreTableFooterView*)view;
@optional
- (NSDate*)FooterRefreshTableHeaderDataSourceLastUpdated:(LoadMoreTableFooterView*)view;
@end

