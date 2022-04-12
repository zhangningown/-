//
//  LayerLabel.m
//  Test
//
//  Created by 张宁 on 2022/4/11.
//

#import "LayerLabel.h"

@implementation LayerLabel

+(Class)layerClass{
    
    return [CATextLayer class];
    
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self setUp];
    }
    return  self;
}

-(CATextLayer *)textLayer{
    
    
    return (CATextLayer *)self.layer;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setUp];
    
}

-(void)setText:(NSString *)text{
    
    [self textLayer].string = text;
}


-(void)setTextColor:(UIColor *)textColor{
    
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}


-(void)setFont:(UIFont *)font{
    
    super.font = font;
    
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    
    CGFontRef fonRef = CGFontCreateWithFontName(fontName);
    
    [self textLayer].font = fonRef;
    
    [self textLayer].fontSize = font.pointSize;
    
    CGFontRelease(fonRef);
    
}


-(void)setUp{
    
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    [self textLayer].alignmentMode = kCAAlignmentCenter;
    
    [self textLayer].wrapped = YES;
    
    [self.layer display];
    
}

@end
