//
//  TCBabyDeailtyCell.h
//  TCMall
//
//  Created by 栗子 on 2018/1/29.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCBabyDeailtyCell : UITableViewCell

@property (nonatomic, copy) void (^babyDealtyCellGuiGeBlock)();
@property (nonatomic, copy) void (^babyDealtyCellGoodsParamBlock)();
@property (nonatomic, copy) void (^babyDealtyCellYouhuiBlock)();
@end
