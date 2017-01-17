//
//  UITableView+Placeholder.m
//  PlaceholderViewForTableView
//
//  Created by JackyLee on 17/1/16.
//  Copyright © 2017年 JackyLee. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import "NSObject+Swizz.h"
#import "XYPlaceholderView.h"
#import <objc/runtime.h>


@interface UITableView () <UITableViewDataSource>

@property (nonatomic,strong) XYPlaceholderView *placeholderView;

@end

@implementation UITableView (Placeholder)

// 交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzSelector:@selector(reloadData) withSwizzSelector:@selector(swi_reloadData)];
    });
}


- (void)swi_reloadData {
    [self swi_reloadData];
    
    // 处理tableview是否为空
    BOOL empty = [self checkTableViewEmpty];
    if (empty) {
        [self addSubview:self.placeholderView];
    }
    self.placeholderView.hidden = !empty;
    self.backgroundColor = [UIColor redColor];
}


- (BOOL)checkTableViewEmpty {
    
    // 默认不为空
    BOOL empty = NO;
    
    id<UITableViewDataSource> datasource = self.dataSource;
    if ([datasource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        
        NSInteger sections = [datasource numberOfSectionsInTableView:self];
        
        // 若组数为0，则为空视图
        if (sections == 0) {
            empty = YES;
        }
        
        // 组数不为0，便利每一组的行数，若有一组不为0，则
        else {
            
            for (int i = 0; i<sections; i++) {
                NSInteger rows = [datasource tableView:self numberOfRowsInSection:i];
                if (rows != 0) {
                    empty = NO;
                    break;
                }else {
                    empty = YES;
                }
            }
        }
    }
    
    return empty;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderView.frame = self.bounds;
}

- (XYPlaceholderView *)placeholderView {
    XYPlaceholderView *placeholder = objc_getAssociatedObject(self, _cmd);
    if (!placeholder) {
        placeholder = [[XYPlaceholderView alloc] init];
        objc_setAssociatedObject(self, _cmd, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholder.backgroundColor = [UIColor blueColor];
    }
    return placeholder;
}


@end
