//
// WTSegment.h
//
// Copyright (c) 2015 wutongr (http://www.wutongr.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "WTSegment.h"

#define CURSOR_H          3
#define TAG               [@"Item" hash]
#define FRAME_H           (self.frame.size.height)
#define FRAME_W           (self.frame.size.width)
#define ITEM_W(_rows)     (_rows <= _itemsMax ? FRAME_W / _rows : FRAME_W / _itemsMax)

@interface WTSegment ()

@property (nonatomic, strong) UIScrollView *floorView;
@property (nonatomic, strong) UIView *cursorView;
@property (nonatomic, strong) UIView<WTSegmentProtocol> *crtItem;
@property (nonatomic, strong) UIView<WTSegmentProtocol> *selItem;
@property (nonatomic, assign) NSInteger rows;

@end

@implementation WTSegment

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame style:(WTSegmentStyle)style{
    if(self = [super initWithFrame:frame]){
        _style = style;
        _itemsMax = 6;
        
        _floorView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _floorView.bounces = NO;
        _floorView.showsHorizontalScrollIndicator = NO;
        _floorView.showsVerticalScrollIndicator = NO;
        [self addSubview:_floorView];
        
        _cursorStyle = WTSegmentCursorStyleBottom;
        _cursorView = [[UIView alloc]initWithFrame:CGRectZero];
        [_floorView addSubview:_cursorView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setUp];
}

#pragma mark - 构造控件
- (void)setUp{
    _selectedIndex = 0;
    _rows = [_dataSource numberOfRowsInWTSegment:self];
    
    [self updateCursorOffset:0];

    for(UIView *item in _floorView.subviews){
        if(item.tag >= TAG){
            [item removeFromSuperview];
        }
    }
    
    for(int i = 0; i < _rows; i++){
        switch (_style) {
            case WTSegmentStyleGroup:
            {
                if(i == 0) break;
                
                UIView *lineView = [[UIView alloc]init];
                lineView.frame = CGRectMake(ITEM_W(_rows) * i, (FRAME_H - CURSOR_H) / 3, 1, (FRAME_H - CURSOR_H) / 3);
                lineView.backgroundColor = _seperateColor;
                lineView.tag = TAG * 2 + i;
                [_floorView addSubview:lineView];
            }
                break;
            case WTSegmentStylePlain:
                break;
        }
    }
    
    for(int i = 0; i < _rows; i++){
        UIView<WTSegmentProtocol> *item = [_dataSource WTSegment:self itemAtRow:i];
        item.tag = TAG + i;
        if(i == 0){
            item.selected = YES;
            self.crtItem = item;
        }else{
            item.selected = NO;
        }
        switch (_cursorStyle) {
            case WTSegmentCursorStyleBottom:
                item.frame = CGRectMake(ITEM_W(_rows) * i, 0, ITEM_W(_rows), FRAME_H - CURSOR_H);
                break;
            case WTSegmentCursorStyleMiddle:
                item.frame = CGRectMake(ITEM_W(_rows) * i, CURSOR_H, ITEM_W(_rows), FRAME_H - CURSOR_H * 2);
                break;
            case WTSegmentCursorStyleTop:
                item.frame = CGRectMake(ITEM_W(_rows) * i, CURSOR_H, ITEM_W(_rows), FRAME_H - CURSOR_H);
                break;
        }
        
        [_floorView addSubview:item];
    }
    
    if(_rows > _itemsMax){
        _floorView.contentSize = CGSizeMake(FRAME_W + (_rows - _itemsMax) * ITEM_W(_rows), FRAME_H);
    }else{
        _floorView.contentSize = CGSizeZero;
    }
    
}

#pragma mark - 滑动事件
- (void)scrollToRow:(NSInteger)row animation:(BOOL)animation{
    _selectedIndex = row;
    self.crtItem.selected = NO;
    self.crtItem = [self itemAtRow:_selectedIndex];
    self.crtItem.selected = YES;
}

- (void)scrollToOffset:(CGFloat)offset{
    CGFloat itemOffset = offset / (_rows <= _itemsMax ? _rows :_itemsMax);
    [self updateCursorOffset:itemOffset];
    [self updateItemOffset:itemOffset];
    [self updateScrollViewOffset:itemOffset];
}

#pragma mark - Utils
- (void)updateCursorOffset:(CGFloat)offset{
    _cursorView.backgroundColor = _cursorColor;
    switch (_cursorStyle) {
        case WTSegmentCursorStyleBottom:
            _cursorView.frame = CGRectMake(offset, FRAME_H - CURSOR_H, ITEM_W(_rows), CURSOR_H);
            break;
        case WTSegmentCursorStyleMiddle:
            _cursorView.layer.cornerRadius = 10.0f;
            _cursorView.frame = CGRectMake(offset, CURSOR_H, ITEM_W(_rows), FRAME_H - CURSOR_H * 2);
            break;
        case WTSegmentCursorStyleTop:
            _cursorView.frame = CGRectMake(offset, 0, ITEM_W(_rows), CURSOR_H);
            break;
    }
}

- (void)updateScrollViewOffset:(CGFloat)offset{
    if(offset > ITEM_W(_rows) * (_itemsMax - 3) && offset <= ITEM_W(_rows) * (_rows - 3) && _rows > _itemsMax){
        _floorView.contentOffset =  CGPointMake(ITEM_W(_rows) * (3 - _itemsMax) + offset, _floorView.contentOffset.y);
    }
}

- (void)updateItemOffset:(CGFloat)offset{
    UIView<WTSegmentProtocol> *item;
    item = [self itemAtRow:floorf(offset / ITEM_W(_rows))];
    item.progress = 1 - offset / ITEM_W(_rows) + floorf(offset / ITEM_W(_rows));
    
    item = [self itemAtRow:floorf(offset / ITEM_W(_rows)) + 1];
    item.progress = offset / ITEM_W(_rows) - floorf(offset / ITEM_W(_rows));
}

#pragma mark - 刷新
- (void)reloadSegment{
    [self setUp];
}

- (UIView<WTSegmentProtocol> *)itemAtRow:(NSInteger)row{
    return [_floorView viewWithTag:row + TAG];
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:_floorView];
    
    for(int i = 0; i < _rows; i++){
        UIView<WTSegmentProtocol> *item = [self itemAtRow:i];
        if(CGRectContainsPoint(item.frame, location))
        {
            item.selected = YES;
            self.selItem = item;
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = [[touches anyObject] locationInView:_floorView];
    
    for(int i = 0; i < _rows; i++){
        UIView<WTSegmentProtocol> *item = [self itemAtRow:i];
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

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.selItem.selected = NO;
}

@end

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesBegan:touches withEvent:event];
//    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesMoved:touches withEvent:event];
//    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesEnded:touches withEvent:event];
//    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesCancelled:touches withEvent:event];
//    [super touchesCancelled:touches withEvent:event];
}

@end
