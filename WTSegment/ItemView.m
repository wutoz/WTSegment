//
//  ItemView.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "ItemView.h"

@interface ItemView ()

@property (nonatomic, strong) UILabel *detailLab;
@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
        [self addSubview:_detailLab];
    }
    return self;
}

- (void)setDetail:(NSString *)detail{
    if(![_detail isEqualToString:detail]){
        _detail = detail;
        _detailLab.text = detail;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
