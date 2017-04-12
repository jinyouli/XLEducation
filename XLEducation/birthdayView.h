//
//  birthdayView.h
//  XLEducation
//
//  Created by kin on 15/3/3.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol birthdayViewdelegate <NSObject>

-(void)birthday:(NSString *)newbirthday;

@end


@interface birthdayView : UIView

@property(retain,nonatomic)UIDatePicker *datePicker;
@property(retain,nonatomic)id<birthdayViewdelegate>delegate;
@property(retain,nonatomic)NSString *dateString;

-(void)birthdayPicker:(NSString *)birthdayString;


@end
