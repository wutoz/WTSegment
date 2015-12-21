//
//  WTSegmentItem.h
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTSegmentItem : UIView

- (instancetype)init;

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;

@end
