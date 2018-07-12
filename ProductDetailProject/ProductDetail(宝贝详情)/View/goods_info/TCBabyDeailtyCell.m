//
//  TCBabyDeailtyCell.m
//  TCMall
//
//  Created by 栗子 on 2018/1/29.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCBabyDeailtyCell.h"

@implementation TCBabyDeailtyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)chooseGuigeBtnClick {
    if (_babyDealtyCellGuiGeBlock) {
        _babyDealtyCellGuiGeBlock();
    }
}
- (IBAction)goodsParamBtnClick {
    if (_babyDealtyCellGoodsParamBlock) {
        _babyDealtyCellGoodsParamBlock();
    }
}
- (IBAction)youhuijuanBtnClick {
    if (_babyDealtyCellYouhuiBlock) {
        _babyDealtyCellYouhuiBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
