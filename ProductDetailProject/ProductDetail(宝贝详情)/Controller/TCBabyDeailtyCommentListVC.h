//
//  TCBabyDeailtyCommentListVC.h
//  TCMall
//
//  Created by 栗子 on 2018/2/1.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "BaseViewController.h"
#import "TCGoodsCommentListsCell.h"
#import "TCCommentModel.h"

static NSString *const TCGoodsCommentListsCellID = @"TCGoodsCommentListsCell";

@interface TCBabyDeailtyCommentListVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *commentListView;
/**     */
@property (strong, nonatomic) NSMutableArray *commentArray;
/**   */
@property (nonatomic, copy) NSString *type;
/**   */
@property (nonatomic, copy) NSString *goodsID;
@end
