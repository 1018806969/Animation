//
//  CoreAnimationViewController.h
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreAnimationViewController : UIViewController

//CAAnimation：核心动画的基础类，不能直接使用，负责动画运行时间、速度的控制，本身实现了CAMediaTiming协议。
//
//CAPropertyAnimation：属性动画的基类（通过属性进行动画设置，注意是可动画属性），不能直接使用。
//
//CAAnimationGroup：动画组，动画组是一种组合模式设计，可以通过动画组来进行所有动画行为的统一控制，组中所有动画效果可以并发执行。
//
//CATransition：转场动画，主要通过滤镜进行动画效果设置。
//
//CABasicAnimation：基础动画，通过属性修改进行动画参数控制，只有初始状态和结束状态。
//
//CAKeyframeAnimation：关键帧动画，同样是通过属性进行动画参数控制，但是同基础动画不同的是它可以有多个状态控制。
//
//基础动画、关键帧动画都属于属性动画，就是通过修改属性值产生动画效果，开发人员只需要设置初始值和结束值，中间的过程动画（又叫“补间动画”）由系统自动计算产生。和基础动画不同的是关键帧动画可以设置多个属性值，每两个属性中间的补间动画由系统自动完成，因此从这个角度而言基础动画又可以看成是有两个关键帧的关键帧动画。
@end
