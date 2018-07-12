
/*
 宝贝详情根视图
 */

#import "TCBabyDeailtyRootVC.h"
#import "TCBabyDeailtyComentVC.h"
#import "TCBabyDeailtyWebVC.h"
#import "TCBabyDeailtyViewController.h"
#import "TCShopCartViewController.h"

#import "UIColor+hex.h"
#import "UIImage+ColorCreateImage.h"

#import "TCGoodsModel.h"
#import "ShareSDKManager.h"

#import "TCUserLoginViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>

#define Height_Header SCREEN_WIDTH * 910 / 1200.0

@interface TCBabyDeailtyRootVC ()<UIScrollViewDelegate, TCBabyDeailtyViewControllerDelegate, BMKLocationServiceDelegate>{
    BMKLocationService *_locService;
}
/**     */
@property (strong, nonatomic) UILabel *titileLbl;
/**     */
@property (strong, nonatomic) UIView *titleView;
/**     */
@property (nonatomic,strong)LLSegmentBarVC *segmentVC;
/**     */
@property (strong, nonatomic) TCBabyDeailtyViewController *vc1;
/**     */
@property (strong, nonatomic) TCBabyDeailtyWebVC *webVC;
/**     */
@property (strong, nonatomic) TCBabyDeailtyComentVC *vc3;
/**     */
@property (strong, nonatomic) TCGoodsModel *goodsModel;
/**   */
@property (nonatomic, copy) NSString *longitude;
/**   */
@property (nonatomic, copy) NSString *latitude;
@end

@implementation TCBabyDeailtyRootVC

#pragma mark -life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    __weak typeof(self) _weakSelf = self;
    [self leftImageItem:@"blackBackImg" action:^{
        [_weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self rightImageItem:@"goodsShareimage" action:^{//分享
        [[ShareSDKManager shareInstance] shareGoodsModel:_weakSelf.goodsModel.goodsInfo];
    }];
//    HRBarItem *shopCarItem = [HRBarItem new];
//    [shopCarItem setBackgroundImage:[UIImage imageNamed:@"goodsGouwuche"] forState:UIControlStateNormal];
//    HRBarItem *shareItem = [HRBarItem new];
//    [shareItem setBackgroundImage:[UIImage imageNamed:@"goodsShareimage"] forState:UIControlStateNormal];
//
//    [self rightItems:@[shareItem, shopCarItem] actions:^(NSInteger index) {
//        if (index == 0) {//分享
//            [[ShareSDKManager shareInstance] shareGoodsModel:_weakSelf.goodsModel.goodsInfo];
//        } else if (index == 1) {// 购物车
//            if (!User_ID) {
//                [self presentLoginVC];
//                return;
//            }
//            TCShopCartViewController *shopCartVC = [TCShopCartViewController new];
//            [self.navigationController pushViewController:shopCartVC animated:YES];
//        }
//    }];
    [self fetchGoodsData];
    [self removeGoodsDetailView];
}

- (void)presentLoginVC {
    //跳到登录页面
    TCUserLoginViewController *loginVC = [TCUserLoginViewController new];
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}

- (void)removeGoodsDetailView {// 只保留两个商品详情页面
    NSMutableArray *viewArray = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    NSMutableArray *tempVCs = @[].mutableCopy;
    for (UIViewController *vc in viewArray) {
        if ([vc isKindOfClass:[self class]]) {
            [tempVCs addObject:vc];
        }
    }
    if (tempVCs.count > 2) {//大于两个就删除一个
        UIViewController *vc = [tempVCs objectAtIndex:0];
        [viewArray removeObject:vc];
    }
    self.navigationController.viewControllers = viewArray;
}
-(void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
    // 设置导航栏背景颜色透明
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarShadowImageHidden:YES];
}
#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    self.latitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    [self fetchGoodsData];
    [_locService stopUserLocationService];
}
#pragma mark - 网络请求
/**
 刷新页面视图
 */
