//
//  CityRegion.m
//  XLEducation
//
//  Created by kin on 15/8/4.
//  Copyright (c) 2015年 kin. All rights reserved.
//

#import "CityRegion.h"

@implementation CityRegion

@synthesize CityArray;

-(NSArray *)cityPathId:(NSString *)cityId
{
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSData *cityData = [NSData dataWithContentsOfFile:cityPath];
    NSDictionary *cityDict = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *cityRegion = [[[cityDict objectForKey:@"root"] objectAtIndex:0] objectForKey:@"sub"];
//    DBG(@"====cityRegion====%@",cityRegion);
    for (int i = 0; i < [cityRegion count]; i++)
    {
        NSArray *citysecleID = [[cityRegion objectAtIndex:i] objectForKey:@"sub"];
        for (int j = 0; j< [citysecleID count]; j++) {
            NSString *equalCity = [[citysecleID objectAtIndex:j] objectForKey:@"id"];
            
            if ([equalCity isEqualToString:cityId])
            {
                self.CityArray = [[citysecleID objectAtIndex:j] objectForKey:@"sub"];
//                DBG(@"==subArraysub==%@",CityArray);
                break;
            }
        }
    }
    return self.CityArray;

}

-(NSString *)cityPathName:(NSString *)cityName
{
    NSString *seleCityId;
    NSString *cityPath = [[NSBundle mainBundle] pathForResource:@"city.json" ofType:nil];
    NSData *cityData = [NSData dataWithContentsOfFile:cityPath];
    NSDictionary *cityDict = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingMutableLeaves error:nil];
    NSArray *cityRegion = [[[cityDict objectForKey:@"root"] objectAtIndex:0] objectForKey:@"sub"];
//    DBG(@"====cityRegion====%@",cityRegion);
    for (int i = 0; i < [cityRegion count]; i++)
    {
        NSArray *citysecleID = [[cityRegion objectAtIndex:i] objectForKey:@"sub"];
        for (int j = 0; j< [citysecleID count]; j++) {
            NSString *equalCity = [[citysecleID objectAtIndex:j] objectForKey:@"name"];
            
            if ([equalCity isEqualToString:cityName])
            {
               seleCityId = [[citysecleID objectAtIndex:j] objectForKey:@"id"];
//                self.CityArray = [[citysecleID objectAtIndex:j] objectForKey:@"sub"];
//                DBG(@"==subArraysub==%@",CityArray);
//                break;
            }
        }
    }
    return seleCityId;
}


@end
