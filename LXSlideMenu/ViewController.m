//
//  ViewController.m
//  LXSlideMenu
//
//  Created by XIAO on 2017/4/12.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import "ViewController.h"
#import "LXSlideMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(0, 0, 60, 30);
    [navBtn setTitle:@"点击" forState:UIControlStateNormal];
    [navBtn setBackgroundColor:[UIColor redColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:navBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    UIView *slideMenu = [[UIView alloc]init];
    slideMenu.backgroundColor = [UIColor yellowColor];
        
    LXSlideMenu *menu = [[LXSlideMenu alloc]initWithSlideViewModel:LXSlideViewLeftModel superController:self slideMenu:slideMenu slideMenuWidth:300 clickButton:navBtn];
    [self.view addSubview:menu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
