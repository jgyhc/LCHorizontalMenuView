//
//  LCCustomPageControlViewController.m
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/7/2.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import "LCCustomPageControlViewController.h"
#import <LCPageControl.h>
#import "LCHorizontalMenuView.h"

@interface LCCustomPageControlViewController ()<LCHorizontalMenuViewDataSource, LCHorizontalMenuViewDelegate>

@property (weak, nonatomic) IBOutlet LCHorizontalMenuView *menuView;

@end

@implementation LCCustomPageControlViewController

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

@end
