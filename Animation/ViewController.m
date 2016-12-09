//
//  ViewController.m
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "ViewController.h"
#import "TXView.h"
#import "CoreAnimationViewController.h"


#define WIDTH  200
@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1
    [self testLayer];
    //2
//    [self drawLayer];
//    3
//    [self tuoZhan1];
//    4
//    [self tuoZhan2];
//    5
//    [self tuoZhan3];
//    6
//    [self customLayer];
    
}
/**
 使用自定义图层绘图
 */
-(void)customLayer
{
    TXView *view = [[TXView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
}
/**
 设置图层的content
 */
-(void)tuoZhan3
{
    //阴影图层
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.position = CGPointMake(150, 200);
    shadowLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    shadowLayer.backgroundColor = [UIColor blackColor].CGColor;
    shadowLayer.cornerRadius = 100 ;
    shadowLayer.shadowOffset = CGSizeMake(10, 10);
    shadowLayer.shadowOpacity = 1 ;
    [self.view.layer addSublayer:shadowLayer];
    
    //绘制图片图层
    CALayer *drawLayer = [[CALayer alloc]init];
    drawLayer.position = CGPointMake(150, 200);
    drawLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    drawLayer.cornerRadius = 100 ;
    drawLayer.masksToBounds = YES ;
    drawLayer.delegate = self ;
    [self.view.layer addSublayer:drawLayer];
    [drawLayer setNeedsDisplay];

    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    //不牵扯到绘图
    [drawLayer setContents:(id)image.CGImage];
    
    
}
/**
 图层的形变，绕X轴旋转180°
 */
-(void)tuoZhan2
{
    //阴影图层
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.position = CGPointMake(150, 200);
    shadowLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    shadowLayer.backgroundColor = [UIColor blackColor].CGColor;
    shadowLayer.cornerRadius = 100 ;
    shadowLayer.shadowOffset = CGSizeMake(10, 10);
    shadowLayer.shadowOpacity = 1 ;
    [self.view.layer addSublayer:shadowLayer];
    
    //绘制图片图层
    CALayer *drawLayer = [[CALayer alloc]init];
    drawLayer.position = CGPointMake(150, 200);
    drawLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    drawLayer.cornerRadius = 100 ;
    drawLayer.masksToBounds = YES ;
    drawLayer.delegate = self ;
    [self.view.layer addSublayer:drawLayer];
    [drawLayer setNeedsDisplay];
    
    //利用图形形变解决图像倒立问题，此时把代理方法-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx中的解决办法注释掉会发现可以实现同样的效果，事实上如果仅仅就显示一张图片在图层中没有必要那么麻烦，直接设置图层的contents就可以了，不牵扯到绘图，当然也就没有倒立的问题了。具体实现在方法-（void）tuoZhan3中。
    drawLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);

}
/**
 带阴影效果的圆形图片裁剪
 */
-(void)tuoZhan1
{
    //阴影图层
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.position = CGPointMake(150, 200);
    shadowLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    shadowLayer.backgroundColor = [UIColor blackColor].CGColor;
    shadowLayer.cornerRadius = 100 ;
    shadowLayer.shadowOffset = CGSizeMake(10, 10);
    shadowLayer.shadowOpacity = 1 ;
    [self.view.layer addSublayer:shadowLayer];
    
    //绘制图片图层
    CALayer *drawLayer = [[CALayer alloc]init];
    drawLayer.position = CGPointMake(150, 200);
    drawLayer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    drawLayer.cornerRadius = 100 ;
    drawLayer.masksToBounds = YES ;
    drawLayer.delegate = self ;
    [self.view.layer addSublayer:drawLayer];
    [drawLayer setNeedsDisplay];
}
/**
 使用layer的代理在layer上绘制一个图像并设置圆角
 */
-(void)drawLayer
{
    CALayer *layer = [[CALayer alloc]init];
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.position = CGPointMake(150, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = WIDTH/2 ;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正常显示，如果想要正确显示则必须设置masksToBounds=Yes,剪切子图层。
    //原因是：当绘制一张图片到图层上时会重新创建一个图层添加到当前图层，这样一来如果设置了圆角之后虽然底图层有圆角效果，但是子图层还是矩形，只有设置了masksToBounds让子图层按照底图层剪切才会显示圆角效应，同样的，UIImageView的layer设置圆角后也需要设置masksToBounds才会出现类似的效果。
    layer.masksToBounds = YES ;
    
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是裁剪外边框，而阴影刚好在外边框，所以这两个设置就出现了矛盾，解决思路是：使用两个大小一样的图层，下面的图层负责绘制阴影，上面的图层用来显示图片。具体在方法-(void)tuoZhan1实现。
//    layer.shadowColor = [UIColor grayColor].CGColor ;
//    layer.shadowOffset = CGSizeMake(10, 10);
//    layer.shadowOpacity = 1;
    
    layer.borderWidth = 5 ;
    layer.borderColor = [UIColor blackColor].CGColor;
    
    //设置图层代理
    layer.delegate = self ;
    
    [self.view.layer addSublayer:layer];
    
    //不调用此方法，代理方法不会被调用
    [layer setNeedsDisplay];
    
}
/**
 图层的代理方法，绘制图形、图像到图层

 @param layer 上面设置代理的layer
 @param ctx 图层的图形上下文，其中绘图位置也是相对于图层而言的
 */
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -WIDTH);
    /*
     使用CoreGraphics绘制图片时会倒立显示，上面对图层的上下文进行了反转，也可以直接让图层沿着x轴旋转180度达到效果，只需要设置图层的transform属性即可，但是transform是CATransform3D类型，形变可以在三个维度上进行，使用方法和前面介绍的二维形变是类似的，而且都有对应的形变设置方法（如：CATransform3DMakeTranslation()、CATransform3DMakeScale()、CATransform3DMakeRotation()），具体实现在方法-（void）tuoZhan2实现通过CATransform3DMakeRotation()方法在x轴旋转180度解决倒立问题；
     */
    
    
    UIImage *image=[UIImage imageNamed:@"1.jpg"];
    
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, WIDTH, WIDTH), image.CGImage);
    
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
}
/**
 测试layer，展示一个带阴影的layer，并在touchBegin方法中动画改编layer的bounds
 */
-(void)testLayer
{
    CGSize size = [UIScreen mainScreen].bounds.size ;
    
    CALayer *layer=[[CALayer alloc]init];
    //设置背景颜色,由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor=[UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position=CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds=CGRectMake(0, 0, WIDTH,WIDTH);
    //设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius=WIDTH/2;
    //设置阴影
    layer.shadowColor=[UIColor grayColor].CGColor;
    layer.shadowOffset=CGSizeMake(2, 2);
    layer.shadowOpacity=.9;
    //设置边框
    //    layer.borderColor=[UIColor whiteColor].CGColor;
    //    layer.borderWidth=1;
    
    //设置锚点
    //    layer.anchorPoint=CGPointZero;
    
    [self.view.layer addSublayer:layer];
    NSLog(@"%@",layer);
}

#pragma mark 点击放大
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CALayer *layer=self.view.layer.sublayers[2];
    NSLog(@"=%@=%@",layer,self.view.layer.sublayers);
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH/4;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;

}
- (IBAction)click:(UIButton *)sender {
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [[CoreAnimationViewController alloc]init];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}


@end
