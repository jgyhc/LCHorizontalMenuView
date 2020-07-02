//
//  LCHorizontalMenuView.h
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/6/8.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHorizontalMenuBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class LCHorizontalMenuView;
@protocol LCHorizontalMenuViewDelegate <NSObject>

@optional
//点击item的回调
- (void)didSelectItemWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index;

///拖动的回调
- (void)horizontalMenuView:(LCHorizontalMenuView *)horizontalMenuView WillEndDraggingWithVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

/// 更新页码回调
/// @param menuView 当前控件
/// @param currentPage 当前页码
- (void)pageUpdateWithMenuView:(LCHorizontalMenuView *)menuView pageControl:(UIView *)pageControl currentPage:(NSInteger)currentPage;


@end

/// 数据源
@protocol LCHorizontalMenuViewDataSource <NSObject>


/// 数据源总数
/// @param menuView 当前控件
- (NSInteger)numberOfIndexInHorizontalMenuView:(LCHorizontalMenuView *)menuView;


@optional

/// 设置每页的行数,默认 2
/// @param horizontalMenuView 当前控件
- (NSInteger)numOfRowsPerPageInHorizontalMenuView:(LCHorizontalMenuView *)horizontalMenuView;

/// 设置每页的列数 默认 4
/// @param horizontalMenuView horizontalMenuView 当前控件
- (NSInteger)numOfColumnsPerPageInHorizontalMenuView:(LCHorizontalMenuView *)horizontalMenuView;


/// 因为默认会根据高宽撑起整个界面 所以这里加一个边距
/// @param menuView 当前控件
- (UIEdgeInsets)contentMarginMenuView:(LCHorizontalMenuView *)menuView;


/// 赋值用的回调方法
/// @param menuView 当前控件
/// @param index 当前下标
/// @param cell cell
- (void)dataAssignmentWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index cell:(UICollectionViewCell *)cell;

/// 是否展示页码控制器
/// @param menuView 当前控件
- (BOOL)isShowPageControl:(LCHorizontalMenuView *)menuView numberOfPages:(NSInteger)numberOfPages;

/// 自定义页码控制器
/// @param menuView 当前控件
- (UIView *)customPageControlMenuView:(LCHorizontalMenuView *)menuView numberOfPages:(NSInteger)numberOfPages;

/// 如果默认使用UIPageControl 这里可以设置一下UIPageControl的样式
/// @param menuView 当前控件
/// @param pageControl UIPageControl
- (void)pageControlInitMenuView:(LCHorizontalMenuView *)menuView pageControl:(UIPageControl *)pageControl;


/// 如需自定义cell ** 自定义需要先调用 registerCellWithMenuView:collectionView: 注册cell**
/// @param menuView 当前控件
/// @param collectionView 当前控件使用的UICollectionView
/// @param indexPath 当前下标
- (UICollectionViewCell *)menuView:(LCHorizontalMenuView *)menuView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/// 注册自定义cell用
/// @param menuView 当前控件
/// @param collectionView 当前控件使用的UICollectionView
- (void)registerCellWithMenuView:(LCHorizontalMenuView *)menuView collectionView:(UICollectionView *)collectionView;



@end

@interface LCHorizontalMenuView : UIView
/** 界面默认会根据设置的高度自动填充 */
@property (nonatomic, weak) id<LCHorizontalMenuViewDataSource> dataSource;

@property (nonatomic, weak) id<LCHorizontalMenuViewDelegate> delegate;

@property (nonatomic, strong, readonly) UICollectionView * collectionView;

- (void)reloadData;


@end

NS_ASSUME_NONNULL_END
