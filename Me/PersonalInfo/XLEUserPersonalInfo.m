
//  XLEUserPersonalInfo.m
//  XLEducation
//
//  Created by xiliedu on 15/2/3.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLEUserPersonalInfo.h"
#import "ASIFormDataRequest.h"

@implementation XLEUserPersonalInfo

-(id)init
{
    self = [super init];
    if (self) {
        [self initUserInfo];
    }
    return self;
}

-(void)initUserInfo
{
    _userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:nil,_USER_FACE_KEY,@"",_USER_NAME_KEY,@"",_USER_GRADE_KEY,@"",_USER_ADDR_KEY,@"",_USER_BIRTHDAY_KEY,@"",_USER_HOBBY_KEY,@"",_USER_SHORT_INTRO_KEY,@"",_USER_SCHOOL_KEY,@"",_USER_GRADE_KEY,@"",_USER_SKILLED_COURSE_KEY,@"",_USER_INFO_UPDATEDE_KEY,nil];
}

-(NSString *)parseSex:(NSString *)sexFlag
{
    switch ([sexFlag integerValue]) {
        case 1:
            return  @"男";
            break;
        case 2:
            return  @"女";
            break;
            
        default:
            return  @"";
            break;
    }
}

-(NSString *)parseGrade:(NSString *)grade subGrade:(NSString *)subGrade
{
    switch ([grade integerValue]) {
        case 1:
        {
            switch ([subGrade integerValue]) {
                case 1:
                    return @"一年级";
                case 2:
                    return @"二年级";
                case 3:
                    return @"三年级";
                case 4:
                    return @"四年级";
                case 5:
                    return @"五年级";
                case 6:
                    return @"六年级";
                default:
                    return @"";
            }
        }
        case 2:
        {
            switch ([subGrade integerValue]) {
                case 1:
                    return @"初一";
                case 2:
                    return @"初二";
                case 3:
                    return @"初三";
                default:
                    return @"";
            }
        }
        case 3:
        {
            switch ([subGrade integerValue]) {
                case 1:
                    return @"高一";
                case 2:
                    return @"高二";
                case 3:
                    return @"高三";
                default:
                    return @"";
            }
        }
        default:
            return @"";
    }
}


-(void)handleRecieveJson:(NSDictionary *)jsonData
{
    NSString *str;
    
    str = [self parseGrade:[jsonData objectForKey:@"grade"] subGrade:[jsonData objectForKey:@"grade_sub"]];
    [_userInfo setObject:str forKey:_USER_GRADE_KEY];
    
    [_userInfo setObject:[jsonData objectForKey:@"course_adept"] forKey:_USER_SKILLED_COURSE_KEY];
    
    str = [self parseSex:[jsonData objectForKey:@"sex"]];
    [_userInfo setObject:str forKey:_USER_GENDER_KEY];
    
    [_userInfo setObject:[jsonData objectForKey:@"school"] forKey:_USER_SCHOOL_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"realname"] forKey:_USER_NAME_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"addr"] forKey:_USER_ADDR_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"intro_short"] forKey:_USER_SHORT_INTRO_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"birthday"] forKey:_USER_BIRTHDAY_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"hobby"] forKey:_USER_HOBBY_KEY];
    [_userInfo setObject:[jsonData objectForKey:@"uid"] forKey:@"uid"];
    [_userInfo setObject:@"NO" forKey:_USER_INFO_UPDATEDE_KEY];
    //    [userInfoData setObject:[jsonData objectForKey:@"phone"] forKey:@"phone"];
    
    //fetching faceImage by ASIHTTPRequest way will crash,so by this method
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
    
    //      [self requestFace:[jsonData objectForKey:@"uid"]];
    str = @"http://api.xsw100.com/account/face/";
    NSString *urlStr = [str stringByAppendingString:[jsonData objectForKey:@"uid"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    //    });
    
    [_userInfo setObject:image forKey:_USER_FACE_KEY];
    
    [self saveToLocal];
    
    if ([self.delegate respondsToSelector:@selector(updateUserCentorUI)]) {
        [self.delegate updateUserCentorUI];
    }

}

-(void)saveToLocal
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_userInfo];
    [standardUserDefaults setObject:data forKey:_USER_INFO_KEY_YWJ];
}

-(void)retrieveFromServer
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.xsw100.com/student/Info"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    request.tag = 1;
    [request setDelegate:self];
    [request startAsynchronous];

}

-(void)saveToServer
{
    [self saveToLocal];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.xsw100.com/Student/SaveInfo"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request setPostValue:[_userInfo objectForKey:_USER_NAME_KEY] forKey:@"realname"];
    [request setPostValue:[_userInfo objectForKey:_USER_NAME_KEY] forKey:@"addr"];
    [request setPostValue:[self encodeGender:[_userInfo objectForKey:_USER_GENDER_KEY]] forKey:@"sex"];
    [request setPostValue:[_userInfo objectForKey:_USER_BIRTHDAY_KEY] forKey:@"birthday"];
    [request setPostValue:[_userInfo objectForKey:_USER_HOBBY_KEY] forKey:@"hobby"];
    [request setPostValue:[_userInfo objectForKey:_USER_SHORT_INTRO_KEY] forKey:@"intro_short"];
    
    NSString *gradeCode,*subGradeCode;
    [self encodeGrade:[_userInfo objectForKey:_USER_GRADE_KEY]gradeCode:&gradeCode subGradecode:&subGradeCode];
    [request setPostValue:gradeCode forKey:@"grade"];
    [request setPostValue:subGradeCode forKey:@"grade_sub"];
    [request setPostValue:[_userInfo objectForKey:_USER_SCHOOL_KEY] forKey:@"school"];
    [request setPostValue:[_userInfo objectForKey:_USER_SKILLED_COURSE_KEY] forKey:@"course_adept"];
    
    request.tag = 2;
    
    [request setDelegate:self];
    [request startAsynchronous];
}

