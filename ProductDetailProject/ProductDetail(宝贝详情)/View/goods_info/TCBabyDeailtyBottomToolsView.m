/*
 宝贝详情底部工具条
 */

#import "TCBabyDeailtyBottomToolsView.h"
#import "EasyShowView.h"
//#import "WZLBadgeImport.h"
//#import "TCShopCartViewController.h"

@interface TCBabyDeailtyBottomToolsView()

@property (weak, nonatomic) IBOutlet UIButton *bigBuyNowBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cartImgView;
@end

@implementation TCBabyDeailtyBottomToolsView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    // 待添加功能
//    [_cartImgView showBadgeWithStyle:WBadgeStyleNumber value:10 animationType:WBadgeAnimTypeNone];
}
- (void)setStore_id:(NSInteger)store_id {
    _store_id = store_id;
    
    if (store_id == 72 || store_id == 73) {
        _bigBuyNowBtn.hidden = NO;
    }
}
- (IBAction)AddGoods:(UIButton *)sender {
    if (_store_id == 73) {
        [EasyTextView showText:@"此商品不能加入购物车！"];
        return;
    }
    if (self.cartAddBackAction) {
        self.cartAddBackAction();
    }
}
//1.客服 2.店铺 3.购物车
- (IBAction)bottomAction:(UIButton *)sender {
    if (_backAction) {
        _backAction(sender.tag);
    }
}

- (IBAction)buyGoods:(UIButton *)sender {
    if (self.buyGoods) {
        self.buyGoods();
    }
}

@end
