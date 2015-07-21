//
//  NetworkUtils.m
//  Haizhu
//
//  Created by haizhu on 14/10/22.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkUtils.h"
#import "Const.h"

@implementation NetworkUtils



-(void)requestUrl: (NSString*) httpUrl :(NetCallback)calbak
{
    
    [self setNetCallback:calbak];
    NSMutableURLRequest *request = [self getAsyncRequest:httpUrl];
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    
}


-(NSDictionary*)requestUrlWithBackground: (NSString*) httpUrl
{
    NSURL * url = [NSURL URLWithString:httpUrl];
    NSError * error;
    NSLog(@"requestUrlWithBackground  url= %@",url);
    //options 干吗的？？？mark
    NSData *data=[NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&error];
    
    if (data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if(dataDic)
        {
            return dataDic;
        }else{
            NSLog(@"requestUrlWithBackground  1  %@",error);
            
        }

    }
    else{
        NSLog(@"requestUrlWithBackground  2  %@",error);

    }
    return  nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSError *error;
    
    if(LOG_ENABLE)
    {
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
    }
    
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(LOG_ENABLE)
    {
        NSLog(@"%@",dataDic);
    }
    if(self.netCallback)
    {
        
        if (dataDic) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            self.netCallback(dic,nil);
        }else
        {
            self.netCallback(nil,error);
            
        }
    }
    
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    
    if(self.netCallback)
    {
        self.netCallback(nil,error);
    }
    
    
}

- (NSMutableURLRequest *)getAsyncRequest: (NSString *)urlStr{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    //NSString *dataStr=nil;
    
    //NSData *data=[dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //[request setHTTPBody:data];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:5.0];
    NSLog(@"%@",urlStr);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    
    
    
    return request;
}

@end
