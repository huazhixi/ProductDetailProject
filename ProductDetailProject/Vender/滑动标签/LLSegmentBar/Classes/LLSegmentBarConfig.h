//
//  LLSegmentBarConfig.h
//  LLSegmentBar
//
//  Created by liushaohua on 2017/6/3.
//  Copyright © 2017年 416997919@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLSegmentBarConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *sBBackColor;
@property (nonatomic, strong) UIColor *itemNC;
@property (nonatomic, strong) UIColor *itemSC;
@property (nonatomic, strong) UIFont *itemF;
@property (nonatomic, strong) UIColor *indicatorC;
@property (nonatomic, assign) CGFloat indicatorH;
@property (nonatomic, assign) CGFloat indicatorW;
@property (nonatomic, strong) UIColor *pointColor;

/**默认颜色*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^itemNormalColor)(UIColor *color);
/**选中颜色*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^itemSelectColor)(UIColor *color);
/**背景颜色*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^segmentBarBackColor)(UIColor *color);
/**文字字体大小*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^itemFont)(UIFont *font);
/**指示器颜色*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^indicatorColor)(UIColor *color);
/**指示器高度*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^indicatorHeight)(CGFloat h);
/**指示器宽度*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^indicatorExtraW)(CGFloat w);

/**右上角点的颜色*/
@property (nonatomic, copy, readonly) LLSegmentBarConfig *(^itemPointColor)(UIColor *color);

@end
