//
//  TCGoodsInfoTableViewCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCGoodsInfoTableViewCell.h"

@interface TCGoodsInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *collectImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;
@property (weak, nonatomic) IBOutlet UILabel *expressLbl;
@property (weak, nonatomic) IBOutlet UILabel *costPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *collectLbl;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UILabel *express_infoLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marketLblConstrain;

@end

@implementation TCGoodsInfoTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    _goodsNameLbl.lineBreakMode = NSLineBreakByCharWrapping;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCollectImgView:) name:@"ChangeCollectionImgView" object:nil];
}
- (void)changeCollectImgView:(NSNotification *)notification {
    NSDictionary *dic = notification.object;
    if ([dic[@"message"] isEqual:@"取消收藏"]) {
        _collectImgView.image = IMAGE(@"goodsNotcollected");
        _collectLbl.text = @"收藏";
    } else {
        _collectImgView.image = IMAGE(@"goodscollected");
        _collectLbl.text = @"已收藏";
    }
}
- (void)setChooseAddress:(NSString *)chooseAddress {
    _chooseAddress = chooseAddress;
    _expressLbl.text = chooseAddress;
}
- (void)setPosition:(Position *)position {
    _position = position;
    _costPriceLbl.text = [NSString stringWithFormat:@"%.2f元", position.fee];
}
- (void)setGoodsModel:(TCGoodsModel *)goodsModel {
    _goodsModel = goodsModel;

    _saleNum.text = [NSString stringWithFormat:@"%ld件", goodsModel.goodsInfo.sales];
    _expressLbl.text = [NSString stringWithFormat:@"%@ %@", goodsModel.position.province, goodsModel.position.city];
    _costPriceLbl.text = [NSString stringWithFormat:@"%.2f元", goodsModel.position.freight];
    _express_infoLbl.text = goodsModel.goodsInfo.express_info;
    
    NSString *marketPrice = [NSString stringWithFormat:@"￥%@", [NSString stringWithFormat:@"%.2f", goodsModel.goodsInfo.market_price]];
    NSAttributedString *attrMarketPrice = [[NSAttributedString alloc] initWithString:marketPrice attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName : [UIFont systemFontOfSize:10],NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor lightGrayColor]}];
    _marketPrice.attributedText = attrMarketPrice;
    
    if (goodsModel.collection) {//是否收藏：0未收藏，1收藏
        _collectLbl.text = @"已收藏";
        _collectImgView.image = IMAGE(@"goodscollected");
        _collectBtn.selected = YES;
    } else {
        _collectLbl.text = @"收藏";
        _collectImgView.image = IMAGE(@"goodsNotcollected");
        _collectBtn.selected = NO;
    }
    
    if (goodsModel.goodsInfo.store_id == 1) {//判断是否是自营商品，添加自营图标

        NSString *goodsName = goodsModel.goodsInfo.goods_name;
        NSMutableAttributedString *goodsNameAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", goodsName]];
        goodsNameAttributeStr.yy_font = [UIFont boldSystemFontOfSize:14];
        goodsNameAttributeStr.yy_color = MAIN_TEXT_COLOR;

        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"self_buy_normal"];
        attach.bounds = CGRectMake(0, -3, 45, 15);
        NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
        [goodsNameAttributeStr insertAttributedString:attributeStr2 atIndex:0];
        _goodsNameLbl.attributedText = goodsNameAttributeStr;
    } else {
        _goodsNameLbl.text = goodsModel.goodsInfo.goods_name;
    }
    
    if (goodsModel.goodsInfo.store_id == 72) {// 天元商品
        NSMutableAttributedString *goodsNameAttributeStr = [[NSMutableAttributedString alloc] initWithString:@" 天元"];
        goodsNameAttributeStr.yy_font = [UIFont boldSystemFontOfSize:14];
        goodsNameAttributeStr.yy_color = NORMAL_TEXT_COLOR;
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"tianyuan_color"];
        attach.bounds = CGRectMake(0, -3, 15, 15);
        NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
        [goodsNameAttributeStr insertAttributedString:attributeStr2 atIndex:0];
        _priceTypeLbl.attributedText = goodsNameAttributeStr;
        
        //天元专区不显示市场价
        _marketPriceLbl.text = @"";
        _marketPrice.text = @"";
        _marketLblConstrain.constant = 0;
        
        _vipPrice.text = [NSString stringWithFormat:@"%.2f", goodsModel.goodsInfo.price];
    } else {
        _vipPrice.text = [NSString stringWithFormat:@"￥%.2f", goodsModel.goodsInfo.price];
    }
}
- (IBAction)addressChooseBtnClick {
    if ([_delegate respondsToSelector:@selector(goodsInfoCellChooseAddressWithIndex:)]) {
        [_delegate goodsInfoCellChooseAddressWithIndex:_indexPath];
    }
}
- (IBAction)collectBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(goodsInfoTableViewCellCollect:)]) {
        [_delegate goodsInfoTableViewCellCollect:sender];
    }
}

@end
