# WTSegment

[![release](https://img.shields.io/badge/release-v0.1.1-orange.svg)](https://github.com/wutongr/WTSegment/releases) [![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/wutongr/WTSegment/blob/master/LICENSE)

UITableView风格的自定义SegmentView

## 安装

### 源文件
拷贝 `WTSegment/`目录下 WTSegment.h / WTSegment.h 和 WTSegmentProtocol.h

### CocoaPods

```pod 'WTSegment'```

## 使用
```objc
    self.data = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题9",@"标题10",@"标题11"];

    segment = [[WTSegment alloc]initWithFrame:CGRectMake(0, 20, ScreenW, SegmentH) style:WTSegmentStylePlain];
    segment.backgroundColor = [UIColor colorWithHexColor:@"1b2735"];
    segment.cursorColor = [UIColor colorWithHexColor:@"369fea"];
    segment.seperateColor = [UIColor colorWithHexColor:@"369fea"];
    segment.dataSource = self;
    segment.delegate = self;
    [self.view addSubview:segment];
    
#pragma mark - WTSegmentDataSource
- (NSInteger)numberOfRowsInWTSegment:(WTSegment *)segment{
    return self.data.count;
}

- (UIView<WTSegmentProtocol> *)WTSegment:(WTSegment *)segment itemAtRow:(NSInteger)row{
    WTSegmentItem *item = [[WTSegmentItem alloc]init];
    item.titleLabel.text = self.data[row];
    item.titleLabel.font = [UIFont systemFontOfSize:15];
    item.selectedColor = [UIColor colorWithHexColor:@"369fea"];
    item.normalColor = [UIColor lightGrayColor];
    return item;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [segment scrollToOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [segment scrollToRow:scrollView.contentOffset.x / ScreenW animation:YES];
}

#pragma mark - WTSegmentDelegate
- (void)WTSegment:(WTSegment *)segment didSelectedAtRow:(NSInteger)row{
    [scrollView1 scrollRectToVisible:CGRectMake(ScreenW * row, SegmentH + 20, ScreenW, ScreenH - SegmentH) animated:YES];
}
```
## 支持系统
- iOS 7+

## TODO
- 滑动效果优化
