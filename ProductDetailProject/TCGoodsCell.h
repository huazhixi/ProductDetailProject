//
//  TCGoodsCell.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/3.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCHomeModel.h"

@interface TCGoodsCell : UICollectionViewCell
/**     */
@property (strong, nonatomic) RecommendProduct *goodsModel;
/**     */
@property (nonatomic, assign) BOOL isDiancang;
@end
