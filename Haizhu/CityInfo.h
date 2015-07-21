//
//  City.h
//  Haizhu
//
//  Created by haizhu on 14/10/22.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CityInfo : NSObject

-(CityInfo *)initWithParams :(NSString *)cityId :(NSString *)cityName;


@property (nonatomic)NSString *cityName;

@property (nonatomic)NSString *cityId;

@property (nonatomic)NSString *desc;

@end