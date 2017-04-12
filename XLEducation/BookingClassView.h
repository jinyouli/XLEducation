//
//  BookingClassView.h
//  XLEducation
//
//  Created by kin on 15/2/10.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeleButtonView.h"
@protocol BookingClassdelegate <NSObject>

-(void)BookingClassHiedde;
-(void)pushSuerMoney:(NSDictionary *)teachCellDic totelPrci:(float)totelMoney;
-(void)textFieldDiEditing;
-(void)scrollViewDragging;

@end

@interface BookingClassView : UIView<UIScrollViewDelegate,UITextFieldDelegate,SeleButtondelegate>
{
    NSInteger unmberPM;
    UIButton *suButton[2];
    NSInteger moneyInteger;
    NSInteger buttonTag;
    float mtoal;
}

@property(retain,nonatomic)id<BookingClassdelegate>delegate;
@property(retain,nonatomic)NSMutableArray *buttonArray;
@property(retain,nonatomic)NSMutableArray *seletionArray;
@property(retain,nonatomic)UITextField *unmberLabel;
@property(retain,nonatomic)UIImage *userImage;
@property(retain,nonatomic)UILabel *mLabel;
@property(retain,nonatomic)UIImageView *pcImage;
@property(retain,nonatomic)UIScrollView *myscrollView;
@property(retain,nonatomic)SeleButtonView *ButtonView;
@property(retain,nonatomic)UIButton *buttonIamge;
@property(retain,nonatomic)UILabel *moneyLabel;
@property(retain,nonatomic)NSDictionary *moneyDictionary;
@property(retain,nonatomic)UIButton *KeyButton;
//-(id)initWithFrame:(CGRect)frame userImage:(UIImage*)newUserImage money:(NSString *)newMoney;
-(id)initWithFrame:(CGRect)frame teachId:(NSString *)newTeachId;

@end
