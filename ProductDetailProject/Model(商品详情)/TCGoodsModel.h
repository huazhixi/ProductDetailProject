//
//  TCGoodsModel.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendProduct;

@interface GoodsInfo :NSObject
@property (nonatomic , copy) NSArray<NSString *>              * banner;
@property (nonatomic , assign) NSInteger              sales;
@property (nonatomic , assign) float                price;
@property (nonatomic , assign) float               market_price;
@property (nonatomic , assign) NSInteger              store_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , assign) NSInteger              cart_id;
@property (nonatomic , copy) NSString              * specification;
@property (nonatomic , assign) NSInteger              quantity;
@property (nonatomic , assign) NSInteger              created_at;
@property (nonatomic , copy) NSString              * goods_image;
@property (nonatomic , copy) NSString              * default_image;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * goods_old_price;
@property (nonatomic , assign) NSInteger              spec_id;
@property (nonatomic , assign) NSInteger              updated_at;
@property (nonatomic , assign) NSInteger              goods_type;
@property (nonatomic , assign) NSInteger              promotions_id;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * unit_name;
@property (nonatomic , copy) NSString              * express_info;
@property (nonatomic , copy) NSString              * sale_service;

// 商品左侧按钮是否选中
@property (nonatomic,assign) BOOL productIsChoosed;
@end

@interface StoreInfo :NSObject
@property (nonatomic , assign) NSInteger              sgrade;
@property (nonatomic , copy) NSString              * evaluation_service;
@property (nonatomic , assign) NSInteger              collectCount;
@property (nonatomic , assign) NSInteger              goodsCount;
@property (nonatomic , copy) NSString              * evaluation_speed;
@property (nonatomic , copy) NSString              * store_name;
@property (nonatomic , copy) NSString              * store_logo;
@property (nonatomic , assign) NSInteger              store_id;
@property (nonatomic , assign) NSInteger              newCount;
@property (nonatomic , copy) NSString              * evaluation_desc;

@property (nonatomic , copy) NSString              * background_img;
@property (nonatomic , copy) NSArray<NSString *>              * store_banner;
@property (nonatomic , assign) NSInteger              collection;
@property (nonatomic , assign) NSInteger              fans;
@property (nonatomic , copy) NSString              * key_words;
@property (nonatomic , copy) NSString              * tel;
@property (nonatomic , copy) NSString              * store_qq;

@end

@interface Comment :NSObject
@property (nonatomic , copy) NSArray<NSString *>              * images;
@property (nonatomic , assign) NSInteger              evaluation;
@property (nonatomic , copy) NSString              * buyer_name;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * specification;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , assign) NSInteger              comment_time;

@end

@interface Parameter :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * value;

@end

@interface Position :NSObject
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , assign) float              freight;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , assign) float              fee;

@end

@interface TCGoodsModel : NSObject
@property (nonatomic , strong) GoodsInfo              * goodsInfo;
@property (nonatomic , strong) StoreInfo              * storeInfo;
@property (nonatomic , copy) NSArray<Comment *>              * comment;
@property (nonatomic , copy) NSArray<RecommendProduct *>              * recommend;
@property (nonatomic , copy) NSArray<Parameter *>              * parameter;
@property (nonatomic , strong) Position              * position;
@property (nonatomic , assign) NSInteger              commentCount;
@property (nonatomic , assign) NSInteger              goodCount;
@property (nonatomic , assign) NSInteger              commonlyCoun;
@property (nonatomic , assign) NSInteger              badCount;
@property (nonatomic , assign) NSInteger              pictureCount;
@property (nonatomic , assign) NSInteger              collection;
@property (nonatomic , copy) NSString              * descHtml;
@end
