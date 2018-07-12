
#import <UIKit/UIKit.h>
#import "TCGoodsModel.h"

extern NSString *const kMerchandiseShopBasicInfoTableViewCellIdentifier;

@interface TCBabyDeailtyShopBasicInfoTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^shopInfoCellBlock)(NSInteger index);
/**     */
@property (strong, nonatomic) StoreInfo *shopModel;
@end
