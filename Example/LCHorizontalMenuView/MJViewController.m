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
}

- (void)didSelectItemWithMenuView:(LCHorizontalMenuView *)menuView index:(NSInteger)index {
    NSLog(@"%ld", index);
}



@end
