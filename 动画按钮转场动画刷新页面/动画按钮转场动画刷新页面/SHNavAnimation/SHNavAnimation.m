//
//  SHNavAnimation.m
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "SHNavAnimation.h"

@interface SHNavAnimation ()<CAAnimationDelegate>

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation SHNavAnimation


/**
 动画持续时间

 @param transitionContext 转场上下文
 @return NSTimeInterval
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5;
}


/**
 动画的内容

 @param transitionContext 转场上下文
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    UIView *contentView = [self.transitionContext containerView];
    
    
    CGPoint point = self.centerButton.center;
    
    // 创建在rect里的内切曲线
    UIBezierPath *origionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(point.x , point.y, 0, 0)];
    
    CGFloat X = [UIScreen mainScreen].bounds.size.width - point.x;
    CGFloat Y = [UIScreen mainScreen].bounds.size.height - point.y;
    CGFloat radius = sqrtf(X * X + Y * Y);
    UIBezierPath  *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(point.x , point.y, 0, 0), -radius, -radius)];
    
    // 获取参与转场的视图控制器
    UIViewController *toVc = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = finalPath.CGPath;
    toVc.view.layer.mask = layer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    // 所改变属性的起始值
    animation.fromValue = (__bridge id _Nullable)(origionPath.CGPath);
    // 所改变属性的结束时的值
    animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    // 动画的时长
    animation.duration = 0.25;
    // 添加动画
    [layer addAnimation:animation forKey:@"path"];
    
    [contentView addSubview:toVc.view];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:YES];
}


@end
