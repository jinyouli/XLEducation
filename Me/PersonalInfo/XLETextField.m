//
//  XLETextField.m
//  XLEducation
//
//  Created by xiliedu on 15/2/4.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "XLETextField.h"

@implementation XLETextField
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 20 , 10 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 20 , 10 );
}
@end
