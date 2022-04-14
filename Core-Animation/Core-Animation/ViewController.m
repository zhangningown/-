//
//  ViewController.m
//  Test
//
//  Created by 张宁 on 2021/1/29.
//

#import "ViewController.h"
#import "BlueView.h"
#import "LayerLabel.h"
#import "ReflectionView.h"
#import "ZnButton.h"


@interface ViewController ()
@property (nonatomic, strong)UIView *redView;
@property (nonatomic,strong)CALayer *layer;

@property (nonatomic,strong)UIView *view1;
@property (nonatomic,strong)UIView *view2;


@property (nonatomic, strong)BlueView *layerView;
@property (nonatomic,strong)CALayer *blueLayer;
@property (nonatomic,strong)CALayer *redLayer;


@property(nonatomic,strong)UIImageView *layerView0;
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UIImageView *layerView1;
@property(nonatomic,strong)UIImageView *layerView2;


@property(nonatomic,strong)UIView *outerView;
@property(nonatomic,strong)UIView *innerView;

@property(nonatomic,strong)CAEmitterLayer *colorBallLayer;
@property(nonatomic,strong)NSMutableArray *viewList;


@property(nonatomic,strong)CAEmitterLayer *rainLayer;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self createSimapleAnimation];
    
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
//    [self test7];
//    [self test8];
//    [self test9];
//    [self test10];
//    [self test11];
//    [self test12];
    [self test13];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - QQ点赞功能
-(void)test13{
    
    ZnButton *btn = [ZnButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, 100, 30, 30);
    
    
    [btn setImage:[UIImage imageNamed:@"un点赞"] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateSelected];
    
    btn.center = self.view.center;
    
    [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

    //按钮先放大 CAKeyFrameAnimation
    
    //发达之后一个圈粒子特效  CAEmitterLayer
    
    
}

-(void)btnSelect:(UIButton *)sender{
    
    if (sender.isSelected) {
        
        NSLog(@"取消点赞");
        
    }else{
        
        
        NSLog(@"点赞");
        
    }
    
    [sender setSelected:!sender.isSelected];
    
    
    
}

#pragma mark - 粒子效果 下雨
-(void)test12{
    
    
    UIImage *image = [UIImage imageNamed:@"ecfab1b7449dff80a6c3483006304a7e.jpeg"];
    
    self.view.layer.contents = (__bridge id)image.CGImage;
    //设置裁剪方式
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
    //设置retain屏
    self.view.layer.contentsScale = [[UIScreen mainScreen] scale];
    
    
    NSArray *buttonName = @[@"下大点",@"下小点",@"雨停了"];
    
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*80+ (i+1)*10, [UIScreen mainScreen].bounds.size.height - 50, 80, 40)];
        btn.tag = i * 100;
        [btn setTitle:buttonName[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = UIColor.brownColor;
        [self.view addSubview:btn];
        
    }
    
    //粒子发射源
    CAEmitterLayer *rainLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:rainLayer];
    self.rainLayer = rainLayer;
    
    //粒子发射属性
    rainLayer.emitterShape = kCAEmitterLayerLine;
    rainLayer.emitterMode = kCAEmitterLayerSurface;
    rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);
    rainLayer.emitterSize = self.view.frame.size;
    
    //设置cell
    CAEmitterCell *rainLayerCell = [CAEmitterCell emitterCell];
    rainLayerCell.contents = (__bridge id)[UIImage imageNamed:@"水滴"].CGImage;
    rainLayerCell.birthRate = 25.0f;
    rainLayerCell.lifetime = 20.0f;
    rainLayerCell.speed = 10.0f;
    rainLayerCell.velocity = 10.0f;
    rainLayerCell.yAcceleration = 1000.0f;
    rainLayerCell.scale = 0.1;
    rainLayerCell.scaleRange = 0.0f;
    rainLayer.emitterCells = @[rainLayerCell];
    
    
    
    
    
}


