//
//  LCCustomCellViewController.m
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/7/2.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import "LCCustomCellViewController.h"
#import "LCHorizontalMenuView.h"

@interface LCCustomCellViewController ()<LCHorizontalMenuViewDataSource, LCHorizontalMenuViewDelegate>
@property (weak, nonatomic) IBOutlet LCHorizontalMenuView *menuView;


@end

@implementation LCCustomCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
}


- (NSInteger)numberOfIndexInHorizontalMenuView:(LCHorizontalMenuView *)menuView {
    return 20;
}

//注册cell
- (void)registerCellWithMenuView:(LCHorizontalMenuView *)menuView collectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[UINib nibWithNibName:@"LCCustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"LCCustomCollectionViewCell"];
}

//设置cell
- (UICollectionViewCell *)menuView:(LCHorizontalMenuView *)menuView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"LCCustomCollectionViewCell" forIndexPath:indexPath];
}

@end

