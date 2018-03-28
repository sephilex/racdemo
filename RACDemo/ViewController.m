//
//  ViewController.m
//  RACDemo
//
//  Created by sephilex on 2018/3/28.
//  Copyright © 2018年 sephilex. All rights reserved.
//

#import "ViewController.h"
#import "RACDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:[RACDemoViewController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
