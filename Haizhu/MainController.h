//
//  MainController.h
//  Haizhu
//
//  Created by haizhu on 14/10/17.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface MainController :  UIViewController<UITableViewDelegate, UITableViewDataSource,NSURLConnectionDataDelegate>

@property (nonatomic,strong)NSMutableArray *cityList;

@end
