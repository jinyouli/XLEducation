//
//  AllCommentsView.h
//  XLEducation
//
//  Created by kin on 15/2/6.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllCommentsdelegate <NSObject>

-(void)AllCommentsdelegate:(NSString *)Number;

@end

@interface AllCommentsView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)UITableView *AllCommentsTableView;
@property(retain,nonatomic)NSMutableArray *commentsArray;
@property(retain,nonatomic)id<AllCommentsdelegate>delegate;
@property(retain,nonatomic)UILabel *tishiLable;
-(id)initWithFrame:(CGRect)frame teachingId:(NSString *)newTeachingId;

@end
