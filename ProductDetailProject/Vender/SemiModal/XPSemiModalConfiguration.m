//
//  XPSemiModalConfiguration.m
//  Example
//
//  Created by nhope on 2018/1/12.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "XPSemiModalConfiguration.h"

@implementation XPSemiModalConfiguration

+ (instancetype)defaultConfiguration {
    return [[XPSemiModalConfiguration alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _shouldDismissModal = YES;
        
        _enableShadow = YES;
        _shadowRadius = 5.0;
        _shadowOpacity = 0.8;
        
        _enableBackgroundAnimation = YES;
        _backgroundColor = [UIColor blackColor];
        _backgroundOpacity = 0.3;
    }
    return self;
}

@end
