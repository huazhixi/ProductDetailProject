//
//  TCGoodsAddressModel.m
//  TCMall
//
//  Created by Huazhixi on 2018/6/26.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCGoodsAddressModel.h"

@implementation TCGoodsCityList

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"name": @"cityName"
             };
}
@end

@implementation TCGoodsAddressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"name": @"provinceName",
             @"citylist": @"cityList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"citylist": @"TCGoodsCityList"
             };
}

@end