-(void)buttonClick:(UIButton *)sender{
    
    NSInteger rate = 1;
    CGFloat scale = 0.05;
    
    switch (sender.tag) {
        case 0:
            NSLog(@"下大点");
            if (self.rainLayer.birthRate < 30) {
                
                [self.rainLayer setValue:@(self.rainLayer.birthRate + rate) forKey:@"birthRate"];
                
                [self.rainLayer setValue:@(self.rainLayer.scale + scale) forKey:@"scale"];
                
            }
            break;
        case 100:
            NSLog(@"下小点");
            if (self.rainLayer.birthRate > 1) {
                
                [self.rainLayer setValue:@(self.rainLayer.birthRate - rate) forKey:@"birthRate"];
                
                [self.rainLayer setValue:@(self.rainLayer.scale - scale) forKey:@"scale"];
                
            }
            break;
        case 200:
            NSLog(@"雨停了");
            [self.rainLayer setValue:@(0) forKey:@"birthRate"];
            
            break;
        default:
            break;
    }
    
    
    
}



#pragma mark - 粒子效果
-(void)test11{
    
    
    
    self.view.backgroundColor = UIColor.blackColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    
    [self.view addSubview:label];
    
    label.textColor = UIColor.whiteColor;
    
    label.text = @"轻点或拖动来改变发射源位置";
    
    label.textAlignment = NSTextAlignmentCenter;
    

    
    
    /*
     CAEmitterLayer::粒子图层
     CAEmitterCell 发射粒子
     
     CAEmitterLayer:
     *emitterPosition:决定发射的中心点
     *emitterShap:粒子发射形状
        kCAEmitterLayerPoint --点形状
        kCAEmitterLayerLine --线形状
        kACEmitterLayerRectangle -- 矩阵形状
        kCAEmitterLayerCubiid --立体矩阵块
        kCAE蜜桃特然LayerCircle -- 圆形
        kCAEmitterLayerSphere -- 立体圆形（3D）
     *emitterMode:发射模式
        kCAEmitterLayerPoints --点模式
        kCAEmitterLayerOutLine -- 轮廓模式
        kCAEmitterLayerSurface -- 表面模式
        kCAEmitterLayerVolume  -- 3D发射模式
     */
    
    
    
    //发射类
    CAEmitterLayer *colorBallLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:colorBallLayer];
    
    self.colorBallLayer = colorBallLayer;
    
    colorBallLayer.emitterSize = self.view.frame.size;
    
    colorBallLayer.emitterShape = kCAEmitterLayerPoint;
    
    colorBallLayer.emitterMode = kCAEmitterLayerPoints;
    
    colorBallLayer.emitterPosition = CGPointMake(self.view.layer.bounds.size.width, 0);
    
    CAEmitterCell *colorBallCell = [CAEmitterCell emitterCell];
    
    colorBallCell.name = @"ccCell";
    
    colorBallCell.birthRate = 20.0f;
    
    colorBallCell.lifetime = 10.0f;
    
    colorBallCell.velocity = 40.0f;
    
    colorBallCell.velocityRange = 100.0;
    colorBallCell.yAcceleration = 15.0f;
    
    colorBallCell.emissionLatitude = M_PI;
    colorBallCell.emissionRange = M_PI_4;
    
    colorBallCell.scale = 0.2;
    
    colorBallCell.scaleRange = 0.5;
    
    colorBallCell.scaleSpeed = 0.02;
    
    
    colorBallCell.contents = (__bridge id)[UIImage imageNamed:@"雪花"].CGImage;
    
    //颜色变化
    colorBallCell.color = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1].CGColor;
    
    
    colorBallCell.alphaRange = 0.8;
    
    colorBallCell.redRange = 1.0;
    colorBallCell.greenRange = 1.0;
    colorBallCell.blueRange = 1.0;
    
    colorBallCell.blueSpeed = 1.0f;
    colorBallCell.alphaSpeed = -0.1;
    
    
    colorBallLayer.emitterCells = @[colorBallCell];
    
    
}

const CGFloat kReflectPercent = 0.5;
const CGFloat kReflectOpacity = 0.3f;
const CGFloat kReflectDistance = 2.0f;

