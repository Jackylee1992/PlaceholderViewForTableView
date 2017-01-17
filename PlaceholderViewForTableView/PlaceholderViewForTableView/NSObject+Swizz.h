//
//  NSObject+Swizz.h
//  PlaceholderViewForTableView
//
//  Created by JackyLee on 17/1/16.
//  Copyright © 2017年 JackyLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizz)

+ (void)swizzSelector:(SEL)oriSelector withSwizzSelector:(SEL)swiSelector;

@end
