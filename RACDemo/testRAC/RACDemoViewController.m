//
//  RACDemoViewController.m
//  RACDemo
//
//  Created by sephilex on 2018/3/28.
//  Copyright © 2018年 sephilex. All rights reserved.
//

#import "RACDemoViewController.h"

@interface RACDemoViewController ()

@end

@implementation RACDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self demo2];
}

- (void)demo2 {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *bindSignal = [signal bind:^RACSignalBindBlock _Nonnull{
        return ^(NSNumber *value, BOOL *stop) {
            value = @(value.integerValue * value.integerValue);
            return [RACSignal return:value];
        };
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"signal: %@", x);
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"bindSignal: %@", x);
    }];
}

- (void)demo1 {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"信号回调"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"5秒后的回调"];
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"主线程异步回调"];
        });
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [subscriber sendNext:@"全局队列同步回调"];
        });
        NSLog(@"看看什么时候来这里");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"啥时候轮到我");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

@end
