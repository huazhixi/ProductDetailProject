//
//  TCGoodsInfoTableViewCell.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCGoodsModel.h"
@class TCGoodsInfoTableViewCell;
@protocol  TCGoodsInfoTableViewCellDelegate<NSObject>
@optional
- (void)goodsInfoCellChooseAddressWithIndex:(NSIndexPath *)indexPath;

- (void)goodsInfoTableViewCellCollect:(UIButton *)button;
@end
@interface TCGoodsInfoTableViewCell : UITableViewCell
/**     */
@property (strong, nonatomic) TCGoodsModel *goodsModel;
/**     */
@property (strong, nonatomic) Position *position;
/**   */
@property (nonatomic, copy) NSString *chooseAddress;

@property (nonatomic, assign) NSIndexPath *indexPath;

@property (weak, nonatomic) id<TCGoodsInfoTableViewCellDelegate>delegate;
@end
