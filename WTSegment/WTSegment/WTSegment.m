//
//  WTSegment.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "WTSegment.h"

#define CURSOR_H      3
#define TAG          [@"Item" hash]

@interface WTSegment ()

@property (nonatomic, strong) UIView *cursorView;
@property (nonatomic, strong) WTSegmentItem *crtItem;
@property (nonatomic, strong) WTSegmentItem *selItem;

@end

@implementation WTSegment
@synthesize cursorView;

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame style:(WTSegmentStyle)style{
    if(self = [super initWithFrame:frame]){
        _style = style;
        cursorView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:cursorView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setUp];
}

#pragma mark - 构造控件
- (void)setUp{
    NSInteger count = [_dataSource numberOfRowsInWTSegment:self];
    
    for(int i = 0; i < count; i++){
        WTSegmentItem *item = [_dataSource WTSegment:self itemAtRow:i];
        item.tag = TAG + i;
        if(_selectedIndex == i){
            item.selected = YES;
            self.crtItem = item;
        }else{
            item.selected = NO;
        }
        item.frame = CGRectMake(self.frame.size.width / count * i, 0, self.frame.size.width / count, self.frame.size.height - CURSOR_H);
        [self addSubview:item];
        
        switch (_style) {
            case WTSegmentStyleGroup:
            {
                if(i == 0) break;
                
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width / count * i, (self.frame.size.height - CURSOR_H) / 3, 1, (self.frame.size.height - CURSOR_H) / 3)];
                line.backgroundColor = _seperateColor;
                [self addSubview:line];
            }
                break;
            case WTSegmentStylePlain:
                break;
        }
    }
    
    cursorView.backgroundColor = _cursorColor;
    cursorView.frame = CGRectMake(_selectedIndex * self.frame.size.width / count, self.frame.size.height - CURSOR_H, self.frame.size.width / count, CURSOR_H);
}

#pragma mark - 滑动事件
- (void)scrollToRow:(NSInteger)row animation:(BOOL)animation{
    _selectedIndex = row;
    self.crtItem.selected = NO;
    self.crtItem = [self itemAtRow:_selectedIndex];
    self.crtItem.selected = YES;
}

- (void)scrollToOffset:(CGFloat)offset{
    NSInteger count = [_dataSource numberOfRowsInWTSegment:self];
    CGFloat itemOffset = (offset - _selectedIndex * self.frame.size.width) / count;
    cursorView.frame = CGRectMake(_selectedIndex * self.frame.size.width / count + itemOffset, self.frame.size.height - CURSOR_H, self.frame.size.width / count, CURSOR_H);

    WTSegmentItem *item;
    if(itemOffset > 0.000001){
        item = [self itemAtRow:_selectedIndex + 1];
    }else{
        item = [self itemAtRow:_selectedIndex - 1];
    }
    
    if(item){
        if(fabs(itemOffset) <= self.frame.size.width / count){
            item.titleLabel.textColor = [item colorOfPoint:CGPointMake(fabs(itemOffset) / self.frame.size.width * item.frame.size.width, 0)];
        }else{
            item.titleLabel.textColor = item.normalColor;
        }
    }
}

#pragma mark - 刷新
- (void)reloadSegment{
    for(UIView *item in self.subviews){
        if(item.tag >= TAG){
            [item removeFromSuperview];
        }
    }
    [self setUp];
}

- (WTSegmentItem *)itemAtRow:(NSInteger)row{
    return [self viewWithTag:row + TAG];
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self];
    NSInteger count = [_dataSource numberOfRowsInWTSegment:self];
    
    for(int i = 0; i < count; i++){
        WTSegmentItem *item = [self itemAtRow:i];
        if(CGRectContainsPoint(item.frame, location))
        {
            item.selected = YES;
            self.selItem = item;
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:self];
    NSInteger count = [_dataSource numberOfRowsInWTSegment:self];
    
    for(int i = 0; i < count; i++){
        WTSegmentItem *item = [self itemAtRow:i];
        if(CGRectContainsPoint(item.frame, location))
        {
            item.selected = YES;
            if(self.selItem != item && self.selItem != self.crtItem){
                self.selItem.selected = NO;
            }
            self.selItem = item;
            break;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.crtItem != self.selItem){
        self.crtItem.selected = NO;
        self.crtItem = self.selItem;
        _selectedIndex = self.crtItem.tag - TAG;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(WTSegment:didSelectedAtRow:)]){
        [_delegate WTSegment:self didSelectedAtRow:_selectedIndex];
    }
}

@end
