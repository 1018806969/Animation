//
//  CoreAnimationViewController.m
//  Animation
//
//  Created by txx on 16/12/8.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "CoreAnimationViewController.h"

#define IMAGE_COUNT 5

@interface CoreAnimationViewController ()<CAAnimationDelegate>
{
    CALayer *_layer ;
    UIImageView  *_imageView;
    int _currentIndex;
    
    int _index;
    NSMutableArray *_images;
}

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self aSimpleAnimation];
    
//    [self basicAnimation1];
    
//    [self animation2];
    
//    [self animationPauseAndResume];
    
    
//    [self keyFrameAniamtion];
    
//    [self groupAnimation];
    
//    [self transitionAnimation];
    
    
//    [self zhuZhenAnimation];
    
//    [self tanHuangDongHua];
    
//    [self keyFrameBox];
    
//    [self transrtionBox];
    
}
/**
 UIView封装的转场动画
 */
-(void)transrtionBox
{
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
    
    [UIView transitionWithView:_imageView duration:1.0 options:options animations:^{
        _imageView.image=[self getImage:YES];
    } completion:nil];

}
/**
 UIView封装的关键帧动画
 */
-(void)keyFrameBox
{
    //创建图像显示控件
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    _imageView.frame = CGRectMake(40, 40, 50, 50);
    _imageView.layer.cornerRadius = 25;
    _imageView.clipsToBounds = YES ;
    _imageView.center=CGPointMake(160, 50);
    [self.view addSubview:_imageView];

    [UIView animateKeyframesWithDuration:5.0 delay:0 options: UIViewAnimationOptionCurveLinear| UIViewAnimationOptionCurveLinear animations:^{
        //第二个关键帧（准确的说第一个关键帧是开始位置）:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            _imageView.center=CGPointMake(80.0, 220.0);
        }];
        //第三个关键帧，从0.5*5.0秒开始，持续5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(45.0, 300.0);
        }];
        //第四个关键帧：从0.75*5.0秒开始，持所需5.0*0.25=1.25秒
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            _imageView.center=CGPointMake(55.0, 400.0);
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"Animation end.");
    }];
}
/**
 UIView封装的弹簧动画
 */
-(void)tanHuangDongHua
{
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    _imageView.frame = CGRectMake(40, 40, 50, 50);
    _imageView.layer.cornerRadius = 25;
    _imageView.clipsToBounds = YES ;
    _imageView.center=CGPointMake(160, 50);
    [self.view addSubview:_imageView];
    
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center=CGPointMake(300, 500);
    } completion:nil];
}
/**
 逐帧动画
 */
-(void)zhuZhenAnimation
{
    
    //创建图像显示图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 87, 32);
    _layer.position=CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    
    //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
    //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
    _images=[NSMutableArray array];
    for (int i=0; i<5; ++i) {
        NSString *imageName=[NSString stringWithFormat:@"%i.jpg",i];
        UIImage *image=[UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    
    //定义时钟对象
    CADisplayLink *displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //添加时钟对象到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
#pragma mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
-(void)step{
    //定义一个变量记录执行次数
    static int s=0;
    //每秒执行6次
    if (++s%10==0) {
        UIImage *image=_images[_index];
        _layer.contents=(id)image.CGImage;//更新图片
        _index=(_index+1)%IMAGE_COUNT;
    }
}
/**
 转场动画
 */
-(void)transitionAnimation
{
//    转场动画就是从一个场景以动画的形式过渡到另一个场景。转场动画的使用一般分为以下几个步骤：
//    
//    1.创建转场动画
//    
//    2.设置转场类型、子类型（可选）及其他属性
//    
//    3.设置转场后的新视图并添加动画到图层
    
    //定义图片控件
    _imageView=[[UIImageView alloc]init];
    _imageView.frame=[UIScreen mainScreen].bounds;
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"0.jpg"];//默认图片
    [self.view addSubview:_imageView];
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];

}
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}
-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
//    transition.type=@"cube";
//    transition.type = @"rippleEffect";
//    transition.type = @"oglFlip";
//    transition.type = @"suckEffect";
//    transition.type = @"pageCurl";
//    transition.type = @"pageUnCurl";
//    transition.type = @"cameralIrisHollowOpen";
    transition.type = @"cameraIrisHollowClose";

    
    //设置子类型
    if (isNext) {
        transition.subtype=kCATransitionFromRight;
    }else{
        transition.subtype=kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration=1.0f;
    
    //3.设置转场后的新视图添加转场动画
    _imageView.image=[self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",_currentIndex];
    return [UIImage imageNamed:imageName];
}
/**
 动画组
 */
-(void)groupAnimation
{
//    动画组使用起来并不复杂，首先单独创建单个动画（可以是基础动画也可以是关键帧动画），然后将基础动画添加到动画组，最后将动画组添加到图层即可。
    
    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 10, 20);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //1.创建动画组
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
    
    //关键帧动画
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint endPoint= CGPointMake(55, 400);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    keyframeAnimation.path=path;
    CGPathRelease(path);
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    
    //基础动画
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CGFloat toValue=M_PI_2*3;
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    //    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;
    basicAnimation.repeatCount=HUGE_VALF;
    basicAnimation.removedOnCompletion=NO;
    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    
    //添加动画到动画组
    animationGroup.animations=@[basicAnimation,keyframeAnimation];
    
    //2.设置组中的动画和其他属性
    animationGroup.delegate=self;
    animationGroup.duration=10.0;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime=CACurrentMediaTime()+5;//延迟五秒执行
    
    //3.给图层添加动画
    [_layer addAnimation:animationGroup forKey:nil];
}
/**
 关键帧动画
 */
