//
//  TCPropertyCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/13.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCPropertyCell.h"
#import "Masonry.h"
#import "02 Macro.h"
#import "03 Constant.h"

@implementation TCPropertyCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupViewCell];
    }
    return self;
}

- (void)setupViewCell {
    
    ViewRadius(self, 5);
    
    _propertyL = [UILabel new];
    _propertyL.textColor = [UIColor blackColor];
    _propertyL.font = [UIFont systemFontOfSize:14];
    _propertyL.numberOfLines = 0;
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.text = @"属性";
    [self.contentView addSubview:_propertyL];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.equalTo(self.contentView).offset(0);
    }];
}

@end
