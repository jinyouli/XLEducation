//
//  CommentsViewController.h
//  XLEducation
//
//  Created by kin on 15/2/5.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController

@property(retain,nonatomic)NSMutableArray *seleButtonArray;
@property(retain,nonatomic)UILabel *lineMove;
@property(retain,nonatomic)UIScrollView *XLCourseScrollview;
@property(retain,nonatomic)NSString *teachingId;
@property(retain,nonatomic)NSString *teachingName;
@property(retain,nonatomic)UIImage *teachingImage;



@end
