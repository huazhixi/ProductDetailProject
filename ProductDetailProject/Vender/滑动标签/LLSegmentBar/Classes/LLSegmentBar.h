//
//  LLSegmentBar.h
//  LLSegmentBar
//
//  Created by liushaohua on 2017/6/3.
//  Copyright © 2017年 416997919@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSegmentBarConfig.h"

@class LLSegmentBar;

@protocol LLSegmentBarDelegate <NSObject>

/**
  通知外界内部的点击数据

 @param segmentBar segmentBar
 @param toIndex 选中的索引从0 开始
 @param fromIndex 上一个索引
 */
- (void)segmentBar:(LLSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface LLSegmentBar : UIView

/**
 快速创建一个选项卡控件

 @param frame frame
 @return segment
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;
/**代理*/
@property (nonatomic,weak) id<LLSegmentBarDelegate> delegate;
/**数据源*/
@property (nonatomic, strong)NSArray<NSString *> *items;
/**当前选中的索引，双向设置*/
@property (nonatomic,assign) NSInteger selectIndex;

- (void)updateWithConfig:(void(^)(LLSegmentBarConfig *config))configBlock;

- (void)showPointAtIndex:(int)index;

- (void)hidePointAtIndex:(int)index;

@end
