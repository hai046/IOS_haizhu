//
//  ViewController.m
//  Haizhu
//
//  Created by haizhu on 14/10/17.
//  Copyright (c) 2014年 haizhu. All rights reserved.
//

#import "ViewController.h"
#import "Const.h"
#import "MainController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [self initView];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController  setNavigationBarHidden:YES];
    
    
    [ super viewWillAppear:animated];
    
}
-(void)initView{
    
    
    
    self.view.backgroundColor=BASE_BACKGROUND;
    
    
    
    CGFloat padding=20;
    CGFloat viewHeight=40;
    UIColor *baseBackgroundColor=[[UIColor alloc] initWithRed:0.9 green:0.9 blue:0.9 alpha:1 ];
    
    CGFloat up=APP_SCREEN_BOUNDS.size.height-viewHeight*4-4*padding;
    
    
    UILabel *mNameTip=[[UILabel alloc ]initWithFrame:CGRectMake(padding, up, 100, viewHeight)];
    
    mNameTip.backgroundColor=baseBackgroundColor;
    mNameTip.textAlignment=NSTextAlignmentCenter;
    mNameTip.text=@"帐号:";
    
    
    UITextField *mNameView=[[UITextField alloc]initWithFrame:CGRectMake(padding+100, up , APP_SCREEN_WIDTH-padding-(padding+100), viewHeight)];
    mNameView.backgroundColor=baseBackgroundColor;
    mNameView.placeholder=@"请输入你的用户名";
    //
    //UIImageView *logo=[[UIImageView alloc ];
    
    
    [self.view addSubview:mNameView];
    [self.view addSubview:mNameTip];
    
    
    
    up+=padding+mNameView.bounds.size.height;
    UILabel *mPwdTip=[[UILabel alloc ]initWithFrame:CGRectMake(padding, up, 100, viewHeight)];
     
    mPwdTip.backgroundColor=baseBackgroundColor;
    mPwdTip.textAlignment=NSTextAlignmentCenter;
    mPwdTip.text=@"密码:";
    
    
    UITextField *mPwdView=[[UITextField alloc]initWithFrame:CGRectMake(padding+100, up , APP_SCREEN_WIDTH-padding-(padding+100), viewHeight)];
    mPwdView.placeholder=@"请输入你的密码";
    mPwdView.backgroundColor=baseBackgroundColor;
    mPwdView.secureTextEntry=YES;
    
    
    UIButton *btnLogin=[[UIButton alloc] initWithFrame:CGRectMake(2*padding+5, APP_SCREEN_HEIGHT-2*padding-2*viewHeight, APP_SCREEN_WIDTH-(4*padding), 2*viewHeight)];
    
    
    
    [btnLogin setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchDown];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(padding, 2*padding, APP_SCREEN_WIDTH-padding-padding, mNameTip.frame.origin.y-3*padding)];
    //
    NSURL *url = [NSURL URLWithString: @"http://d.hiphotos.baidu.com/image/pic/item/f2deb48f8c5494eedb6c5c692ef5e0fe99257e77.jpg"];
    image.image= [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    [image setClipsToBounds:YES];
    [image setContentMode:UIViewContentModeCenter];
    
    image.contentMode = UIViewContentModeCenter;
    image.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"http://c.hiphotos.baidu.com/image/w%3D310/sign=74bb6b9cb01c8701d6b6b4e7177e9e6e/21a4462309f79052c2ea92460ff3d7ca7acbd5d5.jpg"],
                             [UIImage imageNamed:@"http://a.hiphotos.baidu.com/image/w%3D310/sign=1100c34d6d061d957d4631394bf40a5d/f7246b600c33874453f99509520fd9f9d72aa083.jpg"], nil];
    [image startAnimating];

    

    [self.view addSubview:image];
    
    
    [self.view addSubview:mPwdTip];
    [self.view addSubview:mPwdView];
    [self.view addSubview:btnLogin];
}



-(void)btnLoginClick{
    NSLog(@"loginclick");
    NSLog(@"controller %@",self.navigationController);
    MainController *mMainController=[[MainController alloc] init];
    
    
    [self.navigationController pushViewController: mMainController animated:true];
    
   // AppDelegate *appDelegate = [AppDelegate  sharedAppDelegate];
  //  UINavigationController *navigationController = appDelegate.window.rootViewController;

    
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
