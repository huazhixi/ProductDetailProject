//
//  TCCountFooterView.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/13.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCCountFooterView.h"
#import "Masonry.h"

@implementation TCCountFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.userInteractionEnabled = YES;
        [self setupViewCell];
    }
    return self;
}

- (void)setupViewCell {
    
    _countLbl = [UILabel new];
    _countLbl.text = @"数量";
    _countLbl.textColor = [UIColor blackColor];
    _countLbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:_countLbl];
    
    _numberButton = [PPNumberButton new];
    // 开启抖动动画
    _numberButton.shakeAnimation = YES;
    //设置边框颜色
    _numberButton.borderColor = [UIColor blackColor];
    // 设置最小值
    _numberButton.minValue = 1;
    // 设置最大值
    _numberButton.maxValue = 10;
    //输入框中的内容
    _numberButton.currentNumber = 0;
    // 设置输入框中的字体大小
    _numberButton.inputFieldFont = 14;
    _numberButton.increaseTitle = @"＋";
    _numberButton.decreaseTitle = @"－";
    __weak typeof(self) _weakSelf = self;
    _numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
        _weakSelf.changeNumCellBlock ? _weakSelf.changeNumCellBlock(number) : nil;
    };
    [self addSubview:_numberButton];
    
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self.numberButton);
    }];
    
    [_numberButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.offset(150);
        make.height.offset(35);
    }];
}

- (void)setMaxValue:(NSInteger)maxValue {
    _maxValue = maxValue;
    _numberButton.maxValue = maxValue;
}

@end
