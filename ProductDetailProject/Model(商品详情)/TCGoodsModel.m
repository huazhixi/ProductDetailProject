//
//  TCGoodsModel.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCGoodsModel.h"

@implementation GoodsInfo

@end

@implementation StoreInfo

@end

@implementation Comment

@end

@implementation Parameter

@end

@implementation Position

@end

@implementation TCGoodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"descHtml": @"description"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"comment": @"Comment",
             @"recommend": @"RecommendProduct",
             @"parameter": @"Parameter",
             };
}
@end
