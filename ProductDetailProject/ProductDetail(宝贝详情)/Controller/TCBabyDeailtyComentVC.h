//
//  TCBabyDeailtyComentVC.h
//  TCMall
//
//  Created by 栗子 on 2018/1/29.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNatigationViewController.h"

#import "TCGoodsModel.h"

@interface TCBabyDeailtyComentVC : BaseViewController

@property (nonatomic,strong)LLSegmentBar *segmentBar;

@property (nonatomic,strong)BaseNatigationViewController *baseNavController;

@property (nonatomic,strong)UIViewController *fatherVC;
/**   */
@property (nonatomic, copy) NSString *goodsID;
/**     */
@property (strong, nonatomic) TCGoodsModel *goodsModel;
@end
