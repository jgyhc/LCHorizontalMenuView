//
//  MJViewController.m
//  LCHorizontalMenuView
//
//  Created by jgyhc on 06/08/2020.
//  Copyright (c) 2020 jgyhc. All rights reserved.
//

#import "MJViewController.h"
#import "LCHorizontalMenuView.h"
#import "LCHorizontalMenuBaseCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import <LCPageControl.h>

@interface MJViewController ()<LCHorizontalMenuViewDataSource, LCHorizontalMenuViewDelegate>

@property (weak, nonatomic) IBOutlet LCHorizontalMenuView *menuView;



@end

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
}

- (NSInteger)numberOfIndexInHorizontalMenuView:(LCHorizontalMenuView *)menuView {
    return 20;
}

- (void)dataAssignmentWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index cell:(LCHorizontalMenuBaseCollectionViewCell *)cell {
    //这里可以赋值
    cell.label.text = @"测试";
    [cell.imageView setBackgroundColor:[UIColor colorWithRed:251/255.0 green:236/255.0 blue:192/255.0 alpha:1.0]];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://upload.jianshu.io/users/upload_avatars/2259045/5d2e817c-f862-4c4f-b8c0-83ce96e8331b.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"] placeholderImage:nil];

}

- (BOOL)isShowPageControl:(LCHorizontalMenuView *)menuView {
    return YES;
}

- (UIView *)customPageControlMenuView:(LCHorizontalMenuView *)menuView numberOfPages:(NSInteger)numberOfPages {
    LCPageControl *pageControl = [[LCPageControl alloc]init];
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = 0;
    return pageControl;
}

- (void)pageUpdateWithMenuView:(LCHorizontalMenuView *)menuView pageControl:(LCPageControl *)pageControl currentPage:(NSInteger)currentPage {
    pageControl.currentPage = currentPage;
    
}

- (NSInteger)numOfRowsPerPageInHorizontalMenuView:(LCHorizontalMenuView *)horizontalMenuView {
    return 2;
}

/// 设置每页的列数 默认 4
/// @param horizontalMenuView horizontalMenuView 当前控件
- (NSInteger)numOfColumnsPerPageInHorizontalMenuView:(LCHorizontalMenuView *)horizontalMenuView {
    return 5;
}


- (void)didSelectItemWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index {
    NSLog(@"%ld", index);
}
//- (void)pageControlInitMenuView:(LCHorizontalMenuView *)menuView pageControl:(UIPageControl *)pageControl {
//    pageControl.pageIndicatorTintColor = [UIColor redColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
//}

@end
