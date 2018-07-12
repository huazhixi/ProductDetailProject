//
//  TCBabyDeailtyCouponView.m
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCBabyDeailtyCouponView.h"

@implementation TCBabyDeailtyCouponView
-(void)awakeFromNib {
    [super awakeFromNib];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[TCGetCouponCell class] forCellReuseIdentifier:TCGetCouponCellID];
    _closeBtnConstrain.constant = kTabbarSafeBottomMargin;
}

- (void)setCouponArray:(NSArray *)couponArray {
    _couponArray = couponArray;

    [_tableView reloadData];
}

- (void)setStore_id:(NSString *)store_id {
    _store_id = store_id;
    
    [self fetchShopCouponData];
}
#pragma mark - 网络加载
/**
 店铺优惠券列表数据获取
 */
- (void)fetchShopCouponData {
    
    typeof(self) _weakSelf = self;
    [EasyLoadingView showLoading];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"store_id"] = self.store_id;
    
    [[HRRequest manager] POST:@"Coupon/index" para:params success:^(id data) {
        [EasyLoadingView hidenLoading];
        NSLog(@"%@", data);
        NSArray *tempArray = [CouponData mj_objectArrayWithKeyValuesArray:data[@"data"]];
        _weakSelf.couponArray = tempArray;
        [_weakSelf.tableView reloadData];
    } faiulre:^(NSString *errMsg) {
        [EasyLoadingView hidenLoading];
        if ([errMsg isEqual:ERROR_MESSAGE] || [errMsg isEqual:NET_NOT_WORK]) {
            [EasyTextView showErrorText:errMsg];
        } else {
            [EasyTextView showInfoText:errMsg];
        }
    }];
}
/**
 店铺优惠券  领取优惠券
 */
- (void)getShopCouponWithCouponID:(NSString *)couponID {
    
    typeof(self) _weakSelf = self;
    [EasyLoadingView showLoading];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"coupon_id"] = couponID;
    
    [[HRRequest manager] POST:@"Coupon/receiveCoupon" para:params success:^(id data) {
        [EasyLoadingView hidenLoading];
        NSLog(@"%@", data);
        NSString *message = data[@"message"];
        [EasyTextView showSuccessText:message];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 领取过后，重新加载数据
            [_weakSelf fetchShopCouponData];
        });
        
    } faiulre:^(NSString *errMsg) {
        [EasyLoadingView hidenLoading];
        if ([errMsg isEqual:ERROR_MESSAGE] || [errMsg isEqual:NET_NOT_WORK]) {
            [EasyTextView showErrorText:errMsg];
        } else {
            [EasyTextView showInfoText:errMsg];
        }
    }];
}
#pragma mark - TCGetCouponCellDelegate
- (void)getCouponCellBtnClick:(NSIndexPath *)indexPath {
    CouponData *model = self.couponArray[indexPath.row];
    [self getShopCouponWithCouponID:s_Integer(model.coupon_id)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _couponArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCGetCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:TCGetCouponCellID];
    cell.model = _couponArray[indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_PAD) {
        return 80;
    }
    return 80 *TCRatio;
}
- (IBAction)dismissBtnClick {
    if (_bayDeailtyCouponBlock) {
        _bayDeailtyCouponBlock();
    }
}

@end
