//
//  CityRegion.h
//  XLEducation
//
//  Created by kin on 15/8/4.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityRegion : NSObject


@property(retain,nonatomic)NSArray *CityArray;

-(NSArray *)cityPathId:(NSString *)cityId;
-(NSString *)cityPathName:(NSString *)cityName;

@end
