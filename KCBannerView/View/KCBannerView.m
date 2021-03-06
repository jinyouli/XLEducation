//
//  KCPictureRepeatView.m
//  无线循环图片轮播器demo
//
//  Created by xiliedu on 15/8/28.
//  Copyright (c) 2015年 xiliedu. All rights reserved.
//

#import "KCBannerView.h"
#import "KCBannerCell.h"
#import "KCBanner.h"

@interface KCBannerView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;


@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KCBannerView

const NSInteger KCMaxSection = 100;

static NSString *const ID = @"banner";

- (void)addTimer
{
    if (!self.isRepeat) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    NSIndexPath *resetIndexPath = [self resetIndexPath];
    
    NSInteger item = resetIndexPath.item + 1;
    NSInteger section = resetIndexPath.section;
    
    if (item == self.banners.count) {
        item = 0;
        section++;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (NSIndexPath *)resetIndexPath
{
    NSIndexPath *visibleIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *resetIndexPath = [NSIndexPath indexPathForItem:visibleIndexPath.item inSection:KCMaxSection / 2];
    
    [self.collectionView scrollToItemAtIndexPath:resetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return resetIndexPath;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.timeInterval = 3.0;
        self.repeat = YES;
        
        [self setupCollectionView];
        
        [self setupPageControl];
    }
    return self;
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor = editioncolor;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    [collectionView registerClass:[KCBannerCell class] forCellWithReuseIdentifier:ID];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat pageWH = 15;
    CGFloat pageControlH = pageWH;
    CGFloat pageControlW = pageWH * self.pageControl.numberOfPages;
    CGFloat pageControlX = self.frame.size.width - pageControlW;
    CGFloat pageControlY = self.frame.size.height - pageControlH;
    
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    self.collectionView.frame = self.bounds;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = self.collectionView.bounds.size;
    
}

#pragma mark -公共方法

- (BOOL)isRepeat
{
    return self.banners.count <= 1 ? NO : _repeat;
}

- (void)setBanners:(NSArray *)banners
{
    _banners = banners;
    
    self.pageControl.numberOfPages = banners.count;
    
    [self.collectionView reloadData];
    
    [self addTimer];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.banners.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.banners.count <= 1 ? 1 : KCMaxSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KCBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.banner = self.banners[indexPath.item];
    
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectBannerAtIndex:)]) {
        [self.delegate bannerView:self didSelectBannerAtIndex:indexPath.row];
    }
}

#pragma mark scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.banners.count;
    self.pageControl.currentPage = currentPage;
}



@end
