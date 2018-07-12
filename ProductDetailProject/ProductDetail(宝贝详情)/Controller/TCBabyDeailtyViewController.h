/*
 宝贝详情
 */
#import "BaseViewController.h"
#import "LLSegmentBar.h"
//#import "BaseNatigationViewController.h"
#import "TCGoodsModel.h"

@class TCBabyDeailtyViewController;
@protocol  TCBabyDeailtyViewControllerDelegate<NSObject>
@optional
- (void)TCBabyDeailtyViewControllerOffsetY:(float)offsetY hiddenNavBar:(BOOL)hiddenNavBar;
@end

@interface TCBabyDeailtyViewController : BaseViewController

@property (nonatomic,strong)LLSegmentBar *segmentBar;

//@property (nonatomic,strong)BaseNatigationViewController *baseNavController;
/**     */
@property (strong, nonatomic) UILabel *titileLbl;

@property (nonatomic,strong)UIViewController *fatherVC;

@property (weak, nonatomic) id<TCBabyDeailtyViewControllerDelegate>delegate;
/**     */
@property (strong, nonatomic) TCGoodsModel *goodsModel;
/**   */
@property (nonatomic, copy) NSString *goods_img;
/**   */
@property (nonatomic, copy) NSString *goods_id;

@end
