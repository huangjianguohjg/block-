//
//  ViewController.m
//  block获取位置
//
//  Created by 黄建国 on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "HJGGetLocalMessageController.h"
@interface ViewController ()
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UIButton *but;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


#pragma mark - setupUI
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 200, 100)];
    self.lab.textColor = [UIColor blackColor];
    self.lab.textAlignment = NSTextAlignmentCenter;
    self.lab.font = [UIFont systemFontOfSize:20];
    self.lab.backgroundColor = [UIColor redColor];
    self.lab.numberOfLines = 0;
    [self.view addSubview:self.lab];
    self.but = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 50, 30)];
    self.but.backgroundColor = [UIColor redColor];
    [self.but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.but];
}

- (void)butClick{
    HJGGetLocalMessageController *VC = [[HJGGetLocalMessageController alloc]init];
    VC.view.backgroundColor = [UIColor greenColor];
    VC.block = ^(NSString *value){
        NSLog(@"%@",value);
        self.lab.text = value;
    };
    [self presentViewController:VC animated:YES completion:nil];
}


@end
