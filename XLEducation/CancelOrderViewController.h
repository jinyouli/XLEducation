//
//  CancelOrderViewController.h
//  XLEducation
//
//  Created by kin on 15/3/24.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelOrderViewController : UIViewController<UITextViewDelegate>
{
    NSInteger seletionButton;
}
@property(retain,nonatomic)NSMutableArray *buttonArray;
@property(retain,nonatomic)NSDictionary *CancelOrderDic;



@end
