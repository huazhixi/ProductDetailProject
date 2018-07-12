//
//  TCAttributeModel.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AttributeInfo : NSObject
@property (nonatomic , copy) NSString              * tabName;
@property (nonatomic , copy) NSString              * tabValue;
@end

@interface Attribute : NSObject
@property (nonatomic , assign) NSInteger              product_id;
@property (nonatomic , assign) NSInteger              spec_id;
@property (nonatomic , copy) NSString              * spec_1;
@property (nonatomic , copy) NSString              * spec_2;
@property (nonatomic , copy) NSString              * spec_3;
@property (nonatomic , copy) NSString              * spec_4;
@property (nonatomic , assign) float               price;
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSArray<AttributeInfo *>              * info;

@end

@interface AttributeCategery : NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSArray<NSString *>              * value;
@end

@interface TCAttributeModel : NSObject

@property (nonatomic , copy) NSArray<AttributeCategery *>              * spec;
@property (nonatomic , copy) NSArray<Attribute *>              * list;
@end
