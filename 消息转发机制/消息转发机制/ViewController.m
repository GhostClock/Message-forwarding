//
//  ViewController.m
//  消息转发机制
//
//  Created by GhostClock on 2018/5/2.
//  Copyright © 2018年 GhostClock. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#import "MyClass_resolve.h"
#import "MyClass_forwardingTargetSelector.h"
#import "MyClass_forwardInvocation.h"
#import "DealerProxy.h"
#import "AOP_TestClass.h"

#import "NextViewController.h"

static NSString *const KEY = @"KEY";

@interface ViewController ()
{
    NSString *_log;
}
@end

@implementation ViewController

@dynamic log;

// 方法一
void setLog(id self, SEL _cmd, NSString *log) {
    objc_setAssociatedObject(self, &KEY, log, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

NSString* getLog(id self, SEL _cmd) {
    NSString *log = objc_getAssociatedObject(self, &KEY);
    return log;
}

// 方法二
- (void)setLogForMyself:(NSString *)log {
    if (_log != log) {
        _log = [log copy];
    }
}
- (NSString *)getLogForMyself {
    return _log;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(setLog:)) {
        // 方法一
        class_addMethod(self, sel, (IMP)setLog, "v@:@");
        
        // 方法二
//        NSLog(@"%@ - %@ - %@", self, [self class], object_getClass(self));
//        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(setLogForMyself:)), "v@:@"); // 这里使用 self, [self class]都一样，但是不能用object_getClass(self)
        return YES;
    } else if (sel == @selector(log)) {
        // 方法一
        class_addMethod(self, sel, (IMP)getLog, "@@:");
        
//        // 方法二
//        class_addMethod(self, sel, class_getMethodImplementation(self, @selector(getLogForMyself)), "@@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyClass_resolve *my = [[MyClass_resolve alloc]init];
    [my instanceMethod:@"MyClass_resolve"];
    [MyClass_resolve classMethod:@"MyClass_resolve"];
    
    MyClass_forwardingTargetSelector *my2 = [[MyClass_forwardingTargetSelector alloc] init];
    [my2 instanceMethod:@"MyClass_forwarding"];
    [MyClass_forwardingTargetSelector classMethod:@"MyClass_forwarding"];
    
    MyClass_forwardInvocation *my3 = [[MyClass_forwardInvocation alloc] init];
    [my3 instanceMethod:@"MyClass_forwardInvocation"];
    
    self.log = @"123";
    NSLog(@"%@", self.log);
    
    [self testProxy];
    
    [self testAOPProxy];
}

- (void)testProxy {
    DealerProxy *dealerProxy = [DealerProxy dealerProxy];
    [dealerProxy purchaseBookWithTitle:@"Swift"];
    [dealerProxy purchaseClothesWithSize:CLOTHES_SIZE_MEDIUM];
}

- (void)testAOPProxy {
    [[[AOP_TestClass alloc] init] getData];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:[NextViewController new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    void(^block)(void) = ^(void) {
        
    };
    
    !block ?: block();
    
    int(^block1)(int a, int b) = ^(int aa, int bb) {
        return aa + bb;
    };
    
    int result = !block1 ?: block1(1, 2);
    [self test:^int(int a, int b) {
        return a + b;
    }];
    
    void(^block2)();
    
    [self test2WithApi:1 block:^(NSInteger a, NSInteger b){
        
    }];
    
    [self test2WithApi:2 block:^(NSString *str, NSInteger num, NSArray *arr){
        
    }];
}

- (void)test:(int (^)(int a, int b))block {
    
}

- (void)test2WithApi:(NSInteger)api block:(void (^)())block {
    if (api == 1) {
        block(1, 2, 3);
    } else if (api == 2) {
        block(@"1", @2, @[@1, @2, @3, @4]);
    }
}

- init {
    return self;
}

- (void)foo:arg {
    
}

- (void) :(id)arg1 :(id)arg2 :(NSString *)str {
    
}

@end
