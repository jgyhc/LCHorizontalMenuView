//
//  LCHorizontalMenuBaseCollectionViewCell.m
//  LCHorizontalMenuView_Example
//
//  Created by manjiwang on 2020/6/8.
//  Copyright © 2020 jgyhc. All rights reserved.
//

#import "LCHorizontalMenuBaseCollectionViewCell.h"
#import "Masonry.h"

@interface LCHorizontalMenuBaseCollectionViewCell ()

@end

@implementation LCHorizontalMenuBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initImageTitleView];
    }
    return self;
}


- (void)initImageTitleView {
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(8);
        make.left.right.mas_equalTo(self);
    }];
}


- (UILabel *)label {
    if (!_label) {
        _label = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _label;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}


@end
