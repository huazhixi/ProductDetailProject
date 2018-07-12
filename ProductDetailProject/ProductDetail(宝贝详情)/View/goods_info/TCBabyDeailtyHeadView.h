/*
 宝贝详情头部
 */
#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "TCGoodsModel.h"

@protocol  TCBabyDeailtyHeadViewDelegate<NSObject>

- (void)didSelectCycleScrollViewOnTapAtIndex:(NSString *)urlStr;
- (void)didSelectCycleScrollViewOnTapAtIndexID:(NSString *)idStr lunboIndex:(NSInteger)lunboIndex;

@end

@interface TCBabyDeailtyHeadView : UIView<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *cycleScrollBackView;
@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (nonatomic, assign) id <TCBabyDeailtyHeadViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *collectImgView;
@property (weak, nonatomic) IBOutlet UILabel *collectLbl;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

/**     */
@property (strong, nonatomic) GoodsInfo *goodsInfoModel;
@end
