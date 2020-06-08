//
//  LCPageControl.h
//  ManJi
//
//  Created by manjiwang on 2018/9/15.
//  Copyright © 2018年 Zgmanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCPageControl;
@protocol LCPageControlDelegate <NSObject>

/// 自定义页码 自定义的pageIndicatorTintColor和currentPageIndicatorTintColor 会失效 请通过设置selected来设置样式
/// @param pageControl 当前控件
/// @param index 下标
- (UIControl *)customPageItemWithPageControl:(LCPageControl *)pageControl index:(NSInteger)index;


/// 页码的大小 传入CGSizeZero时 自适应大小
/// @param pageControl 当前控件
/// @param index 下标
- (CGSize)customPageItemSizeWithPageControl:(LCPageControl *)pageControl index:(NSInteger)index;


/// 页码之间的间距
/// @param pageControl 当前控件
- (CGFloat)customPageItemSpaceingWithPageControl:(LCPageControl *)pageControl;


@end

@interface LCPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, assign) NSInteger currentPage;

@property(nonatomic, strong) UIColor * pageIndicatorTintColor;

@property(nonatomic, strong) UIColor * currentPageIndicatorTintColor;

@property (nonatomic, weak) id<LCPageControlDelegate> delegate;

@end

