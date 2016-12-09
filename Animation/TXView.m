//
//  TXView.m
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXView.h"
#import "TXLayer.h"

@implementation TXView

-(instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initwithframe");
    self = [super initWithFrame:frame];
    if (self) {
        TXLayer *layer = [[TXLayer alloc]init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(160, 284);
        layer.backgroundColor = [UIColor redColor].CGColor;
        
        //同前面在代理方法绘制一样，要显示图层中绘制的内容也要调用图层的setNeedsDisplay方法，否则，drawInContext方法将不会调用
        [layer setNeedsDisplay];
        [self.layer addSublayer:layer];
    }
    return self ;
}

-(void)drawRect:(CGRect)rect
{
    NSLog(@"2-drawRect:");
    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
}
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"1-drawLayer:inContext:");
    NSLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
    
}
@end
