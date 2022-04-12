//
//  BlueView.m
//  Test
//
//  Created by 张宁 on 2022/4/7.
//

#import "BlueView.h"

@implementation BlueView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    //是否响应时间的必须条件
    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
        
        return nil;
    }
    //如果touch的点 在self.bounds内容外
    if ([self pointInside:point withEvent:event]) {
        
        for (UIView *subView in self.subviews) {
        
            CGPoint coverPoint = [subView convertPoint:point fromView:self];
            UIView *hitTestView = [subView hitTest:coverPoint withEvent:event];
            
            if (hitTestView) {
                
                return hitTestView;
            }
            
        }
        
        
    }
    return  nil;
    
}

@end
