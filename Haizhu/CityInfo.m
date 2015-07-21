//
//  City.m
//  Haizhu
//
//  Created by haizhu on 14/10/22.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//

#import "CityInfo.h"
@implementation CityInfo


-(CityInfo *)initWithParam:(NSString *)cityId ;
{
    CityInfo *city=[super init];
    if(city)
    {
        city.cityId=cityId;
    }
    return city;
    
}

-(CityInfo *)initWithParams :(NSString *)cityId :(NSString *)cityName;
{
    CityInfo *city=[super init];
    if(city)
    {
        city.cityId=cityId;
        city.cityName=cityName;
    }
    return city;
    
}

@end
