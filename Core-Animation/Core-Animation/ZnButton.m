//
//  ZnButton.m
//  Core-Animation
//
//  Created by 张宁 on 2022/4/13.
//

#import "ZnButton.h"

@interface ZnButton()

@property(nonatomic,strong)CAEmitterLayer *explosionLayer;

@end


@implementation ZnButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self setupExplosion];
    
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupExplosion];
    }
    
    return  self;
}

-(void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    
    if (selected) {
        
        animation.values = @[@1.5,@2,@0.8,@1.0];
     
        animation.duration = 0.5;
        
        animation.calculationMode = kCAAnimationCubic;
        
        [self.layer addAnimation:animation forKey:nil];
        
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    }else{
        
        [self stopAnimation];
    }
    
    
}

-(void)startAnimation{
    
    // 用KVC设置颗粒个数  explosionCell与 cell.name要一致
    [self.explosionLayer setValue:@1000 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    
    // 开始动画
    self.explosionLayer.beginTime = CACurrentMediaTime();
    
    // 延迟停止动画
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
    
    
}

-(void)stopAnimation{
    
    // 用KVC设置颗粒个数 explosionCell与 cell.name要一致
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    // 移除动画
    [self.explosionLayer removeAllAnimations];

    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
}



//// 设置粒子
- (void)setupExplosion{

    // 粒子
    CAEmitterCell * explosionCell = [CAEmitterCell emitterCell];
    //此处要注意 如果名称与上面开始动画kvc值 不一样 不会产生效果
    explosionCell.name = @"explosionCell";
    // 透明值变化速度
    explosionCell.alphaSpeed = -1.f;
    // alphaRange透明值范围
    explosionCell.alphaRange = 0.10;
    // 生命周期
    explosionCell.lifetime = 1;
    // 生命周期range
    explosionCell.lifetimeRange = 0.1;
    // 粒子速度
    explosionCell.velocity = 40.f;
    // 粒子速度范围
    explosionCell.velocityRange = 10.f;
    // 缩放比例
    explosionCell.scale = 0.08;
    // 缩放比例range
    explosionCell.scaleRange = 0.02;
    // 粒子图片
    explosionCell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];

    // 发射源
    CAEmitterLayer * explosionLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:explosionLayer];
    self.explosionLayer = explosionLayer;
    // 发射院尺寸大小
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    // emitterShape表示粒子从什么形状发射出来,圆形形状
    explosionLayer.emitterShape = kCAEmitterLayerCircle;
    // emitterMode发射模型,轮廓模式,从形状的边界上发射粒子
    explosionLayer.emitterMode = kCAEmitterLayerOutline;
    // renderMode:渲染模式
    explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    // 粒子cell 数组
    explosionLayer.emitterCells = @[explosionCell];
}


@end
