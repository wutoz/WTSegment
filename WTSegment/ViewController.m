//
//  ViewController.m
//  WTSegment
//
//  Created by 梧桐 on 15/12/21.
//  Copyright © 2015年 梧桐. All rights reserved.
//

#import "ViewController.h"
#import "WTSegment.h"
#import "ChildView.h"
#import "UIColor+Addtions.h"
#import "WTSegmentItem.h"

#define ScreenH     ([[UIScreen mainScreen]bounds].size.height)
#define ScreenW     ([[UIScreen mainScreen]bounds].size.width)
#define SegmentH    35

@interface ViewController ()<WTSegmentDataSource,WTSegmentDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView1;
@property (nonatomic, strong) WTSegment *segment1;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController
@synthesize scrollView1,segment1;

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据源
    self.data = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5",@"标题6",@"标题7",@"标题8",@"标题9",@"标题10",@"标题11"];
    
    segment1 = [[WTSegment alloc]initWithFrame:CGRectMake(0, 20, ScreenW, SegmentH) style:WTSegmentStylePlain];
    segment1.backgroundColor = [UIColor blackColor];
    segment1.cursorColor = [UIColor redColor];
    segment1.cursorStyle = WTSegmentCursorStyleBottom;
    segment1.itemsMax = 6;
    segment1.dataSource = self;
    segment1.delegate = self;
    [self.view addSubview:segment1];
    
    scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SegmentH + 20, ScreenW, ScreenH - SegmentH)];
    scrollView1.pagingEnabled = YES;
    scrollView1.delegate = self;
    scrollView1.contentSize = CGSizeMake(ScreenW * self.data.count, ScreenH - SegmentH);
    [self.view addSubview:scrollView1];
    
    for(int i = 0; i < self.data.count; i++){
        ChildView *view = [[ChildView alloc]initWithFrame:CGRectMake(ScreenW * i, 0, ScreenW, ScreenH - SegmentH)];
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                               green:arc4random() % 255 / 255.0
                                                blue:arc4random() % 255 / 255.0
                                               alpha:1.0f];
        [scrollView1 addSubview:view];
    }
    
    
    UIButton *funcBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, ScreenH - 80, 50, 50)];
    [funcBtn1 setBackgroundColor:[UIColor redColor]];
    funcBtn1.layer.cornerRadius = 25.0f;
    [funcBtn1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:funcBtn1];
    
    UIButton *funcBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(80, ScreenH - 80, 50, 50)];
    [funcBtn2 setBackgroundColor:[UIColor blueColor]];
    funcBtn2.layer.cornerRadius = 25.0f;
    [funcBtn2 addTarget:self action:@selector(click2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:funcBtn2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)click1:(id)sender{
    [segment1 scrollToRow:3 animation:YES];
    [scrollView1 setContentOffset:CGPointMake(ScreenW * 3, scrollView1.contentOffset.y)];
}

- (void)click2:(id)sender{
    self.data = @[@"标题1",@"标题2",@"标题3",@"标题4"];
     [scrollView1 setContentOffset:CGPointMake(ScreenW * 0, scrollView1.contentOffset.y)];
    [segment1 reloadSegment];
}

#pragma mark - WTSegmentDataSource
- (NSInteger)numberOfRowsInWTSegment:(WTSegment *)segment{
    return self.data.count;
}

- (UIView<WTSegmentProtocol> *)WTSegment:(WTSegment *)segment itemAtRow:(NSInteger)row{
    WTSegmentItem *item = [[WTSegmentItem alloc]init];
    item.titleLabel.font = [UIFont systemFontOfSize:15];
    item.selectedColor = [UIColor redColor];
    item.normalColor = [UIColor whiteColor];
    item.titleLabel.text = self.data[row];
    return item;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [segment1 scrollToOffset:scrollView.contentOffset.x];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [segment1 scrollToRow:scrollView.contentOffset.x / ScreenW animation:YES];
}

#pragma mark - WTSegmentDelegate
- (void)WTSegment:(WTSegment *)segment didSelectedAtRow:(NSInteger)row{
    NSLog(@"%s",__FUNCTION__);
    [UIView animateWithDuration:0.2 animations:^{
        [scrollView1 setContentOffset:CGPointMake(ScreenW * row, scrollView1.contentOffset.y)];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
