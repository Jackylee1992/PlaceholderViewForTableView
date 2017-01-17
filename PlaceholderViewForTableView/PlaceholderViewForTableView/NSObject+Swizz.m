//
//  NSObject+Swizz.m
//  PlaceholderViewForTableView
//
//  Created by JackyLee on 17/1/16.
//  Copyright © 2017年 JackyLee. All rights reserved.
//

#import "NSObject+Swizz.h"
#import <objc/runtime.h>

@implementation NSObject (Swizz)


+ (void)swizzSelector:(SEL)oriSelector withSwizzSelector:(SEL)swiSelector {
    Method oriMethod = class_getInstanceMethod([self class], oriSelector);
    Method swiMethod = class_getInstanceMethod([self class], swiSelector);
    
    // 若能成功添加新的方法则替换系统方法，如果不能则交换方法实现
    BOOL result = class_addMethod([self class], oriSelector, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (result) {
        class_replaceMethod([self class], swiSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else {
        method_exchangeImplementations(oriMethod, swiMethod);
    }
    
}

@end
