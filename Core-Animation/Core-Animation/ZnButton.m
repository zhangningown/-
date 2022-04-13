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
    
    [self.explosionLayer setValue:@1000 forKey:@"emitterCells.explosionCell.birthRate"];
    
    self.explosionLayer.beginTime = CACurrentMediaTime();
    
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
    
}

-(void)stopAnimation{
    
    [self.explosionLayer setValue:@0 forKey:@"emitterCells.explosionCell.birthRate"];
    [self.explosionLayer removeAllAnimations];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
}

-(void)setupExplosion{
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"cell";
    explosionCell.alphaSpeed = -1.0f;
    explosionCell.alphaRange = 1;
    explosionCell.lifetime = 0.1;
    explosionCell.velocity = 40.0f;
    explosionCell.velocityRange = 10.0f;
    explosionCell.scaleRange = 0.08;
    explosionCell.scaleSpeed = 0.02;
    explosionCell.contents = (id)[UIImage imageNamed:@"同心圆图"].CGImage;
 
    CAEmitterLayer *explosionLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:explosionLayer];
    self.explosionLayer = explosionLayer;
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    self.explosionLayer.emitterShape = kCAEmitterLayerCircle;
    self.explosionLayer.emitterMode = kCAEmitterLayerOutline;
    self.explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    self.explosionLayer.emitterCells = @[explosionCell];
    
    
}


@end
