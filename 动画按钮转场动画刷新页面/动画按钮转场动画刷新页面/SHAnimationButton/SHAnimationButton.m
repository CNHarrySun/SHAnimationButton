//
//  SHAnimationButton.m
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import "SHAnimationButton.h"
#import "SHCircleAnimationView.h"

static NSTimeInterval startDuration = 0.3;
static NSTimeInterval endDuration = 0.5;

@interface SHAnimationButton ()

@property (nonatomic, strong) SHCircleAnimationView *circleView;

@property (nonatomic, assign) CGRect origionRect;

@end


@implementation SHAnimationButton

- (SHCircleAnimationView *)circleView{
    
    if (!_circleView) {
        
        _circleView = [SHCircleAnimationView viewWithButton:self];
        [self addSubview:_circleView];
    }
    
    return _circleView;
}

+ (instancetype)buttonWithFrame:(CGRect)frame{
    
    SHAnimationButton *button = [SHAnimationButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.cornerRadius = frame.size.height / 2;
    button.layer.masksToBounds = YES;
    // 不裁剪超出父视图的子视图部分
    button.clipsToBounds = NO;
    button.origionRect = button.frame;
    return button;
}

- (void)setborderColor:(UIColor *)color{
    
    self.layer.borderColor = color.CGColor;
}

- (void)setborderWidth:(CGFloat)width{
    
    self.layer.borderWidth = width;
}



- (void)startAnimation{
    
    CGPoint center = self.center;
    CGFloat width = self.layer.cornerRadius * 2;
    CGFloat height = self.frame.size.height;
    CGRect desFrame = CGRectMake(center.x - width / 2, center.y - height / 2, width, height);
    
    self.userInteractionEnabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(SHAnimationButtonDidStartAnimation:)]) {
        
        [self.delegate SHAnimationButtonDidStartAnimation:self];
    }
    
    [UIView animateWithDuration:startDuration animations:^{
        
        self.titleLabel.alpha = .0f;
        self.frame = desFrame;
    } completion:^(BOOL finished) {
       
        [self.circleView startAnimation];
    }];
}

- (void)stopAnimation{
    
    self.userInteractionEnabled = YES;
    
    if ([self.delegate respondsToSelector:@selector(SHAnimationButtonWillFinishAnimation:)]) {
        
        [self.delegate SHAnimationButtonWillFinishAnimation:self];
    }
    
    [self.circleView removeFromSuperview];
    self.circleView = nil;
    
    [UIView animateWithDuration:endDuration animations:^{
        
        self.frame = self.origionRect;
        self.titleLabel.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(SHAnimationButtonDidFinishAnimation:)]) {
            
            [self.delegate SHAnimationButtonDidFinishAnimation:self];
        }
    }];
    
}







@end
