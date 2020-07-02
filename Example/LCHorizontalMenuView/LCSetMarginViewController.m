//
//  LCSetMarginViewController.m
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/7/2.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import "LCSetMarginViewController.h"
#import "LCHorizontalMenuView.h"

@interface LCSetMarginViewController ()<LCHorizontalMenuViewDataSource, LCHorizontalMenuViewDelegate>

@property (weak, nonatomic) IBOutlet LCHorizontalMenuView *menuView;



@end

@implementation LCSetMarginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    [self.menuView.collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (NSInteger)numberOfIndexInHorizontalMenuView:(LCHorizontalMenuView *)menuView {
    return 20;
}

- (void)dataAssignmentWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index cell:(LCHorizontalMenuBaseCollectionViewCell *)cell {
    //这里可以赋值
    cell.label.text = @"测试";
    [cell.imageView setBackgroundColor:[UIColor colorWithRed:251/255.0 green:236/255.0 blue:192/255.0 alpha:1.0]];
}

- (void)didSelectItemWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index {
    NSLog(@"%ld", index);
}


- (UIEdgeInsets)contentMarginMenuView:(LCHorizontalMenuView *)menuView {
    return UIEdgeInsetsMake(0, 0, 20, 0);//这里为了让pageContrl位置 靠下一点
}

- (BOOL)isShowPageControl:(LCHorizontalMenuView *)menuView {
    return YES;
}

- (void)pageUpdateWithMenuView:(LCHorizontalMenuView *)menuView pageControl:(UIPageControl *)pageControl currentPage:(NSInteger)currentPage {
    pageControl.currentPage = currentPage;

}

- (void)pageControlInitMenuView:(LCHorizontalMenuView *)menuView pageControl:(UIPageControl *)pageControl {
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
}

@end
