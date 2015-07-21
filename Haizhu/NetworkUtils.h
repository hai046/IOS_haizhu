//
//  NetworkUtils.h
//  Haizhu
//
//  Created by haizhu on 14/10/22.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//

typedef void (^NetCallback) (NSDictionary *,NSError *);


@interface NetworkUtils : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,copy)NetCallback netCallback;

-(void)requestUrl: (NSString*) httpUrl :(NetCallback)calbak;

-(NSDictionary*)requestUrlWithBackground: (NSString*) httpUrl;

@end