#pragma mark - 镜像
-(void)test10{
    
    self.view.backgroundColor = UIColor.grayColor;
    
    UIImage *image = [UIImage imageNamed:@"ecfab1b7449dff80a6c3483006304a7e.jpeg"];
    
//    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
//
//    CALayer *redSquare = [CALayer layer];
//
//    redSquare.backgroundColor = UIColor.whiteColor.CGColor;
//    redSquare.frame = CGRectMake(0, 0, 200, 200 * image.size.height/image.size.width);
//
//
//    redSquare.contents = (__bridge id)(image.CGImage);
//
//    replicatorLayer.instanceCount = 2;
//
//
//    CATransform3D transform = CATransform3DIdentity;

//    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
//
//
//
//    transform = CATransform3DScale(transform, 1, 0.5, 0);
//
//    transform = CATransform3DTranslate(transform, 0,  -(200 * image.size.height/image.size.width + 2)*3, 0);
//
//
//    replicatorLayer.instanceTransform = transform;
//
//    replicatorLayer.instanceAlphaOffset = -0.7;
//
//    [replicatorLayer addSublayer:redSquare];
//
//    [self.view.layer addSublayer:replicatorLayer];
    
    
    
    ReflectionView *t_view = [[ReflectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100 * image.size.height/image.size.width)];

    
    [self.view addSubview:t_view];
    
    
    
}


#pragma mark - 渐变
-(void)test9{
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(10, 50, self.view.frame.size.width - 20, 100);
    
    gradientLayer.colors = @[(__bridge  id)[UIColor redColor].CGColor,(__bridge  id)[UIColor greenColor].CGColor,(__bridge  id)[UIColor blueColor].CGColor];
    
    
    gradientLayer.locations = @[@0.25,@0.5,@0.25];
    
    
    gradientLayer.startPoint = CGPointMake(0, 0);

    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
    
    [self.view.layer addSublayer:gradientLayer];
    
    
    
    
}
#pragma mark - 3d图形
-(void)test8{
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    self.containerView.backgroundColor = UIColor.blackColor;
    
    [self.view addSubview:_containerView];
    
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0/500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cub2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cub2];
    
    
    
}
#pragma mark - 3d图形
-(CALayer *)faceWithTransForm:(CATransform3D)transform{
    
    CALayer *face = [CALayer layer];
//    face.frame = CGRectMake(-50, -50, 100, 100);
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    face.backgroundColor = [UIColor colorWithRed:rand()/(double)INT_MAX green:rand()/(double)INT_MAX blue:rand()/(double)INT_MAX alpha:1].CGColor;
    
   
    face.transform = transform;
    
    return face;
}
#pragma mark - 3d图形
-(CALayer *)cubeWithTransform:(CATransform3D)transform{
    
    CATransformLayer *cube = [CATransformLayer layer];
    
    //1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransForm:ct]];
    
    //2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransForm:ct]];

    //3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransForm:ct]];
    
    //4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransForm:ct]];
    
    //5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransForm:ct]];
    
    //6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransForm:ct]];
    
    
    CGSize containerSize = self.containerView.bounds.size;
    
    cube.position = CGPointMake(containerSize.width/2, containerSize.height/2);
    
    cube.transform = transform;
    
    return cube;

}


#pragma mark - textLayer 实现textlabel效果
-(void)test7{
    
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 40);
    [self.view.layer addSublayer:textLayer];
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
     
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    //环绕方式
    textLayer.wrapped = YES;
    
    //选择字体
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    
    CGFontRef fonRef = CGFontCreateWithFontName(fontName);
    
    textLayer.font = fonRef;
    
    textLayer.fontSize = font.pointSize;
    
    CGFontRelease(fonRef);
    
    
    NSString *text = @"Hello ,World";
    
    //文本像素画的原因，没有retina 渲染，默认等于 1，需要传合适的值
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    textLayer.string = text;
    
    
    LayerLabel *textLayerLabel = [[LayerLabel alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width - 20, 200)];
    
    textLayerLabel.text = @"12321321";
    
    [self.view addSubview:textLayerLabel];
    
    
}

