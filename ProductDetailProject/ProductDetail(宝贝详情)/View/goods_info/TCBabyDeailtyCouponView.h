//
//  TCBabyDeailtyCouponView.h
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCGetCouponCell.h"

static NSString *const TCGetCouponCellID = @"TCGetCouponCell";

@interface TCBabyDeailtyCouponView : UIView<UITableViewDelegate, UITableViewDataSource, TCGetCouponCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shopNameLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeBtnConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downViewConstraint;
@property (nonatomic, copy) void (^bayDeailtyCouponBlock) ();
/**     */
@property (strong, nonatomic) NSArray *couponArray;
/**     */
@property (strong, nonatomic) NSString *store_id;
@end
