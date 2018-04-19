//
//  NEWcycle.m
//  CYCleViews
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "NEWcycle.h"
#import "Masonry.h"
#import "CYClelayout.h"
#define  kSeed 1000
@interface NEWcycle()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,weak) UIPageControl *pageControl;
@end

@implementation NEWcycle
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self loadcycleView];
    }
    return self;
}
-(void)loadcycleView{
    //创建collectionviews
   CYClelayout *layout = [[CYClelayout alloc] init];
       UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled  = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cycleCell" ];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
      // 创建pagecontrolview
    UIPageControl *pageControl = [[UIPageControl alloc]init];

    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
 
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    //添加约束；
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(10);
    }];
   // 添加定时器，保证图片每秒滚动一次；
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(loadPictures) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //记录变量
    self.timer = timer;
}
#pragma  监听定时器的方法
-(void)loadPictures{
  // NSLog(@"开始");
    //获取collectionView的偏移量，根据偏移量移动图片；
    CGFloat offsetX = self.collectionView.contentOffset.x;
    offsetX += self.bounds.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark ----collectionViewDatasourse
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cycleList.count*kSeed;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cycleCell" forIndexPath:indexPath];
    UIImage *image = self.cycleList[indexPath.item % _cycleList.count];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    cell.backgroundView = imageView;
    return cell;
}
#pragma -----监听collectionview的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX/self.bounds.size.width;
    self.pageControl.currentPage =(NSInteger)( page+0.5 )%_cycleList.count;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1.获取到停止滚动的时候，当前显示的是第几个cell
    UICollectionViewCell *cell = [[self.collectionView visibleCells] lastObject];
    //2.根据cell，拿到这个cell的indexPath
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    //3.判断当前cell是否是最后一个
    //3.1先要获取collectionView里一共有多少个cell
    //第0组里一共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //3.2判断当前cell是不是最后一个
    if (indexPath.item == itemCount - 1) {
        //4.让collectionView跳转到图片的个数 - 1个item
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForItem:_cycleList.count*kSeed *0.5 -1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:toIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    
    //如果滚动到了第0个条目
    if (indexPath.item == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_cycleList.count*kSeed*0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }

}
#pragma 开始拖拽时，让定时器停止工作
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.timer.fireDate = [NSDate distantFuture];
}
#pragma 拖拽结束两秒以后，在让定时器开始工作
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
}
#pragma ----这个方法必须实现，否则pagecontroll子控件加载不上来；
-(void)layoutSubviews{
    [super layoutSubviews];
       [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_cycleList.count*kSeed*0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
-(void)setCycleList:(NSArray *)cycleList{
    _cycleList = cycleList;
      self.pageControl.numberOfPages = _cycleList.count;
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.timer invalidate];
}
@end
