//
//  NextViewController.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/10.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "NextViewController.h"
#import "MyNSProxy.h"

@interface NextViewController ()
{
    NSTimer *time;
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    time = [NSTimer timerWithTimeInterval:1 target:[MyNSProxy proxyWithTarget:self] selector:@selector(timer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
}

- (void)timer:(NSTimer *)timer {
    NSLog(@"%f", timer.timeInterval);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [time invalidate];
    NSLog(@"%@", [self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