-(NSString *)encodeGender:(NSString *)gender
{
    if ([gender isEqualToString:@"男"]) {
        return @"1";
    } else  if([gender isEqualToString:@"女"]){
        return @"2";
    }
    else
    {
        return @"0";
    }
}

-(void)encodeGrade:(NSString *)grade gradeCode:(NSString **)gradeCode subGradecode:(NSString **)subGradeCode
{
    if ([grade isEqualToString:@"高一"]) {
        *gradeCode = @"3";
        *subGradeCode = @"1";
        
    }
    else if([grade isEqualToString:@"高二"])
    {
        *gradeCode = @"3";
        *subGradeCode = @"2";
    }
    else if([grade isEqualToString:@"高三"])
    {
        *gradeCode = @"3";
        *subGradeCode = @"3";
    }
    else if([grade isEqualToString:@"初一"])
    {
        *gradeCode = @"2";
        *subGradeCode = @"1";
    }
    else if([grade isEqualToString:@"初二"])
    {
        *gradeCode = @"2";
        *subGradeCode = @"2";
    }
    else if([grade isEqualToString:@"初三"])
    {
        *gradeCode = @"2";
        *subGradeCode = @"3";
    }
    else if([grade isEqualToString:@"一年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"1";
    }
    else if([grade isEqualToString:@"二年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"2";
    }
    else if([grade isEqualToString:@"三年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"3";
    }
    else if([grade isEqualToString:@"四年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"4";
    }
    else if([grade isEqualToString:@"五年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"5";
    }
    else if([grade isEqualToString:@"六年级"])
    {
        *gradeCode = @"1";
        *subGradeCode = @"6";
    }
    else
    {
        *gradeCode = @"0";
        *subGradeCode = @"0";
    }

}

-(void)uploadFace
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.xsw100.com/Upload/UploadFace"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    NSData *faceData = UIImageJPEGRepresentation([_userInfo objectForKey:_USER_FACE_KEY],0.1);
    [request setData:faceData withFileName:@"myphoto.jpg" andContentType:@"image/jpg" forKey:@"file"];
    request.tag = 3;
    
    [request setDelegate:self];
    [request startAsynchronous];
}

//-(void)requestFace:(NSString *)uid
//{
//    NSString *str = @"http://api.xsw100.com/account/face/";
//    NSString *urlStr = [str stringByAppendingString:uid];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSString *faceName = [uid stringByAppendingString:@".jpg"];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
////    NSArray* documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////    NSString* documentsDir = (NSString*)[documentsPaths objectAtIndex:0];
//	[request setDownloadDestinationPath:[NSHomeDirectory()/*documentsDir*/ stringByAppendingPathComponent:faceName]];
//    request.tag = 2;
//    [request setRequestMethod:@"Get"];
////    [request setDelegate:self];
//    [request setDidFinishSelector:@selector(imageFetched:)];
//    
//    [request startAsynchronous];
//}

//-(void)imageFetched:(ASIHTTPRequest *)request
//{
//     DBG(@"%s",__FUNCTION__);
//}

#pragma mark -ASIHTTPRequest Delegate Method

- (void)requestStarted:(ASIHTTPRequest *)request
{
    DBG(@"%s",__FUNCTION__);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    DBG(@"%s",__FUNCTION__);
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
//    NSString *responseString = [request responseString];
    if (request.tag == 1 && [jsonData count] >= 2 && ![[jsonData objectForKey:@"datas"] isKindOfClass:([NSString class])]) {
        NSNumber *retNumber = [jsonData objectForKey:@"ret"];
        switch ([retNumber intValue]) {
            case 0:
            {
                [self handleRecieveJson:[jsonData objectForKey:@"datas"]];
                return;
            }
            default:
                break;
        }
    }
    
//    if (request.tag == 2) {
//        DBG(@"updateFace");
////        self.headImg = [UIImage imageWithContentsOfFile:[request downloadDestinationPath]];
////        if (self.headImg && [self.delegate respondsToSelector:@selector(updateFace)]) {
////            [self.delegate updateFace];
////        }
//    }

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    DBG(@"%s %@",__FUNCTION__,[request responseString]);
    if (request.tag == 1) {
        NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [standardUserDefaults objectForKey:_USER_INFO_KEY_YWJ];
        NSMutableDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (dic && [self.delegate respondsToSelector:@selector(updateUserCentorUI)]) {
            _userInfo = dic;
            [self.delegate updateUserCentorUI];
        }
    }
    if (request.tag == 2) {
        [self saveToServer];//repeat save until succeed
    }
    if (request.tag == 3) {
        [self uploadFace]; //repeat save until succeed
    }
}

@end
