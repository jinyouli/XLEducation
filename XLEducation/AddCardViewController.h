//
//  AddCardViewController.h
//  XLEducation
//
//  Created by kin on 15/3/13.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCarddelegate <NSObject>
@optional
-(void)AddCardHidde;

@end

@interface AddCardViewController : UIViewController<UITextFieldDelegate>

@property(weak,nonatomic)id<AddCarddelegate>delegate;
@property(retain,nonatomic)NSString *cardNumber;
@end
