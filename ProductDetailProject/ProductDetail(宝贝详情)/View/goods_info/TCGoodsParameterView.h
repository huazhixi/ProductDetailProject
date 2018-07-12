//
//  TCGoodsParameterView.h
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCGoodsModel.h"

@interface TCGoodsParameterView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureBtnConstrain;

@property (nonatomic, copy) void (^goodsParamViewBlock)();
/**     */
@property (strong, nonatomic) NSArray *paramsArray;
@end
