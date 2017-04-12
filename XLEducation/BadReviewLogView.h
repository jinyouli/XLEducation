//
//  BadReviewLogView.h
//  XLEducation
//
//  Created by kin on 15/3/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BadReviewdelegate <NSObject>

-(void)BadReviewNumberInfo:(NSString *)newNumber;

@end



@interface BadReviewLogView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)UITableView *BadReviewTableView;
@property(retain,nonatomic)NSMutableArray *BadReviewArray;
@property(retain,nonatomic)id<BadReviewdelegate>delegate;
@property(retain,nonatomic)UILabel *tishiLable;


@end
