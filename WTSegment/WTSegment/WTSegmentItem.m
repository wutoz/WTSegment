//
//  WTSegmentItem.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "WTSegmentItem.h"
#import <QuartzCore/QuartzCore.h>

@interface WTSegmentItem ()

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@end

@implementation WTSegmentItem

- (instancetype)init{
    if(self = [super init]){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if(_selected){
        _titleLabel.textColor = _selectedColor;
    }else{
        _titleLabel.textColor = _normalColor;
    }
}

- (CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [[CAGradientLayer alloc] init];
        CGRect newGradientLayerFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _gradientLayer.frame = newGradientLayerFrame;
        
        //添加渐变的颜色组合
        _gradientLayer.colors = [NSArray arrayWithObjects:(id)[[_normalColor colorWithAlphaComponent:1]CGColor],
                                (id)[[_selectedColor colorWithAlphaComponent:1]CGColor],
                                nil];
        
        _gradientLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                                   [NSNumber numberWithFloat:1.0],
                                   nil];
        
        _gradientLayer.startPoint = CGPointMake(0,0);
        _gradientLayer.endPoint = CGPointMake(1,0);

    }
    return _gradientLayer;
}

- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.gradientLayer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
