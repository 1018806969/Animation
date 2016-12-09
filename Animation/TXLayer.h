//
//  TXLayer.h
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface TXLayer : CALayer
//在自定义图层中绘图时只要自己编写一个类继承于CALayer然后在drawInContext:中绘图即可。同前面在代理方法绘图一样，要显示图层中绘制的内容也要调用图层的setNeedDisplay方法，否则drawInContext方法将不会调用。
//
//前面的文章中曾经说过，在使用Quartz 2D在UIView中绘制图形的本质也是绘制到图层中，为了说明这个问题下面演示自定义图层绘图时没有直接在视图控制器中调用自定义图层，而是在一个UIView将自定义图层添加到UIView的根图层中（例子中的UIView跟自定义图层绘图没有直接关系）。从下面的代码中可以看到：UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文），同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法并将图形上下文作为参数传递给这个方法。而在UIView的draw:inContext:方法中会调用其drawRect:方法，在drawRect:方法中使用UIGraphicsGetCurrentContext()方法得到的上下文正是前面创建的上下文。
@end
