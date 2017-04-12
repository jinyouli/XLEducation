//
//  CellMoneySoc.m
//  XLEducation
//
//  Created by kin on 15/7/29.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "CellMoneySoc.h"

@implementation CellMoneySoc

-(NSString *)price_consult:(NSString *)consult   price_student_visit:(NSString *)student  price_teacher_visit:(NSString *)teacher
{
    int a = 0,b = 0,c = 0;
    
    if ([consult intValue] > 0) {
        a = 5;
    }
    if ([student intValue] > 0)
    {
        b = 10;
    }
    if ([teacher intValue] > 0)
    {
        c = 20;
    }
    int totle = a + b + c ;
    
    NSString *cst;
    switch (totle) {
            
        case 5:
            cst = @"协商地点";
            break;
            
        case 10:
            cst = @"学生上门";
            break;
            
        case 20:
            cst = @"老师上门";
            break;
            
        case 15:
             cst = @"协商地点,学生上门";
            break;
            
        case 25:
             cst = @"协商地点,老师上门";
            break;
            
        case 30:
            cst = @"学生上门,老师上门";
            break;
            
        case 35:
            cst = @"协商地点,学生上门,老师上门";
            break;

        default:
            break;
    }
    return cst;
    
}

@end
