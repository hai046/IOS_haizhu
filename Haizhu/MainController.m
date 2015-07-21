//
//  MainController.m
//  Haizhu
//
//  Created by haizhu on 14/10/17.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//

#import "MainController.h"
#import "Const.h"
#import "WeatherInfo.h"
#import "CityInfo.h"
#import "NetworkUtils.h"

@interface MainController ()

@end

@implementation MainController

UITableView *tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cityList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityInfo *city=[self.cityList objectAtIndex:[indexPath row]];
    
    
    int type=city.desc?2:1;
   // NSLog(@"%d=%@",type,city.desc);
    NSString *simpleTableIdentifier=[NSString stringWithFormat:@"SimpleTableIdentifier_%d",type];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:type==1?(UITableViewCellStyleDefault):UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",city.cityName];
    if (type==2) {
        cell.detailTextLabel.text=city.desc;
    }
    // NSUInteger row=[indexPath row];
    
    
    cell.imageView.frame=CGRectMake(0, 0, 100, 100);
    cell.imageView.backgroundColor=[ [UIColor alloc]initWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    //cell.contentView
    cell.imageView.contentMode=UIViewContentModeScaleToFill;
    //cell.imageView.image=[UIImage imageNamed:@"login.png"];
    
    
    
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityInfo *city=[self.cityList objectAtIndex:[indexPath row]];
    NetworkUtils *util=[[NetworkUtils alloc]init];
    
    
    
    //    [self parseCity:[NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html",city.cityId]];
    NSString *requestUrl=[NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",city.cityId];
    
    [util requestUrl:requestUrl :^(NSDictionary * data,NSError * err) {
        
        if (err) {
            
            UIAlertView *alert=[[UIAlertView alloc]init ];
            alert.title=@"Err";
            alert.message=[NSString stringWithFormat:@"%@",err];
            [alert addButtonWithTitle:@"ok" ];
            [alert show];

            return ;
        }
        NSDictionary *weatherInfo = [data objectForKey:@"weatherinfo"];
    
        if (weatherInfo) {
            
            
            NSString *text=  [NSString stringWithFormat:@"今天是 %@  %@  %@  的天气状况是：%@  %@ \n\n%@",[weatherInfo objectForKey:@"date_y"],[weatherInfo objectForKey:@"week"],[weatherInfo objectForKey:@"city"], [weatherInfo objectForKey:@"weather1"], [weatherInfo objectForKey:@"temp1"],weatherInfo[@"index48_d"]];
            NSLog(@"weatherInfo字典里面的内容为--》%@", text );
            
            UIAlertView *alert=[[UIAlertView alloc]init ];
            alert.title=@"提示";
            alert.message=text;
            [alert addButtonWithTitle:@"ok" ];
            [alert show];
            
        }
        
        
    }];
    
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init MainController");
    }
    return self;
}

-(void)viewDidLoad
{
    self.view.backgroundColor=BASE_BACKGROUND;
    [self.navigationController  setNavigationBarHidden:NO];
    [self setTitle:@"我的主页"];
    
    
    [self initData];
    [self initView];
    NSLog(@"init MainController  viewDidLoad");
    
    [super viewDidLoad];
    [self loadData];
    
    
}

-(void)loadData
{
    dispatch_group_t group=dispatch_group_create();
    for (int i=0;i<self.cityList.count;i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            CityInfo *info=[self .cityList objectAtIndex:i];
            
            NetworkUtils *util=[[NetworkUtils alloc]init];
            
            
            NSString *requestUrl=[NSString stringWithFormat:@"http://m.weather.com.cn/data/%@.html",info.cityId];
            
            NSDictionary* data= [util requestUrlWithBackground:requestUrl];
            
            if(data)
            {
                NSDictionary *weatherInfo = [data objectForKey:@"weatherinfo"];
                if (weatherInfo) {
                    NSString *text=  [NSString stringWithFormat:@"%@  %@", [weatherInfo objectForKey:@"weather1"], [weatherInfo objectForKey:@"temp1"]];
                    if (text) {
                        dispatch_group_async(group,dispatch_get_main_queue(), ^{
                            //NSLog(@"weatherInfo字典里面的内容为--》%@", text );
                            info.desc=text;
                            [self setItemValue:i:text];
                            
                        });
                    }
                    
                }
                
            }
            
        }); 
    }
    
    
}

-(void)setItemValue:(NSInteger)position :(NSString*)text{
    if (tableView==nil) {
        return;
    }
    
    [tableView reloadData];
}


-(void)initData
{
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    
    [newArray addObject:[[CityInfo alloc] initWithParams:@"101010100" :@"北京"]];
    
    [newArray addObject:[[CityInfo alloc] initWithParams:@"101010200" :@"北京 海淀"]];
    
    [newArray addObject:[[CityInfo alloc] initWithParams:@"101010100" :@"北京 朝阳"]];
    
    [newArray addObject:[[CityInfo alloc] initWithParams:@"101180601" :@"信阳"]];
    
    
    
    
    
    [self setCityList:newArray];
    
    
    // [newArray addObject:[[CityInfo alloc] initWithParams:@"101010300" :@"朝阳"]];
    
    
}

-(void)initView
{
    //CGRect r = [ UIScreen mainScreen ].applicationFrame;
    
    CGFloat navStartY=APP_SCREEN_WIDTH*0.4;
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-0) style:UITableViewStyleGrouped];
    [self initTableView:tableView];
    
    
    UIImageView *headerView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, navStartY)];
    NSURL *url = [NSURL URLWithString: @"http://f.hiphotos.baidu.com/image/h%3D800%3Bcrop%3D0%2C0%2C1280%2C800/sign=f8acedec0cf41bd5c553e5f461e1e2b9/d000baa1cd11728bc2a286e5cafcc3cec2fd2c6d.jpg"];
    UIImage *image=[UIImage imageWithData: [NSData dataWithContentsOfURL:url] ];
    headerView.clipsToBounds=YES;
    //UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, APP_SCREEN_WIDTH, navStartY);
    headerView.image= image;
    //tableView.contentInset=insets;
    
    
    [headerView setContentMode:UIViewContentModeScaleAspectFill];
    
    
    
    
    tableView.tableHeaderView=headerView;
    //tableView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:tableView];
    
    // UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, navStartY, 100, 400)];
    //title.backgroundColor=[UIColor redColor];
    //title.text=@"text";
    // [self.view addSubview:title];
    
}
-(void)initTableView:(UITableView*)tableView
{
    
    tableView.delegate=self;
    tableView.dataSource=self;
}

@end