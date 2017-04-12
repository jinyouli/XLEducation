//
//  SetViewController.h
//  XLEducation
//
//  Created by xiliedu on 15/1/30.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLEBirthDayViewController;
@protocol SettingviewDelegate <NSObject>

@optional
-(void)setName:(NSString *)name;
-(void)setBiography:(NSString *)biography;
-(void)setHobby:(NSString *)hobby;
-(void)setAddr:(NSString *)addr;
-(void)setGender:(BOOL)isMan;
-(void)setGrade:(NSString *)grade;
-(void)setSchoolInfo:(NSString *)schoolInfo;
-(void)setSkilledCourses:(NSArray *)skilledCourseArray;

- (void)datePickerSetDate:(XLEBirthDayViewController*)viewController;
//- (void)datePickerClearDate:(XLEBirthDayViewController*)viewController;
- (void)datePickerCancel:(XLEBirthDayViewController*)viewController;
//-(void)imgPickerVC:(UIViewController *)vc;
-(void)setHeadImg:(UIImage *)image;

@end

@interface XLESetViewController : UIViewController
@property(nonatomic,weak)id<SettingviewDelegate> delegate;
@property UIView *coverView;
@end
