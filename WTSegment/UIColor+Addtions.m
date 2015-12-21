//
//  UIColor+Addtions.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "UIColor+Addtions.h"

@implementation UIColor (Addtions)

+ (UIColor *)colorWithHexColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red / 255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

@end
