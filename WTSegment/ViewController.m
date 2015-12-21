//
//  ViewController.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "ViewController.h"
#import "WTSegment.h"
#import "ItemView.h"
#import "UIColor+Addtions.h"
#import "WTSegmentItem.h"

#define ScreenH     ([[UIScreen mainScreen]bounds].size.height)
#define ScreenW     ([[UIScreen mainScreen]bounds].size.width)
#define SegmentH    35

@interface ViewController ()<WTSegmentDataSource,WTSegmentDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView1;
@property (nonatomic, strong) WTSegment *segment;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController
@synthesize scrollView1,segment;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"沪深",@"板块",@"股指",@"港股",@"全球",@"全部"];
    
    segment = [[WTSegment alloc]initWithFrame:CGRectMake(0, 20, ScreenW, SegmentH) style:WTSegmentStylePlain];
    segment.backgroundColor = [UIColor colorWithHexColor:@"1b2735"];
    segment.cursorColor = [UIColor colorWithHexColor:@"369fea"];
    segment.seperateColor = [UIColor colorWithHexColor:@"369fea"];
    segment.dataSource = self;
    segment.delegate = self;
    [self.view addSubview:segment];
    
    scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SegmentH + 20, ScreenW, ScreenH - SegmentH)];
    scrollView1.pagingEnabled = YES;
    scrollView1.delegate = self;
    scrollView1.contentSize = CGSizeMake(ScreenW * self.data.count, ScreenH - SegmentH);
    [self.view addSubview:scrollView1];
    
    for(int i = 0; i < self.data.count; i++){
        ItemView *view = [[ItemView alloc]initWithFrame:CGRectMake(ScreenW * i, 0, ScreenW, ScreenH - SegmentH)];
        view.detail = [NSString stringWithFormat:@"第%d个页面",i + 1];
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                               green:arc4random() % 255 / 255.0
                                                blue:arc4random() % 255 / 255.0
                                               alpha:1.0f];
        [scrollView1 addSubview:view];
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [segment scrollToRow:scrollView.contentOffset.x / ScreenW animation:YES];
}

#pragma mark - WTSegmentDelegate
- (void)WTSegment:(WTSegment *)segment didSelectedAtRow:(NSInteger)row{
    [scrollView1 scrollRectToVisible:CGRectMake(ScreenW * row, SegmentH + 20, ScreenW, ScreenH - SegmentH) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
