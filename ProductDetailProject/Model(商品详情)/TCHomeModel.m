//
//  TCHomeModel.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/9.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCHomeModel.h"

@implementation Banner

@end

@implementation SellHot

@end

@implementation RecommendProduct

@end

@implementation PreferredStore

@end

@implementation SelfSupport

@end

@implementation List

@end

@implementation MallRecommend

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list": @"List",
             };
}
@end

@implementation HomeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"banner": @"Banner",
             @"sellHot": @"SellHot",
             @"todayRecommed": @"RecommendProduct",
             @"recommendProduct": @"RecommendProduct",
             @"preferredStore": @"PreferredStore",
             @"selfSupport": @"SelfSupport",
             @"mallRecommend": @"MallRecommend",
             };
}
@end
