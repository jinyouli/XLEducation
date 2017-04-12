//
//  BasicInformationView.h
//  XLEducation
//
//  Created by kin on 15/2/7.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol rzPushcontrollerdelegate <NSObject>

@optional
-(void)rzPushcontrollerPush:(int)tagButton;

@end

@interface BasicInformationView : UIView
{
    int a;
    int b;
    float worldSize;

}


@property(assign,nonatomic)float heigth;
@property(weak,nonatomic)id<rzPushcontrollerdelegate>delegate;
//-(void)BasicInforidentify:(NSDictionary *)newidentify  teachAchNum:(NSDictionary*)newteachAchNum cityId:(NSString *)SeleCityId;

-(void)BasicInforidentify:(NSDictionary *)newidentify  teachAchNum:(NSDictionary*)newteachAchNum cityId:(NSArray *)subArray;



@end
