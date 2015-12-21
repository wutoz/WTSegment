//
//  WTSegment.h
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTSegmentItem.h"
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
 *  获取指定位置的Item
 *
 *  @param row 位置
 *
 *  @return 返回Item
 */
- (WTSegmentItem *)itemAtRow:(NSInteger)row;
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
- (WTSegmentItem *)WTSegment:(WTSegment *)segment itemAtRow:(NSInteger)row;

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
