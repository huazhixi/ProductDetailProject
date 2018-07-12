//
//  TCPropertyFooter.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/13.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCPropertyFooter.h"
#import "Masonry.h"

@implementation TCPropertyFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViewCell];
    }
    return self;
}

- (void)setupViewCell {
    _line = [UIView new];
    _line.backgroundColor = [UIColor lightTextColor];
    [self addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.right.equalTo(self).offset(0);
        make.height.offset(1);
    }];
}
@end
