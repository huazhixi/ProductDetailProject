//
//  XPSemiModalConfiguration.h
//  Example
//
//  Created by nhope on 2018/1/12.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPSemiModalConfiguration : NSObject

/// 点击模态窗口之外的区域是否关闭模态窗口, 默认`YES`
@property (nonatomic, assign, getter=isShouldDismissModal) BOOL shouldDismissModal;

/// 是否使用阴影效果, 默认`YES`
@property (nonatomic, assign, getter=isEnableShadow) BOOL enableShadow;
/// 阴影透明度, 0.0~1.0, 默认`0.8`
@property (nonatomic, assign) CGFloat shadowOpacity;
/// 阴影圆角, 默认`5.0`
@property (nonatomic, assign) CGFloat shadowRadius;

/// 是否启用背景动画, 默认`YES`
@property (nonatomic, assign, getter=isEnableBackgroundAnimation) BOOL enableBackgroundAnimation;
/// 背景颜色(需要设置`enableBackgroundAnimation`为YES), 默认`blackColor`
@property (nonatomic, strong) UIColor *backgroundColor;
/// 背景图片(需要设置`enableBackgroundAnimation`为YES), 默认`nil`
@property (nonatomic, strong) UIImage *backgroundImage;

/// 背景透明度, 0.0~1.0, 默认`0.3`
@property (nonatomic, assign) CGFloat backgroundOpacity;


+ (instancetype)defaultConfiguration;

@end
