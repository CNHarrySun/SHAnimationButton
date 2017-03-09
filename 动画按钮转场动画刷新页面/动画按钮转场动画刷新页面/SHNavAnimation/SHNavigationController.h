//
//  SHNavigationController.h
//  动画按钮转场动画刷新页面
//
//  Created by HarrySun on 2017/3/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController withCenterButton:(UIButton*)button;

@end
