//
//  SHNavigationController.m
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "SHNavigationController.h"
#import "SHNavAnimation.h"
@interface SHNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation SHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton *)button{
    
    self.centerButton = button;
    self.delegate = self;
    
    [super pushViewController:viewController animated:YES];
}


#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    SHNavAnimation *animation = [[SHNavAnimation alloc] init];
    animation.centerButton = self.centerButton;
    
    return animation;
}

@end
