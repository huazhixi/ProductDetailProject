//
//  TCRecommandTableViewCell.h
//  TCMall
//
//  Created by Huazhixi on 2018/3/7.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCGoodsModel.h"

@interface TCRecommandTableViewCell : UITableViewCell
/**     */
@property (strong, nonatomic) NSArray *recommendArray;
/**     */
@property (nonatomic, assign) BOOL isDiancang;

@end
