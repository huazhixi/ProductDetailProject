
//
//  TCPropertyHeader.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/13.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCPropertyHeader.h"
#import "Masonry.h"

@implementation TCPropertyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViewCell];
    }
    return self;
}

- (void)setupViewCell {
    _headernameL = [UILabel new];
    _headernameL.textColor = [UIColor blackColor];
    _headernameL.font = [UIFont systemFontOfSize:14];
    _headernameL.numberOfLines = 0;
    _headernameL.text = @"属性名字";
    [self addSubview:_headernameL];
    
    [_headernameL mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
}
@end
