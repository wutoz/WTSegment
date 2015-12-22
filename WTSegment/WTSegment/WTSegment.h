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

#import <UIKit/UIKit.h>
#import "WTSegmentProtocol.h"
/*!
 *  控件风格
 */
typedef NS_ENUM(NSInteger,WTSegmentStyle) {
    /*!
     *  默认风格
     */
    WTSegmentStylePlain = 1,
    /*!
     *  分割线风格
     */
    WTSegmentStyleGroup
};
/*!
 *  控件游标风格
 */
typedef NS_ENUM(NSInteger,WTSegmentCursorStyle) {
    /*!
     *  底部线风格
     */
    WTSegmentCursorStyleBottom = 1,
    /*!
     *  中间框风格
     */
    WTSegmentCursorStyleMiddle,
    /*!
     *  上部线风格
     */
    WTSegmentCursorStyleTop
};
/*!
 *  数据源代理
 */
@protocol WTSegmentDataSource;
/*!
 *  事件代理
 */
@protocol WTSegmentDelegate;
/*!
 分段控件,代码风格借鉴UITableView,优点扩展性强.
 
 - returns: 分段控件
 */
@interface WTSegment : UIView
/*!
 *  默认初始化方法
 *
 *  @param frame 控件框架
 *  @param style 控件风格
 *
 *  @return 控件
 */
- (instancetype)initWithFrame:(CGRect)frame style:(WTSegmentStyle)style;
/*!
 *  控件风格 WTSegmentStylePlain || WTSegmentStyleGroup
 */
@property (nonatomic, readonly) WTSegmentStyle style;
/*!
 *  控件游标风格 WTSegmentCursorStyleBottom || WTSegmentCursorStyleMiddle || WTSegmentCursorStyleTop
 */
@property (nonatomic, assign) WTSegmentCursorStyle cursorStyle;
/*!
 *  事件代理
 */
@property (nonatomic, weak) id<WTSegmentDelegate> delegate;
/*!
 *  数据源代理
 */
@property (nonatomic, weak) id<WTSegmentDataSource> dataSource;
/*!
 *  选中的索引
 */
@property (nonatomic, readonly) NSInteger selectedIndex;
/*!
 *  游标颜色
 */
@property (nonatomic, strong) UIColor *cursorColor;
/*!
 *  分割线颜色
 */
@property (nonatomic, strong) UIColor *seperateColor;
/*!
 *  屏幕显示Item最大数量
 */
@property (nonatomic, assign) NSInteger itemsMax;
/*!
 *  获取指定位置的Item
 *
 *  @param row 位置
 *
 *  @return 返回Item
 */
- (UIView<WTSegmentProtocol> *)itemAtRow:(NSInteger)row;
/*!
 *  移动到指定位置
 *
 *  @param row       位置
 *  @param animation 是否需要动画
 */
- (void)scrollToRow:(NSInteger)row animation:(BOOL)animation;
/*!
 *  游标移动到指定位置
 *
 *  @param offset 偏移量
 */
- (void)scrollToOffset:(CGFloat)offset;
/*!
 *  刷新控件
 */
- (void)reloadSegment;

@end

@protocol WTSegmentDataSource <NSObject>

@required
/*!
 *  获取控件中包含的Item数
 *
 *  @param segment 控件
 *
 *  @return 数量
 */
- (NSInteger)numberOfRowsInWTSegment:(WTSegment *)segment;
/*!
 *  在指定位置,设置自定义Item
 *
 *  @param segment 控件
 *  @param row     位置
 *
 *  @return 自定义Item
 */
- (UIView<WTSegmentProtocol> *)WTSegment:(WTSegment *)segment itemAtRow:(NSInteger)row;

@end

@protocol WTSegmentDelegate <NSObject>

@optional
/*!
 *  Item点击事件
 *
 *  @param segment 控件
 *  @param row     位置
 */
- (void)WTSegment:(WTSegment *)segment didSelectedAtRow:(NSInteger)row;

@end
