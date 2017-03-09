//
//  SHAnimationButton.h
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHAnimationButton;

@protocol SHAnimationButtonDelegate <NSObject>


/**
 动画开始

 @param SHAnimationButton SHAnimationButton
 */
- (void)SHAnimationButtonDidStartAnimation:(SHAnimationButton *)SHAnimationButton;


/**
 动画将要接结束
 
 @param SHAnimationButton SHAnimationButton
 */
- (void)SHAnimationButtonWillFinishAnimation:(SHAnimationButton *)SHAnimationButton;


/**
 动画已经结束

 @param SHAnimationButton SHAnimationButton
 */
- (void)SHAnimationButtonDidFinishAnimation:(SHAnimationButton *)SHAnimationButton;

@end



@interface SHAnimationButton : UIButton

/**
 代理对象
 */
@property (nonatomic, weak) id<SHAnimationButtonDelegate> delegate;


/**
 创建对象

 @param frame frame
 @return 对象
 */
+ (instancetype)buttonWithFrame:(CGRect)frame;


/**
 边缘颜色

 @param color color
 */
- (void)setborderColor:(UIColor *)color;



/**
 边缘宽度

 @param width width
 */
- (void)setborderWidth:(CGFloat)width;



/**
 手动执行开始动画（一般在button的响应里调用，调用后会走代理进行回调）
 */
- (void)startAnimation;


/**
 手动停止动画（停止前和停止后会走代理回调）
 */
- (void)stopAnimation;

@end