-(void)keyFrameAniamtion
{
    //关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 10, 20);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //方式1
    [self valueControlAniamtion];
    
    //上面的动画发现不平滑，可以采用方式2，利用贝塞尔曲线做平滑动画
    [self beiSaErAniamtion];
    
}
-(void)beiSaErAniamtion
{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    keyframeAnimation.path=path;//设置path属性
    CGPathRelease(path);//释放路径对象
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+5;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}
/**
 方式1、通过设置不同的属性值进行关键帧控制
 */
-(void)valueControlAniamtion
{
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1=[NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values=@[key1,key2,key3,key4];
    keyframeAnimation.values=values;
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}
/**
 动画的暂停和恢复
 */
-(void)animationPauseAndResume
{
    _layer = [[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 100);
    _layer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    
    CABasicAnimation *basicRotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicRotationAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    basicRotationAnimation.duration=6.0;
    basicRotationAnimation.autoreverses=true;//旋转后再旋转到原来的位置
    basicRotationAnimation.repeatCount = HUGE_VALF ;
    [_layer addAnimation:basicRotationAnimation forKey:@"basicAnimation_Rotation"];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:point];
    basicAnimation.duration = 4 ;
    basicAnimation.delegate = self ;
    //存储结束位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:point] forKey:@"animationEndLocation"];
    [_layer addAnimation:basicAnimation forKey:@"basicAnimation1"];
    
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation= [_layer animationForKey:@"KCBasicAnimation_Translation"];
    if(animation){
        if (_layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        basicAnimation.toValue = [NSValue valueWithCGPoint:point];
        basicAnimation.duration = 4 ;
        basicAnimation.delegate = self ;
        //存储结束位置在动画结束后使用
        [basicAnimation setValue:[NSValue valueWithCGPoint:point] forKey:@"animationEndLocation"];
        [_layer addAnimation:basicAnimation forKey:@"basicAnimation1"];
        
        CABasicAnimation *basicRotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
        basicRotationAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
        basicRotationAnimation.duration=6.0;
        basicRotationAnimation.autoreverses=true;//旋转后再旋转到原来的位置
        basicRotationAnimation.repeatCount = HUGE_VALF ;
        [_layer addAnimation:basicRotationAnimation forKey:@"basicAnimation_Rotation"];
    }

}
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval=[_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()- _layer.timeOffset;
    //设置偏移量
    _layer.timeOffset=0;
    //设置开始时间
    _layer.beginTime=beginTime;
    //设置动画速度，开始运动
    _layer.speed=1.0;
}

/**
 同时平移和旋转
 */
-(void)animation2
{
    _layer = [[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 100);
    _layer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    basicAnimation.duration = 4 ;
    basicAnimation.delegate = self ;
    //存储结束位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(300, 400)] forKey:@"animationEndLocation"];
    [_layer addAnimation:basicAnimation forKey:@"basicAnimation1"];

    CABasicAnimation *basicRotationAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicRotationAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    basicRotationAnimation.duration=6.0;
    basicRotationAnimation.autoreverses=true;//旋转后再旋转到原来的位置
    [_layer addAnimation:basicRotationAnimation forKey:@"basicAnimation_Rotation"];
    
    
//    代码中结合两种动画操作，需要注意的是只给移动动画设置了代理，在旋转动画中并没有设置代理，否则代理方法会执行两遍。由于旋转动画会无限循环执行（上面设置了重复次数无穷大），并且两个动画的执行时间没有必然的关系，这样一来移动停止后可能还在旋转，为了让移动动画停止后旋转动画停止就需要使用到动画的暂停和恢复方法。
//    
//    核心动画的运行有一个媒体时间的概念，假设将一个旋转动画设置旋转一周用时60秒的话，那么当动画旋转90度后媒体时间就是15秒。如果此时要将动画暂停只需要让媒体时间偏移量设置为15秒即可，并把动画运行速度设置为0使其停止运动。类似的，如果又过了60秒后需要恢复动画（此时媒体时间为75秒），这时只要将动画开始开始时间设置为当前媒体时间75秒减去暂停时的时间（也就是之前定格动画时的偏移量）15秒（开始时间=75-15=60秒），那么动画就会重新计算60秒后的状态再开始运行，与此同时将偏移量重新设置为0并且把运行速度设置1。这个过程中真正起到暂停动画和恢复动画的其实是动画速度的调整，媒体时间偏移量以及恢复时的开始时间设置主要为了让动画更加连贯。
//    
//    -（void）animationPauseAndResume演示了移动动画结束后旋转动画暂停，并且当再次点击动画时旋转恢复的过程(注意在移动过程中如果再次点击屏幕可以暂停移动和旋转动画，再次点击可以恢复两种动画。但是当移动结束后触发了移动动画的完成事件如果再次点击屏幕则只能恢复旋转动画，因为此时移动动画已经结束而不是暂停，无法再恢复)。
    

}
/**
 动画结束后使用事务保留在终点位置
 */
-(void)basicAnimation1
{
    _layer = [[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 100);
    _layer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    basicAnimation.duration = 4 ;
    basicAnimation.delegate = self ;
    //存储结束位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(300, 400)] forKey:@"animationEndLocation"];
    [_layer addAnimation:basicAnimation forKey:@"basicAnimation1"];
}
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    
    //通过前面的设置的key获得动画
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//    _layer.position=[[anim valueForKey:@"animationEndLocation"] CGPointValue];
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    
    //    如果运行代码大家可能会发现另外一个问题，那就是动画运行完成后会重新从起始点运动到终点。这个问题产生的原因就是前面提到的，对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）会产生动画效果。解决这个问题有两种办法：关闭图层隐式动画、设置动画图层为根图层。显然这里不能采取后者，因为根图层当前已经作为动画的背景。
//    要关闭隐式动画需要用到动画事务CATransaction，在事务内将隐式动画关闭，例如上面的代码可以改为：

    //开启事务
    [CATransaction begin];
    
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    _layer.position=[[anim valueForKey:@"animationEndLocation"] CGPointValue];
    //提交事务
    [CATransaction commit];
    


}/**
 基础动画，动画结束图层回到原始位置
 */
-(void)basicAnimation
{
//    在开发过程中很多情况下通过基础动画就可以满足开发需求，前面例子中使用的UIView代码块进行图像放大缩小的演示动画也是基础动画（在iOS7中UIView也对关键帧动画进行了封装），只是UIView装饰方法隐藏了更多的细节。如果不使用UIView封装的方法，动画创建一般分为以下几步：
//    
//    1.初始化动画并设置动画属性
//    
//    2.设置动画属性初始值（可以省略）、结束值以及其他动画属性
//    
//    3.给图层添加动画
    
    //自定义一个图层
    _layer = [[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 100);
    _layer.contents = (id)[UIImage imageNamed:@"1.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画初始值和结束值，初始值可以不设置，默认为图层的初识状态，动画结束后默认回到初识状态位置而不是初识值，那么如何让动画结束后图层停留在结束的位置呢？前面说过图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果，其实图层本身并没有任何的变化。上面的动画中图层并没有因为动画效果而改变它的位置（对于缩放动画其大小也是不会改变的），所以动画完成之后图层还是在原来的显示位置没有任何变化，如果这个图层在一个UIView中你会发现在UIView移动过程中你要触发UIView的点击事件也只能点击原来的位置（即使它已经运动到了别的位置），因为它的位置从来没有变过。当然解决这个问题方法比较多，这里不妨在动画完成之后重新设置它的位置。具体实现在方法-（void）basicAnimation1；
//        basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(300, 0)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    
    basicAnimation.duration = 5 ;
    
    //设置重复次数，HUGE_VALF可看做无穷大，起到循环动画的效果
    basicAnimation.repeatCount = HUGE_VALF;
    
    //完成动画是否移除
//    basicAnimation.removedOnCompletion = YES ;
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"basicAnimation_Layer"];
    

}
/**
 使用UIview的快代码实现一个简单的动画效果，动画改编imageView的frame
 */
-(void)aSimpleAnimation
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    imageView.frame=CGRectMake(120, 140, 80, 80);
    [self.view addSubview:imageView];
    
    //使用UIView封装的方法固然方便简单，但是具体动画的实现我们是不清楚的，而且有一些问题是无法解决的，比如：如何控制动画的暂停、如何进行组合动画等，这就是需要解决核心动画Core Animation包含在Quartz Core框架中
    [UIView animateWithDuration:3 animations:^{
        imageView.frame = CGRectMake(80, 100, 160, 160);
    }completion:^(BOOL finished) {
        imageView.frame=CGRectMake(120, 140, 80, 80);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
