//
//  ReflectionView.m
//  Test
//
//  Created by 张宁 on 2022/4/12.
//

#import "ReflectionView.h"

@interface ReflectionView()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ReflectionView


+ (Class)layerClass{
    
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h )];
        [self addSubview:_imgView];
        
        
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setUp];
}

-(void)setUp{
    
    UIImage *image = [UIImage imageNamed:@"ecfab1b7449dff80a6c3483006304a7e.jpeg"];
    
    self.imgView.image = image;
    
    
//    CAReplicatorLayer *repL =  (CAReplicatorLayer *)self.layer;
//    repL.instanceCount = 2;
//    //复制出来的子层,它都是绕着复制层锚点进行旋转.
//    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//
////    repL.instanceRedOffset -= 0.5;
////    repL.instanceGreenOffset -= 0.5;
////    repL.instanceBlueOffset -= 0.5;
//    repL.instanceAlphaOffset -= 0.5;
    
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;

    layer.instanceCount = 2;

    CATransform3D transForm = CATransform3DIdentity;

    CGFloat veticalOffSet = self.imgView.bounds.size.height * 0.75;

    transForm = CATransform3DTranslate(transForm, 0, veticalOffSet, 0);

    transForm = CATransform3DScale(transForm, -1, -0.5, 0);

    layer.instanceTransform = transForm;

    //透明度
    layer.instanceAlphaOffset = -0.7;

    
}
@end
