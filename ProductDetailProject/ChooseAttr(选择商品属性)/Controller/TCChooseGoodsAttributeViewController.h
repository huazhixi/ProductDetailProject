//
//  TCChooseGoodsAttributeViewController.h
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCConfirmOrderModel.h"
#import "TCGoodsModel.h"

@interface TCChooseGoodsAttributeViewController : UIViewController
/**   */
@property (nonatomic, copy) NSString *goods_id;
/** 是否从购物车弹出  */
@property (nonatomic, assign) BOOL isFromBuyCart;

@property (nonatomic,strong)UIViewController *fatherVC;
/**     */
@property (strong, nonatomic) TCGoodsModel *goodsModel;
/**   */
@property (nonatomic, copy) NSString *goods_img;
/**     */
@property (nonatomic, assign) NSInteger store_id;

@property (nonatomic, assign) BOOL fromBuyNowBtn;
@end
