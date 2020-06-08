//
//  LCHorizontalMenuCollectionViewLayout.h
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/6/8.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCHorizontalMenuCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,assign) NSInteger rowCount;

@property (nonatomic,assign) NSInteger columCount;

- (NSInteger)currentPageCount;

@end

NS_ASSUME_NONNULL_END
