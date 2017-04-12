//
//  ChooseTeacherSubjectsView.h
//  XLEducation
//
//  Created by kin on 15/8/17.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseTeacherSubjectsdelegate <NSObject>

@optional
-(void)ChooseTeacherSubjects:(NSString *)Subjects;

@end


@interface ChooseTeacherSubjectsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    BOOL cellBool;
}
@property(weak,nonatomic)id<ChooseTeacherSubjectsdelegate>delegate;
@property(retain,nonatomic)UITableView *ChooseTeacherTableView;
@property(retain,nonatomic)NSMutableDictionary *TeacherSubjectArray;
@property(retain,nonatomic)NSMutableArray *cellArray;
@property(retain,nonatomic)UIView *ChooseView;

-(id)initWithFrame:(CGRect)frame ChooseTeacherSubjectsArray:(NSMutableDictionary *)newsubjectDictionary;

@end
