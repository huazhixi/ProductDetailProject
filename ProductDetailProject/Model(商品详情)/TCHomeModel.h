//
//  TCHomeModel.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/9.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner :NSObject
@property (nonatomic , assign) NSInteger              end_time;
@property (nonatomic , copy) NSString              * link_url;
@property (nonatomic , assign) NSInteger              banner_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              start_time;
@property (nonatomic , copy) NSString              * pname;
@property (nonatomic , copy) NSString              * img_url;

@end

@interface SellHot :NSObject
@property (nonatomic , copy) NSString              * default_image;
@property (nonatomic , assign) NSInteger              goods_id;

@end

@interface RecommendProduct :NSObject
@property (nonatomic , assign) NSInteger              goods_id;
@property (nonatomic , copy) NSString              * default_image;
//@property (nonatomic , copy) NSString              * price;
//@property (nonatomic , copy) NSString              * market_price;
/**     */
@property (nonatomic, assign) float price;
/**     */
@property (nonatomic, assign) float market_price;
@property (nonatomic , assign) NSInteger              store_id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , assign) NSInteger              sales;
@property (nonatomic , copy) NSString              * store_name;
@property (nonatomic , assign) NSInteger              comments;
@property (nonatomic , assign) NSInteger              collects;
@property (nonatomic , assign) NSInteger              stock;
@property (nonatomic , copy) NSString              * units_name;
@property (nonatomic , assign) NSInteger              carts;
@property (nonatomic , copy) NSString              * goods_subname;
@property (nonatomic , assign) NSInteger              orders;
@property (nonatomic , assign) NSInteger              views;

@end

@interface PreferredStore :NSObject
@property (nonatomic , assign) NSInteger              store_id;
@property (nonatomic , copy) NSString              * store_name;
@property (nonatomic , copy) NSString              * store_banner;

@end

@interface SelfSupport :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              category_id;
@property (nonatomic , copy) NSString              * image;

@end

@interface List :NSObject
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              category_id;

@end

@interface MallRecommend :NSObject
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , copy) NSArray<List *>              * list;

@end

@interface HomeModel :NSObject
@property (nonatomic , copy) NSArray<Banner *>              * banner;
@property (nonatomic , copy) NSArray<SellHot *>              * sellHot;
@property (nonatomic , copy) NSArray<RecommendProduct *>              * todayRecommed;
@property (nonatomic , copy) NSArray<RecommendProduct *>              * recommendProduct;
@property (nonatomic , copy) NSArray<PreferredStore *>              * preferredStore;
@property (nonatomic , copy) NSArray<SelfSupport *>              * selfSupport;
@property (nonatomic , copy) NSArray<MallRecommend *>              * mallRecommend;

@end
