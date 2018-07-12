//
//  TCBabyDetailMoreJudgeTableViewCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/3/7.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCBabyDetailMoreJudgeTableViewCell.h"

@interface TCBabyDetailMoreJudgeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *seeAllJudgeButton;

@end

@implementation TCBabyDetailMoreJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.seeAllJudgeButton.layer.borderColor = RGB0X(0xF1081B).CGColor;
}
- (IBAction)moreBtnClick {
    if (_moreJudgeCellBlock) {
        _moreJudgeCellBlock();
    }
}


@end
