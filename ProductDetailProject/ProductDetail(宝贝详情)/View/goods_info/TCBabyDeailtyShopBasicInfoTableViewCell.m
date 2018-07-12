
#import "TCBabyDeailtyShopBasicInfoTableViewCell.h"

NSString *const kMerchandiseShopBasicInfoTableViewCellIdentifier = @"MerchandiseShopBasicInfoTableViewCell";

@interface TCBabyDeailtyShopBasicInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *allGoodsCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *xinCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLbl;

@property (weak, nonatomic) IBOutlet UIButton *shopCategoryButton;
@property (weak, nonatomic) IBOutlet UIButton *shopDetailButton;

@end

@implementation TCBabyDeailtyShopBasicInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shopCategoryButton.layer.borderColor = RGB0X(0xF1081B).CGColor;
    self.shopDetailButton.layer.borderColor   = RGB0X(0xF1081B).CGColor;
}

- (void)setShopModel:(StoreInfo *)shopModel {
    _shopModel = shopModel;
    
    __weak typeof(self) _weakSelf = self;
    [_shopImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, shopModel.store_logo]] placeholderImage:[UIImage imageNamed:@"morendianpu"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            _weakSelf.shopImgView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                _weakSelf.shopImgView.alpha = 1.0f;
            }];
        } else {
            _weakSelf.shopImgView.alpha = 1.0f;
        }
    }];
    _shopNameLbl.text = shopModel.store_name;
    _allGoodsCountLbl.text = s_Integer(shopModel.goodsCount);
    _xinCountLbl.text = s_Integer(shopModel.newCount);
    _collectCountLbl.text = s_Integer(shopModel.collectCount);
}

- (IBAction)merchandiseShopBasicInfoAction:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    if (self.shopInfoCellBlock) {
        self.shopInfoCellBlock(index);
    }
}

@end