#pragma mark - 贝塞尔实现圆角
-(void)test6{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corner1 = UIRectCornerBottomRight | UIRectCornerBottomLeft;
    UIRectCorner corner2 = UIRectCornerTopLeft | UIRectCornerTopRight;
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner2 cornerRadii:radii];
    
    
    
    
    
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    //画笔颜色
    shaperLayer.strokeColor = [UIColor redColor].CGColor;
    //填充颜色
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    //线宽
    shaperLayer.lineWidth = 5;
    //链接方式
    shaperLayer.lineJoin = kCALineJoinRound;
    shaperLayer.lineCap =  kCALineCapRound;
    
//    shaperLayer.path = path.CGPath;
    shaperLayer.path = path2.CGPath;
    
    [self.view.layer addSublayer:shaperLayer];
    
    
    
}

#pragma mark - 实现一个3d格子
-(void)test5{
    
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2/3)];
    
    _containerView.backgroundColor = UIColor.grayColor;
    
    
    [self.view addSubview:_containerView];
    
    
    _viewList = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < 6; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        
        view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        label.text = [NSString stringWithFormat:@"%d",i];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:30];
        
        [view addSubview:label];
        
        label.center = view.center;
        
        [_viewList addObject:view];
        
    }
    
    CATransform3D perspective = CATransform3DIdentity;
    
    perspective.m34 = -1.0/500.0;
    
    
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
//
//
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    
    self.containerView.layer.sublayerTransform = perspective;
    
    //1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    
    //2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    //3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    //4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    //5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    //6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    
    
    
}
#pragma mark - 3d盒子
-(void)addFace:(NSInteger)index withTransform:(CATransform3D)transForm{
    
    UIView *face = self.viewList[index];
    
    [self.containerView addSubview:face];
    
    
    CGSize containerSize = self.containerView.bounds.size;
    
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height/2);
    
    face.layer.transform = transForm;
    
    
    
    
    
}


#pragma mark - 实现矩形包矩形
-(void)test4{
    
    _outerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _outerView.backgroundColor = UIColor.blueColor;
    
    
    
    
    _innerView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    _innerView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:_outerView];
    [self.outerView addSubview:_innerView];
    self.outerView.center = self.view.center;
    
    
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0/500.0;
    outer =  CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.outerView.layer.transform = outer;
    
    
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0/500.0;
    inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.innerView.layer.transform = inner;
    
    
}
#pragma mark - 图片旋转 以及透视效果
-(void)test3{
    
    UIImage *image = [UIImage imageNamed:@"ecfab1b7449dff80a6c3483006304a7e.jpeg"];
//
//
    _layerView0 = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 20 - 200) / 2, 0, 200, 200 * image.size.height/image.size.width)];


    _layerView0.image = image;

//    _layerView0.center = CGPointMake(self.view.center.x, self.view.center.y);


    [self.view addSubview:_layerView0];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        //知识点1
//        CATransform3D transForm = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
        CATransform3D transForm = CATransform3DIdentity;


        //正投影 透视投影 m34只是修改投影方式
        transForm.m34 = -1.0/500.0;
        transForm = CATransform3DRotate(transForm, M_PI, 0, 1, 0);

        //正背面渲染--》渲染技术正面剔除 ，判断用户是否可见
//        self.layerView0.layer.doubleSided = NO;
        
        self.layerView0.layer.transform = transForm;
        
        


    });
    
    //知识点2
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 200 * image.size.height/image.size.width, [UIScreen mainScreen].bounds.size.width - 20, (100 * image.size.height/image.size.width) + 50)];
    
    _containerView.backgroundColor = UIColor.yellowColor;
    
    
    _layerView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100 * image.size.height/image.size.width)];
    
    _layerView1.image = image;
    
    _layerView2 = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30 - 100, 10, 100, 100 * image.size.height/image.size.width)];
    
    _layerView2.image = image;
    
    [_containerView addSubview:_layerView1];
    [_containerView addSubview:_layerView2];
    
    [self.view addSubview:_containerView];
    
    
    
    CATransform3D perspective = CATransform3DIdentity;
    
    perspective.m34 = -1.0/500.0;
    
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transForm2 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    CATransform3D transForm3 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    
    self.layerView1.layer.transform = transForm2;
    self.layerView2.layer.transform = transForm3;
    
}

