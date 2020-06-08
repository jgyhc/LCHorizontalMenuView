//
//  LCPageControl.m
//  ManJi
//
//  Created by manjiwang on 2018/9/15.
//  Copyright © 2018年 Zgmanhui. All rights reserved.
//

#import "LCPageControl.h"
#import "Masonry.h"



@interface MJIndexPageItemView : UIControl

@property(nonatomic, strong) UIColor * pageIndicatorTintColor;

@property(nonatomic, strong) UIColor * currentPageIndicatorTintColor;

@end


@implementation MJIndexPageItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.layer.cornerRadius = 1;
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (!self.selected) {
        [self setBackgroundColor:self.pageIndicatorTintColor];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (self.selected) {
        [self setBackgroundColor:self.currentPageIndicatorTintColor];
    }
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:self.currentPageIndicatorTintColor?self.currentPageIndicatorTintColor:[UIColor colorWithRed:209/255.0 green:45/255.0 blue:38/255.0 alpha:1.0]];
    }else {
        [self setBackgroundColor:self.pageIndicatorTintColor?self.pageIndicatorTintColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]];
    }
}

@end


@interface LCPageControl ()

@property (nonatomic, strong) NSArray * itemViews;

@property (nonatomic, strong) UIControl * lastItemView;
@end

@implementation LCPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *views = [NSMutableArray array];
    UIControl *lastItemView;
    for (int i = 0; i < _numberOfPages; i ++) {
        UIControl *itemView;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customPageItemWithPageControl:index:)]) {
            itemView = [self.delegate customPageItemWithPageControl:self index:i];
        }else {
            itemView = [[MJIndexPageItemView alloc] init];
            MJIndexPageItemView *view = (MJIndexPageItemView *)itemView;
            if (_pageIndicatorTintColor) {
                view.pageIndicatorTintColor = _pageIndicatorTintColor;
            }
            if (_currentPageIndicatorTintColor ) {
                view.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
            }
        }
        if (i == _currentPage) {
            itemView.selected = YES;
            _lastItemView = itemView;
        }else {
            itemView.selected = NO;
        }
        [self addSubview:itemView];
        [views addObject:itemView];
        CGSize size = CGSizeMake(10, 2);
        if (self.delegate && [self.delegate respondsToSelector:@selector(customPageItemSizeWithPageControl:index:)]) {
            size = [self.delegate customPageItemSizeWithPageControl:self index:i];
        }
        CGFloat spaceing = 3;
        if (self.delegate && [self.delegate respondsToSelector:@selector(customPageItemSpaceingWithPageControl:)]) {
            spaceing = [self.delegate customPageItemSpaceingWithPageControl:self];
        }
        if (!lastItemView) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(self.mas_left);
            }];
        }else if (i == _numberOfPages - 1) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(lastItemView.mas_right).mas_offset(spaceing);
                make.right.mas_equalTo(self.mas_right);
            }];
        }else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(lastItemView.mas_right).mas_offset(spaceing);
            }];
        }
        if (!CGSizeEqualToSize(size, CGSizeZero)) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
            }];
        }
        lastItemView = itemView;
    }
    _itemViews = views;
}


- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    NSLog(@"%ld", currentPage);
    if (currentPage < self.itemViews.count) {
        UIControl *itemView = self.itemViews[currentPage];
        if (_lastItemView) {
            _lastItemView.selected = NO;
        }
        itemView.selected = YES;
        _lastItemView = itemView;
    }
}



- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self.itemViews enumerateObjectsUsingBlock:^(MJIndexPageItemView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    }];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self.itemViews enumerateObjectsUsingBlock:^(MJIndexPageItemView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.pageIndicatorTintColor = pageIndicatorTintColor;
    }];
}

@end

