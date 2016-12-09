//
//  ViewController.h
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//CALayer简介
//
//在介绍动画操作之前我们必须先来了解一个动画中常用的对象CALayer。CALayer包含在QuartzCore框架中，这是一个跨平台的框架，既可以用在iOS中又可以用在Mac OS X中。在使用Core Animation开发动画的本质就是将CALayer中的内容转化为位图从而供硬件操作，所以要熟练掌握动画操作必须先来熟悉CALayer。
//
//在上一篇文章中使用Quartz 2D绘图时大家其实已经用到了CALayer，当利用drawRect:方法绘图的本质就是绘制到了UIView的layer（属性）中，可是这个过程大家在上一节中根本体会不到。但是在Core Animation中我们操作更多的则不再是UIView而是直接面对CALayer。下图描绘了CALayer和UIView的关系，在UIView中有一个layer属性作为根图层，根图层上可以放其他子图层，在UIView中所有能够看到的内容都包含在layer中：
@end

