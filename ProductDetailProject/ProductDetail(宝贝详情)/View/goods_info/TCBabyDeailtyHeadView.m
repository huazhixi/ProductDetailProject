

#import "TCBabyDeailtyHeadView.h"

@implementation TCBabyDeailtyHeadView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 2.5 / 3) delegate:self placeholderImage:[UIImage imageNamed:@"babyDeailty_banner"]];
    cycleScrollView.currentPageDotColor = kMAIN_RED_COLOR; // 自定义分页控件小圆标颜色
    cycleScrollView.pageDotColor = lightGray_color;
    cycleScrollView.localizationImageNamesGroup = @[@"babyDeailty_banner", @"babyDeailty_banner", @"babyDeailty_banner"];
    
    [self.cycleScrollBackView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    
    _goodsNameLbl.text = @"香味鸭脖佛如何佛绒布偶然被工人罢工金融办共报告香味鸭脖佛如何佛绒布偶然被工人罢工金融办共报告";
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"￥15.60" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:12],NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor lightGrayColor]}];
    _marketPriceLbl.attributedText = string2;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

}

- (void)setGoodsInfoModel:(GoodsInfo *)goodsInfoModel {
    _goodsInfoModel = goodsInfoModel;
    
    _goodsNameLbl.text = goodsInfoModel.goods_name;
    _vipPriceLbl.text = [NSString stringWithFormat:@"%.2f", goodsInfoModel.price];
    _marketPriceLbl.text =  [NSString stringWithFormat:@"%.2f", goodsInfoModel.market_price];
    _saleNumLbl.text = s_Integer(goodsInfoModel.sales);
    _cycleScrollView.imageURLStringsGroup = goodsInfoModel.banner;
}

@end