- (void)fetchGoodsData {
    
    typeof(self) _weakSelf = self;
    [EasyLoadingView showLoading];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = _goodsID;
    params[@"longitude"] = _longitude;
    params[@"latitude"] = _latitude;
    
    [[HRRequest manager] POST:@"Product/productDetail" para:params success:^(id data) {
        [EasyLoadingView hidenLoading];
        NSLog(@"%@", data);
        TCGoodsModel *goodsModel = [TCGoodsModel mj_objectWithKeyValues:data[@"data"]];
        _weakSelf.goodsModel = goodsModel;
        
        [_weakSelf setUI];
    } faiulre:^(NSString *errMsg) {
        [EasyLoadingView hidenLoading];
        if ([errMsg isEqual:ERROR_MESSAGE] || [errMsg isEqual:NET_NOT_WORK]) {
            [EasyTextView showErrorText:errMsg];
        } else {
            [EasyTextView showInfoText:errMsg];
        }
    }];
}
-(void)setUI {
    
    UILabel *titileLbl = [[UILabel alloc] initWithFrame:(CGRect){0, 35, 320, 35}];
    titileLbl.text = @"图文详情";
    titileLbl.font = H14;
    titileLbl.textAlignment = NSTextAlignmentCenter;
    self.titileLbl = titileLbl;
    
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, 320, 35);
    UIView *titleView = [[UIView alloc] initWithFrame:(CGRect){0, 0, 320, 35}];
    titleView.clipsToBounds = YES;
    [titleView addSubview:titileLbl];
    titleView.alpha = 0;
    [titleView addSubview:self.segmentVC.segmentBar];
    self.navigationItem.titleView = titleView;
    self.titleView = titleView;
    
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];

    NSArray *items = @[@"商品", @"详情", @"评论"];
    [self.segmentVC setUpWithItems:items childVCs:@[self.vc1,self.webVC,self.vc3]];
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor(MAIN_TEXT_COLOR).itemSelectColor(kMAIN_RED_COLOR).indicatorColor(kMAIN_RED_COLOR);
    }];
}
#pragma mark - TCBabyDeailtyViewControllerDelegate
- (void)TCBabyDeailtyViewControllerOffsetY:(float)offsetY hiddenNavBar:(BOOL)hiddenNavBar {
    [self changeNavBarAlpha:offsetY hiddenNavBar:hiddenNavBar];
}
#pragma mark -滑动导航渐变
- (void)changeNavBarAlpha:(CGFloat)yOffset hiddenNavBar:(BOOL)hiddenNavBar {
    if (!hiddenNavBar) {
        self.titleView.alpha = 1;
        [self wr_setNavBarBackgroundAlpha:1];
    } else {
        CGFloat currentAlpha = (yOffset - (-0))/(Height_Header/2.0 - (-0));
        currentAlpha = currentAlpha <= 0.0 ? 0.0 : (currentAlpha >= 1.0 ? 1.0 : currentAlpha);
        self.titleView.alpha = currentAlpha;
        [self wr_setNavBarBackgroundAlpha:currentAlpha];
        if (currentAlpha >0.3) {
            [self.navigationController.navigationItem.leftBarButtonItem setImage:IMAGE(@"nav_back_btn_normal")];
        }
        //    NSLog(@"当前的滑动距离是%f透明度是%f",yOffset,currentAlpha);
        if (yOffset > Height_Header/2.0) {
            [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
}
#pragma mark -lazy load
- (TCBabyDeailtyViewController *)vc1 {
    if (!_vc1) {
        _vc1  = [TCBabyDeailtyViewController new];
        _vc1.delegate = self;
        _vc1.titileLbl = self.titileLbl;
        _vc1.segmentBar        = self.segmentVC.segmentBar;
        _vc1.baseNavController = (BaseNatigationViewController *)self.navigationController;
        _vc1.fatherVC          = self;
        _vc1.goodsModel = self.goodsModel;
        _vc1.goods_img = _goods_img;
    }
    return _vc1;
}
- (TCBabyDeailtyWebVC *)webVC {
    if (!_webVC) {
        _webVC  = [TCBabyDeailtyWebVC new];
        _webVC.segmentBar = self.segmentVC.segmentBar;
        _webVC.baseNavController = (BaseNatigationViewController *)self.navigationController;
        _webVC.fatherVC = self;
        _webVC.htmlStr = self.goodsModel.descHtml;
    }
    return _webVC;
}
- (TCBabyDeailtyComentVC *)vc3 {
    if (!_vc3) {
        _vc3  = [TCBabyDeailtyComentVC new];
        _vc3.segmentBar        = self.segmentVC.segmentBar;
        _vc3.baseNavController = (BaseNatigationViewController *)self.navigationController;
        _vc3.fatherVC          = self;
        _vc3.goodsID = _goodsID;
        _vc3.goodsModel = self.goodsModel;
    }
    return _vc3;
}
- (TCGoodsModel *)goodsModel {
    if (!_goodsModel) {
        _goodsModel  = [[TCGoodsModel alloc] init];
    }
    return _goodsModel;
}
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        _segmentVC = [[LLSegmentBarVC alloc]init];
        [self addChildViewController:_segmentVC];
    }
    return _segmentVC;
}

@end
