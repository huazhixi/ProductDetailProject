//
//  TCAttributeModel.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCAttributeModel.h"

@implementation AttributeInfo

@end

@implementation Attribute

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"info": @"AttributeInfo"
             };
}
@end

@implementation AttributeCategery

@end

@implementation TCAttributeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"spec": @"AttributeCategery",
                    @"list": @"Attribute",
             };
}
@end
