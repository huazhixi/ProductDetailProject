//
//  TCGoodsCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/3.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCGoodsCell.h"
#import "Masonry.h"
#import <YYText/YYText.h>
#import "UIImageView+WebCache.h"

//包括协议、地址、端口号...。含“/”，如果 URL_IMG_PREFIX 为空，则不含。
static NSString *const URL_IMG_PREFIX = @"http://tp.homebank.shop";

@interface TCGoodsCell()
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 实时价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 商场价格 */
@property (strong , nonatomic)UILabel *shopLabel;

@end

@implementation TCGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewCell];
    }
    return self;
}
- (void)setIsDiancang:(BOOL)isDiancang {
    _isDiancang = isDiancang;
    
}
- (void)setGoodsModel:(RecommendProduct *)goodsModel {
    _goodsModel = goodsModel;
    
    __weak typeof(self) _weakSelf = self;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, goodsModel.default_image]] placeholderImage:[UIImage imageNamed:@"goodsPlaceHolderImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            _weakSelf.goodsImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                _weakSelf.goodsImageView.alpha = 1.0f;
            }];
        } else {
            _weakSelf.goodsImageView.alpha = 1.0f;
        }
    }];
    
    if (_isDiancang) {//如果电子仓库商品添加  电仓 图标
        
        NSString *goodsName = goodsModel.goods_name;
        NSMutableAttributedString *goodsNameAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", goodsName]];
        goodsNameAttributeStr.yy_font = [UIFont boldSystemFontOfSize:14];
        goodsNameAttributeStr.yy_color = [UIColor lightGrayColor];
        goodsNameAttributeStr.yy_lineSpacing = 5;
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"diancang"];
        attach.bounds = CGRectMake(0, -3, 45, 15);
        NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
        [goodsNameAttributeStr insertAttributedString:attributeStr2 atIndex:0];
        _goodsLabel.attributedText = goodsNameAttributeStr;
        
    } else {
        if (goodsModel.store_id == 1) {//判断是否是自营商品，添加自营图标
            
            NSString *goodsName = goodsModel.goods_name;
            NSMutableAttributedString *goodsNameAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", goodsName]];
            goodsNameAttributeStr.yy_font = [UIFont boldSystemFontOfSize:14];
            goodsNameAttributeStr.yy_color = [UIColor lightGrayColor];
            goodsNameAttributeStr.yy_lineSpacing = 5;
            
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            attach.image = [UIImage imageNamed:@"self_buy_normal"];
            attach.bounds = CGRectMake(0, -3, 45, 15);
            NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
            [goodsNameAttributeStr insertAttributedString:attributeStr2 atIndex:0];
            _goodsLabel.attributedText = goodsNameAttributeStr;
        } else {
            _goodsLabel.text = goodsModel.goods_name;
        }
    }
    
    if (goodsModel.store_id == 72) {// 天元
        
        if (goodsModel.goods_id == 1297) {
            _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", goodsModel.price];
        } else {
            NSString *price = [NSString stringWithFormat:@"  %.2f", goodsModel.price];
            NSMutableAttributedString *priceAttributeStr = [[NSMutableAttributedString alloc] initWithString:price];
            priceAttributeStr.yy_font = [UIFont systemFontOfSize:14];
            priceAttributeStr.yy_color = [UIColor lightGrayColor];
            
            NSTextAttachment *attach = [[NSTextAttachment alloc] init];
            attach.image = [UIImage imageNamed:@"tianyuan_color"];
            attach.bounds = CGRectMake(0, -3, 15, 15);
            NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
            [priceAttributeStr insertAttributedString:attributeStr2 atIndex:0];
            _priceLabel.attributedText = priceAttributeStr;
        }
    } else {
        _priceLabel.text = [NSString stringWithFormat:@"￥%@", [NSString stringWithFormat:@"%.2f", goodsModel.price]];
    }
}

- (void)setupViewCell {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _goodsImageView.clipsToBounds = YES;
//    [_goodsImageView setImage:IMAGE(GOODS_PLACE_HOLDER)];
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = [UIFont systemFontOfSize:12];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString *str = @" 蓝天伏特加 原味 750ml 伏特加";
    
    NSMutableAttributedString *attributeStr1 = [[NSMutableAttributedString alloc] initWithString:str];
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,
                                   [UIColor lightGrayColor],NSForegroundColorAttributeName,nil];
    [attributeStr1 addAttributes:attributeDict range:NSMakeRange(0, attributeStr1.length)];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"self_buy_normal"];
    NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
    [attributeStr1 insertAttributedString:attributeStr2 atIndex:0];
    _goodsLabel.attributedText = attributeStr1;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.text = @"￥200.00";
    [self addSubview:_priceLabel];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(self.mas_width);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.offset(40);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsLabel.mas_bottom);
        make.left.equalTo(self.goodsLabel);
        make.height.offset(20);
    }];
}

@end
