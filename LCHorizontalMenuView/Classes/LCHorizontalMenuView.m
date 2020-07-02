//
//  LCHorizontalMenuView.m
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/6/8.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import "LCHorizontalMenuView.h"
#import "LCHorizontalMenuCollectionViewLayout.h"
#import "Masonry.h"

@interface LCHorizontalMenuView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) LCHorizontalMenuCollectionViewLayout * collectionViewLayout;

@property (nonatomic, strong) UIView *pageControl;
@end

@implementation LCHorizontalMenuView

- (void)initCollectionView {
    [self addSubview:self.collectionView];
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(contentMarginMenuView:)]) {
        insets = [self.dataSource contentMarginMenuView:self];
    }
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(insets);
    }];
    [self.collectionView registerClass:NSClassFromString(@"LCHorizontalMenuBaseCollectionViewCell") forCellWithReuseIdentifier:@"LCHorizontalMenuBaseCollectionViewCell"];
    [self.collectionView reloadData];
}

- (void)reloadData {
    [self.collectionView reloadData];
    [self initPageControl];
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(contentMarginMenuView:)]) {
        insets = [self.dataSource contentMarginMenuView:self];
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(insets);
    }];
}

- (NSInteger)numberOfPages {
    NSInteger count = [self.dataSource numberOfIndexInHorizontalMenuView:self];
    NSInteger maxCountPerPage = self.collectionViewLayout.rowCount * self.collectionViewLayout.columCount;
   if (maxCountPerPage == 0) {
       return 0;
   }
   return ((count % maxCountPerPage) == 0) ? (count / maxCountPerPage) : (int)(count * 1.0 / maxCountPerPage) + 1;
}

- (void)initPageControl {
    BOOL isShowPageControl = NO;
    NSInteger numberOfPages = [self numberOfPages];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(isShowPageControl:numberOfPages:)]) {
        isShowPageControl = [self.dataSource isShowPageControl:self numberOfPages:numberOfPages];
    }
    if (isShowPageControl) {
        [self.pageControl removeFromSuperview];
        _pageControl = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(customPageControlMenuView:numberOfPages:)]) {
            _pageControl = [self.dataSource customPageControlMenuView:self numberOfPages:numberOfPages];
        }else {
            UIPageControl * pageControl = [[UIPageControl alloc] init];
            _pageControl = pageControl;
            pageControl.numberOfPages = numberOfPages;
            pageControl.currentPage = 0;
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageControlInitMenuView:pageControl:)]) {
                [self.dataSource pageControlInitMenuView:self pageControl:pageControl];
            }
        }
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(20);
        }];
    }else {
        [self.pageControl removeFromSuperview];
    }
}

- (void)setDataSource:(id<LCHorizontalMenuViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(registerCellWithMenuView:collectionView:)]) {
        [self.dataSource registerCellWithMenuView:self collectionView:self.collectionView];
    }
    [self initCollectionView];
    [self initPageControl];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfIndexInHorizontalMenuView:self];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menuView:collectionView:cellForItemAtIndexPath:)]) {
        cell = [self.dataSource menuView:self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCHorizontalMenuBaseCollectionViewCell" forIndexPath:indexPath];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(dataAssignmentWithMenuView:index:cell:)]) {
        [self.dataSource dataAssignmentWithMenuView:self index:indexPath.row cell:cell];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemWithMenuView:index:)]) {
        [self.delegate didSelectItemWithMenuView:self index:indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    if ([_pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = currentPage;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageUpdateWithMenuView:pageControl:currentPage:)]) {
        [self.delegate pageUpdateWithMenuView:self pageControl:_pageControl currentPage:currentPage];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    NSInteger currentPage = targetContentOffset->x / self.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(horizontalMenuView:WillEndDraggingWithVelocity:targetContentOffset:)]) {
        [self.delegate horizontalMenuView:self WillEndDraggingWithVelocity:velocity targetContentOffset:targetContentOffset];
    }
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _collectionView;
}

- (LCHorizontalMenuCollectionViewLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[LCHorizontalMenuCollectionViewLayout alloc] init];
        //设置行数
       if (self.dataSource && [self.dataSource respondsToSelector:@selector(numOfRowsPerPageInHorizontalMenuView:)]) {
           _collectionViewLayout.rowCount = [self.dataSource numOfRowsPerPageInHorizontalMenuView:self];
       }else{
           _collectionViewLayout.rowCount = 2;
       }
       // 设置列数
       if(self.dataSource && [self.dataSource respondsToSelector:@selector(numOfColumnsPerPageInHorizontalMenuView:)]) {
           _collectionViewLayout.columCount = [self.dataSource numOfColumnsPerPageInHorizontalMenuView:self];
       } else {
           _collectionViewLayout.columCount = 4;
       }
    }
    return _collectionViewLayout;
}

@end
