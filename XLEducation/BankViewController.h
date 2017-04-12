//
//  BankViewController.h
//  XLEducation
//
//  Created by kin on 15/3/19.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BankViewdelegate <NSObject>

-(void)bankCellInfo:(NSDictionary *)newCellInfo bankName:(NSString*)newBankName;

@end

@interface BankViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)UITableView *BankTableView;
@property(retain,nonatomic)id<BankViewdelegate>delegate;


@end
