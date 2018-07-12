//
//  TCGoodsAddressModel.h
//  TCMall
//
//  Created by Huazhixi on 2018/6/26.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCGoodsCityList : NSObject

@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * code;
@end

@interface TCGoodsAddressModel : NSObject
@property (nonatomic , copy) NSArray<TCGoodsCityList *>              * citylist;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * code;

@end
