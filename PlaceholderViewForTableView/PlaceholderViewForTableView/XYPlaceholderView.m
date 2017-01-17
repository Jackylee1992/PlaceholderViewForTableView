//
//  XYPlaceholderView.m
//  PlaceholderViewForTableView
//
//  Created by JackyLee on 17/1/17.
//  Copyright © 2017年 JackyLee. All rights reserved.
//

#import "XYPlaceholderView.h"

@interface XYPlaceholderView ()
// 占位图片
@property (nonatomic,strong) UIImageView *imageView;
// 占位文字
@property (nonatomic,strong) UILabel *titleLabel;


@end

@implementation XYPlaceholderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        
    }
    return self;
}

- (void)setup {
    
    // 占位图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"airport"]];
    [self addSubview:imageView];
    imageView.center = CGPointMake(self.center.x, 150);
    
    
    // 占位文字
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"暂无数据";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(self.center.x, imageView.bounds.origin.y+imageView.bounds.size.height+20);
    [self addSubview:titleLabel];
    
    self.imageView = imageView;
    self.titleLabel = titleLabel;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.center = CGPointMake(self.center.x, [UIScreen mainScreen].bounds.size.height * 0.4);
    self.titleLabel.center = CGPointMake(self.center.x, self.imageView.bounds.origin.y+self.imageView.bounds.size.height+40);
    
}

@end
