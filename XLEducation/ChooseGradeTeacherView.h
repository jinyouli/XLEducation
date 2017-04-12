//
//  ChooseGradeTeacherView.h
//  XLEducation
//
//  Created by kin on 15/8/17.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseGradeTeacherdelegate <NSObject>
@optional
-(void)ChooseGradeTeacher:(NSString*)cellSubect;

@end


@interface ChooseGradeTeacherView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic)id<ChooseGradeTeacherdelegate>delegate;
@property(retain,nonatomic)UITableView *GradeTeacherView;
@property(retain,nonatomic)NSMutableDictionary *GradeDictionary;

-(id)initWithFrame:(CGRect)frame GradeTeacherArray:(NSMutableDictionary *)newsubjectArray;

@end
