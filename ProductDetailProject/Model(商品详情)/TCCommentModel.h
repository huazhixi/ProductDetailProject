//
//  TCCommentModel.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/8.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCGoodsModel.h"

@interface TCCommentModel : NSObject
@property (nonatomic , assign) NSInteger              current_page;
@property (nonatomic , assign) NSInteger              last_page;
@property (nonatomic , assign) NSInteger              per_page;
@property (nonatomic , copy) NSArray<Comment *>              * data;
@property (nonatomic , assign) NSInteger              total;

@end
