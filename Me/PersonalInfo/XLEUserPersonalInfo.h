//
//  XLEUserPersonalInfo.h
//  XLEducation
//
//  Created by xiliedu on 15/2/3.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#define _USER_FACE_KEY @"头像＊"
#define _USER_NAME_KEY @"名字＊"
#define _USER_GENDER_KEY @"性别＊"
#define _USER_ADDR_KEY @"家庭住址＊"
#define _USER_BIRTHDAY_KEY @"生日"
#define _USER_HOBBY_KEY @"爱好"
#define _USER_SHORT_INTRO_KEY @"个人简介"
#define _USER_SCHOOL_KEY @"所在学校"
#define _USER_GRADE_KEY @"年级"
#define _USER_SKILLED_COURSE_KEY @"擅长科目"
#define _USER_INFO_UPDATEDE_KEY @"updated"
#define _USER_INFO_KEY_YWJ  @"userInfoDatasYWJ"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol UpdatePersonInfoDelegate <NSObject>
@optional
-(void)updateUserCentorUI;
@end

@interface XLEUserPersonalInfo : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic,weak)id<UpdatePersonInfoDelegate> delegate;
@property(nonatomic,retain)NSMutableDictionary *userInfo;//userInfo data is little, so keep it in memory. only one in memory, other places retain it.

-(void)saveToServer;//save to local at the same time;
-(void)uploadFace;
-(void)retrieveFromServer; //if failed, retrieve from local
-(void)feedbackRequest;//
@end