#pragma mark - 图像点击效果
-(void)test2{
    
    self.redLayer = [CALayer layer];
    
    self.redLayer.frame = CGRectMake(0, 0, 200, 200);
    
    self.redLayer.backgroundColor = UIColor.redColor.CGColor;
    
    
    
    
    self.blueLayer = [CALayer layer];
    self.blueLayer.backgroundColor = UIColor.blueColor.CGColor;
    
    self.blueLayer.frame = CGRectMake(0, 0, 100, 100);
    
    self.layerView = [[BlueView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];

    
    [self.layerView.layer addSublayer:self.redLayer];
    
    [self.layerView.layer addSublayer:self.blueLayer];


    [self.view addSubview:self.layerView];
    
    
    /*
     
     
     -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
         
         CGPoint point = [[touches anyObject] locationInView:self.view];
         
         CALayer *layer = [self.layerView.layer hitTest:point];
         
         if (layer == self.blueLayer) {
             
             NSLog(@"inside blue layer");
             
         }else if (layer == self.redLayer){
             
             NSLog(@"inside red layer");
             
         }else{
             
             NSLog(@"outside layer");
         }
         

     }

     
     
     */
    
    
    
    
    
}


#pragma mark - 背景图像
-(void)test1{
    
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _view1.backgroundColor = UIColor.orangeColor;
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    _view2.backgroundColor = UIColor.redColor;
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    
    
    UIImage *image = [UIImage imageNamed:@"65d8143bd5393aaf1cbe117f0e00425f.jpeg"];
    
    self.view.layer.contents = (__bridge id)image.CGImage;
    //设置裁剪方式
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
    //设置retain屏
    self.view.layer.contentsScale = [[UIScreen mainScreen] scale];
    
    //深度值
    self.view1.layer.zPosition = 1.0;
    
    
    
    
//    CALayer *t_layer = [CALayer layer];
//
//    t_layer.frame = CGRectMake(100, 100, 100, 100);
//    t_layer.shadowOffset = CGSizeMake(2, 0);
//    t_layer.shadowOpacity = 1;
//    t_layer.shadowRadius = 8;
//    t_layer.backgroundColor = UIColor.redColor.CGColor;
    
    //可设置区域
//    CGFloat shadowPathWidth = t_layer.shadowRadius;
//    CGRect shadowRect = CGRectMake(0, 0-shadowPathWidth/2, t_layer.bounds.size.width, shadowPathWidth);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
//
//    t_layer.shadowPath = path.CGPath;
    
    
//    [self.view.layer addSublayer:t_layer];
    
}


#pragma mark - 简单动画
-(void)createSimapleAnimation{
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    _redView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:_redView];
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    _layer = layer;
    [self.view.layer addSublayer:layer];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.y";
        animation.toValue = @400;
        animation.duration = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
    //    animation.fillMode  = kCAFillModeBackwards;
        
        [self.redView.layer addAnimation:animation forKey:nil];
        
        //默认时间 0.25s runloop
        [CATransaction begin];
        
        [CATransaction setAnimationDuration:1];
        
        self.layer.backgroundColor = UIColor.orangeColor.CGColor;
        
        [CATransaction setCompletionBlock:^{
           
            CGAffineTransform transForm = self.layer.affineTransform;
            
            transForm = CGAffineTransformRotate(transForm, M_PI_2);
            self.layer.affineTransform = transForm;
            
            
        }];
        
        [CATransaction commit];
        
        
    });
    
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   
    
//    [self setBallInPasition:[self locationFromTouchEvent:event]];
    

}


-(CGPoint)locationFromTouchEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    return [touch locationInView:self.view];
    
}


-(void)setBallInPasition:(CGPoint)position{
    
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorBallCell.scale"];
    anim.fromValue = @0.2;
    anim.toValue = @0.5f;
    anim.duration = 1.0;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    
    [self.colorBallLayer addAnimation:anim forKey:nil];
    
    [self.colorBallLayer setValue:[NSValue valueWithCGPoint:position] forKey:@"emitterPosition"];
    
    [CATransaction commit];
    
}


@end
