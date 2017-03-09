//
//  ViewController.m
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "ViewController.h"
#import "SHAnimationButton.h"
#import "SecondViewController.h"

#import "SHNavigationController.h"

@interface ViewController ()<SHAnimationButtonDelegate>

@property (nonatomic, strong) SHAnimationButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 可以在这里将navigationBar隐藏，效果会更好
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor cyanColor];
    
    SHAnimationButton *okButton = [SHAnimationButton buttonWithFrame:CGRectMake(80, 100, self.view.bounds.size.width - 2 * 80, 50)];
    okButton.delegate = self;
    okButton.backgroundColor = [UIColor whiteColor];
    [okButton setTitle:@"OK" forState:(UIControlStateNormal)];
    [okButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okButton];
    [okButton addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    SHAnimationButton *loginButton = [SHAnimationButton buttonWithFrame:CGRectMake(30, 300, self.view.bounds.size.width - 2 * 30, 50)];
    loginButton.delegate = self;
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"Login" forState:(UIControlStateNormal)];
    [loginButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    self.button = loginButton;
    
}

- (void)click:(SHAnimationButton *)button{
    
    [button startAnimation];
}

#pragma mark - SHAnimationButtonDelegate
- (void)SHAnimationButtonDidStartAnimation:(SHAnimationButton *)SHAnimationButton{
    
    NSLog(@"开始动画");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SHAnimationButton stopAnimation];
    });
}

- (void)SHAnimationButtonWillFinishAnimation:(SHAnimationButton *)SHAnimationButton{
    
    NSLog(@"动画将要结束时回调 即 结束动画未执行时");
    if (SHAnimationButton == self.button) {
        
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        
         [((SHNavigationController*)self.navigationController) pushViewController:secondVC withCenterButton:SHAnimationButton];
    }
}

- (void)SHAnimationButtonDidFinishAnimation:(SHAnimationButton *)SHAnimationButton{
    
    NSLog(@"结束动画");
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
