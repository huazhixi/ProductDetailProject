//
//  TCGoodsParameterView.m
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCGoodsParameterView.h"
#import "03 Constant.h"
#import "02 Macro.h"

@implementation TCGoodsParameterView
-(void)awakeFromNib {
    [super awakeFromNib];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _sureBtnConstrain.constant = kTabbarSafeBottomMargin;
}

- (IBAction)dismissView {
    if (_goodsParamViewBlock) {
        _goodsParamViewBlock();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _paramsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paramsCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paramsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _paramsArray[indexPath.row];
    cell.textLabel.font = H12;
    cell.textLabel.textColor = RGB0X(0x666666);
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
