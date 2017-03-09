//
//  SHCircleAnimationView.m
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "SHCircleAnimationView.h"

@interface SHCircleAnimationView ()

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat timeFlag;

@end

@implementation SHCircleAnimationView

+ (instancetype)viewWithButton:(UIButton *)button{
    
    SHCircleAnimationView *animationView = [[SHCircleAnimationView alloc] initWithFrame:CGRectMake(-8, -8, button.frame.size.width + 16, button.frame.size.height + 16)];
    animationView.backgroundColor = [UIColor clearColor];
    
    animationView.borderColor = button.titleLabel.textColor;
    
    animationView.timeFlag = 0;
    
    return animationView;
}

- (void)removeFromSuperview{
    
    [self.timer invalidate];
    [super removeFromSuperview];
}

- (void)startAnimation{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(continueAnimation) userInfo:nil repeats:YES];
    
    [self.timer fire];
}

- (void)continueAnimation{
    
    self.timeFlag += 0.02;
    
    // 因为drawRect方法只调用1次，所以如果需要刷新图形，需要用setNeedsDisplay强制调用刷新
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 圆心
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    // 半径
    CGFloat radius = rect.size.width / 2 - 2;
    // 起始的弧度
    CGFloat start = -M_PI_2 + self.timeFlag * 2 * M_PI;
    // 圆弧结束的弧度
    CGFloat end = -M_PI_2 + 0.45 * 2 * M_PI + self.timeFlag * 2 * M_PI;
    
    [path addArcWithCenter:center radius:radius startAngle:start endAngle:end clockwise:YES];   // clockwise：YES为顺时针，NO为逆时针
    
    // 设置描边色
    [self.borderColor setStroke];
    // 设置描边宽度
    path.lineWidth = 1.5;
    
    // 描边
    [path stroke];
    
}




@end
