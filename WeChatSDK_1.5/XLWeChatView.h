//
//  XLWeChatView.h
//  XLEducation
//
//  Created by kin on 15/5/5.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"

@protocol XLWeChatdelegate <NSObject>

-(void)XLWeChatHieth;

@end

@interface XLWeChatView : UIView<WXApiDelegate>

@property(retain,nonatomic)id<XLWeChatdelegate>delegate;

@end
