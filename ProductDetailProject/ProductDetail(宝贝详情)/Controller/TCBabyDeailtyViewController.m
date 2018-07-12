/*
 宝贝详情--商品页
 */

#import "TCBabyDeailtyViewController.h"
#import "UIViewController+XPSemiModal.h"
#import "NSObject+HXExtension.h"
#import "03 Constant.h"
#import "02 Macro.h"
#import "Masonry.h"
#import "YYText.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import "TCCycleScrollTableViewCell.h"
#import "TCGoodsInfoTableViewCell.h"
#import "TCBabyDeailtyCell.h"
#import "TCSaleServiceCell.h"
#import "TCBabyDeailtyShopBasicInfoTableViewCell.h"
#import "TCBabyDetailJudgeCountTableViewCell.h"
#import "TCBabyDetailMoreJudgeTableViewCell.h"
#import "TCGoodsCommentListsCell.h"
#import "TCRecommandTopTableViewCell.h"
#import "TCRecommandTableViewCell.h"
#import "TCBabyDetailFooterView.h"

#import "TCBabyDeailtyBottomToolsView.h"
#import "TCGoodsParameterView.h"
#import "TCChooseGoodsAttributeViewController.h"
//#import "TCBabyDeailtyCouponView.h"
//#import "TCShopHomeViewController.h"
//#import "TCShopGoodsCategeryViewController.h"
//#import "TCShopCartViewController.h"
//#import "TCUserLoginViewController.h"
//#import "TCGoodsAddressModel.h"

#define kEndH 80 //用户手指上拉多少距离进入宝贝详情
#define NAVBAR_COLORCHANGE_POINT -500
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 140 + SCREEN_WIDTH * 5 / 6
#define SCROLL_DOWN_LIMIT 0
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

static NSString *const TCCycleScrollTableViewCellID = @"TCCycleScrollTableViewCell";
static NSString *const TCGoodsInfoTableViewCellID = @"TCGoodsInfoTableViewCell";
static NSString *const TCBabyDeailtyCellID  = @"TCBabyDeailtyCell";
static NSString *const TCSaleServiceCellID = @"TCSaleServiceCell";
static NSString *const TCGoodsCommentListsCellID = @"TCGoodsCommentListsCell";
static NSString *const TCBabyDetailJudgeCountTableViewCellID = @"TCBabyDetailJudgeCountTableViewCell";
static NSString *const TCBabyDetailMoreJudgeTableViewCellID = @"TCBabyDetailMoreJudgeTableViewCell";
static NSString *const TCRecommandTopTableViewCellID = @"TCRecommandTopTableViewCell";
static NSString *const TCRecommandTableViewCellID = @"TCRecommandTableViewCell";
static NSString *const MerchandiseShopBasicInfoTableViewCellID = @"MerchandiseShopBasicInfoTableViewCell";

@interface TCBabyDeailtyViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate, TCGoodsInfoTableViewCellDelegate> {
    CGFloat minY;
    CGFloat maxY;
    // 是否显示底部视图，
    BOOL _isShowBottom;
}

@property(nonatomic,strong) UIView           *contentView;
@property (nonatomic,strong)UITableView *contentTableView;
@property (nonatomic,strong)UIWebView *goodsWebView;
@property(nonatomic,strong) UILabel          *bottomLab;
/**     */
@property (strong, nonatomic) TCGoodsParameterView *paramView;

@property (nonatomic,strong)TCBabyDetailFooterView *babyDeaityFootView;
/**  底部工具栏   */
@property (strong, nonatomic) TCBabyDeailtyBottomToolsView *bottomToolsView;
/**     */
//@property (strong, nonatomic)  TCBabyDeailtyCouponView *couponView;
/**     */
@property (strong, nonatomic) NSMutableArray *addressDataSource;
/**     */
@property (strong, nonatomic) NSMutableArray *bannerImgArray;
@end

@implementation TCBabyDeailtyViewController

#pragma mark -life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self fetchAreaListData];
}

- (void)setGoodsModel:(TCGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self.contentTableView reloadData];
    NSMutableArray *paramsTempArray = [NSMutableArray arrayWithCapacity:1];
    for (Parameter *model in goodsModel.parameter) {
        [paramsTempArray addObject:[NSString stringWithFormat:@"%@  %@", model.name, model.value]];
    }
    self.paramView.paramsArray = paramsTempArray;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:goodsModel.descHtml]];
    [self.goodsWebView loadRequest:request];
    
    for (NSString *tempStr in goodsModel.goodsInfo.banner) {
        [self.bannerImgArray addObject:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, tempStr]];
    }
}

#pragma mark -set UI
-(void)configUI {

    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.contentTableView];
    [self.contentView addSubview:self.goodsWebView];
    
    __weak typeof(self) _weakSelf = self;
    
    // 添加底部工具栏
    TCBabyDeailtyBottomToolsView *bottomToolsView = XIB(TCBabyDeailtyBottomToolsView);
    [self.view addSubview:bottomToolsView];
    
    if (_goodsModel.goodsInfo.store_id == 1) {
        bottomToolsView.shoppingCartBtnView.hidden = NO;
    } else if (_goodsModel.goodsInfo.store_id == 72 || _goodsModel.goodsInfo.store_id == 73) {
        bottomToolsView.storeBtnView.hidden = NO;
    }
    self.bottomToolsView = bottomToolsView;
    self.bottomToolsView.store_id = _goodsModel.storeInfo.store_id;
    [bottomToolsView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabbarSafeBottomMargin);
        make.height.mas_equalTo(49);
    }];
    //加入购物车的回调
    [bottomToolsView setCartAddBackAction:^{
        [_weakSelf goodsAttributeChooseIsFromBuyNowBtn:NO];
    }];
    //立即购买的回调
    [bottomToolsView setBuyGoods:^{
        [_weakSelf goodsAttributeChooseIsFromBuyNowBtn:YES];
    }];
    
    bottomToolsView.backAction = ^(NSInteger tag) {
        if (tag == 0) {
            
        } else if (tag ==1) {// 进入店铺首页
            [_weakSelf enterShopHomeView];
        } else {//进入购物车页面
//            if (!User_ID) {
//                [self presentLoginVC];
//                return;
//            }
//            TCShopCartViewController *shopCartVC = [TCShopCartViewController new];
//            [self.navigationController pushViewController:shopCartVC animated:YES];
        }
    };
}

- (void)goodsAttributeChooseIsFromBuyNowBtn:(BOOL)isFromBuyNow {
//    if (!User_ID) {
//        [self presentLoginVC];
//        return;
//    }
    
    TCChooseGoodsAttributeViewController *chooseGoodsAttributeVC = [TCChooseGoodsAttributeViewController new];
    chooseGoodsAttributeVC.isFromBuyCart = NO;
    chooseGoodsAttributeVC.fromBuyNowBtn = isFromBuyNow;
    chooseGoodsAttributeVC.fatherVC = self;
//    chooseGoodsAttributeVC.goods_id = s_Integer(_goodsModel.goodsInfo.goods_id);
    chooseGoodsAttributeVC.goods_id = _goods_id;
    chooseGoodsAttributeVC.goodsModel = _goodsModel;
    chooseGoodsAttributeVC.goods_img = @"/homebank/goods_images/2018-06/152785527347647935.jpg";
    chooseGoodsAttributeVC.store_id = self.goodsModel.storeInfo.store_id;
    XPSemiModalConfiguration *config = [XPSemiModalConfiguration defaultConfiguration];
    [self presentSemiModalViewController:chooseGoodsAttributeVC contentHeight:SCREEN_HEIGHT - 200 configuration:config completion:nil];
}
#pragma mark - 网络请求
/**
 地区二级联动
 */
- (void)fetchAreaListData {
    
}
/**
 商品详情计算运费
 */
- (void)getGoodsInfoFeeWithCity_id:(NSString *)city_id {

}
/**
 商品收藏
 */
- (void)goodsCollectMethod {
    
}
- (void)enterShopHomeView {
//    [EasyTextView showText:@"功能暂未开通"];
//    TCShopHomeViewController *shopHomeVC = [TCShopHomeViewController new];
//    shopHomeVC.store_id  = s_Integer(_goodsModel.storeInfo.store_id);
//    [self.navigationController pushViewController:shopHomeVC animated:YES];
}
#pragma mark - UITableViewDelegate  DataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 9 ;
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 4) {
//        return _goodsModel.comment.count;
//    } else if (section == 6) {
//        if (self.goodsModel.storeInfo.store_id == 1) {
//            return 0;
//        }
//    } else if (section == 7 || section == 8) {
//        if (self.goodsModel.recommend.count) {
//            return 1;
//        } else {
//            return 0;
//        }
//    }
//    return 1;
    
    if (section == 5) {
        return _goodsModel.comment.count;
    } else if (section == 3) {
        if ([_goodsModel.goodsInfo.sale_service isEqual:@""] || !_goodsModel.goodsInfo.sale_service) {
            return 0;
        } else {
            return 1;
        }
    } else if (section == 7) {
        if (self.goodsModel.storeInfo.store_id == 1) {
            return 0;
        }
    } else if (section == 8 || section == 9) {
        if (self.goodsModel.recommend.count) {
            return 1;
        } else {
            return 0;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _weakSelf = self;
    
    TCCycleScrollTableViewCell *cycleScrollTableViewCell = [tableView dequeueReusableCellWithIdentifier:TCCycleScrollTableViewCellID];
    
    TCGoodsInfoTableViewCell *goodsInfoTableViewCell = [tableView dequeueReusableCellWithIdentifier:TCGoodsInfoTableViewCellID];
    goodsInfoTableViewCell.delegate = self;
    goodsInfoTableViewCell.indexPath = indexPath;
    
    TCSaleServiceCell *sallServiceCell = [tableView dequeueReusableCellWithIdentifier:TCSaleServiceCellID];
    
    TCBabyDeailtyShopBasicInfoTableViewCell *shopInfoCell = [tableView dequeueReusableCellWithIdentifier:MerchandiseShopBasicInfoTableViewCellID];
    shopInfoCell.shopInfoCellBlock = ^(NSInteger index) {
        if (index == 0) {// 商品分类
            
//            TCShopGoodsCategeryViewController *shopGoodsCategeryVC = [TCShopGoodsCategeryViewController new];
//            [_weakSelf.navigationController pushViewController:shopGoodsCategeryVC animated:YES];
        } else {// 店铺首页
            
            [_weakSelf enterShopHomeView];
        }
    };
    
    TCBabyDetailJudgeCountTableViewCell *judgeCountCell = [tableView dequeueReusableCellWithIdentifier:TCBabyDetailJudgeCountTableViewCellID];
    
    TCGoodsCommentListsCell *commentListsCell = [tableView dequeueReusableCellWithIdentifier:TCGoodsCommentListsCellID];
    
    TCBabyDetailMoreJudgeTableViewCell *moreJudgeTableViewCell = [tableView dequeueReusableCellWithIdentifier:TCBabyDetailMoreJudgeTableViewCellID];
    moreJudgeTableViewCell.moreJudgeCellBlock = ^{
        _weakSelf.segmentBar.selectIndex = 2;
    };
    
    TCRecommandTableViewCell *recommandCell = [tableView dequeueReusableCellWithIdentifier:TCRecommandTableViewCellID];
    
    if (indexPath.section == 0) {
        cycleScrollTableViewCell.bannerArray = _goodsModel.goodsInfo.banner;
        
        return cycleScrollTableViewCell;
    } else if (indexPath.section == 1) {
        [self configureGoodsInfoCell:goodsInfoTableViewCell atIndexPath:indexPath];
        return goodsInfoTableViewCell;
    } else if (indexPath.section == 2) {//选择规格、收货地址、优惠券领取、产品参数、正品保证 - 七天无理由退换
       TCBabyDeailtyCell *cell = [tableView dequeueReusableCellWithIdentifier:TCBabyDeailtyCellID];
        cell.babyDealtyCellGuiGeBlock = ^{// 选择规格
            [_weakSelf goodsAttributeChooseIsFromBuyNowBtn:NO];
        };
        cell.babyDealtyCellGoodsParamBlock = ^{// 产品参数
            
        };
        
        cell.babyDealtyCellYouhuiBlock = ^{// 优惠券
//            self.couponView.store_id = s_Integer(_goodsModel.goodsInfo.store_id);
//            [UIView animateWithDuration:0.3 animations:^{
//                [KeyWindow addSubview:self.couponView];
//                _weakSelf.couponView.alpha = 1;
//                _weakSelf.couponView.downViewConstraint.constant = 200;
//            }];
        };
       return cell;
    } else if (indexPath.section == 3) {
        NSArray *saleArray = [_goodsModel.goodsInfo.sale_service componentsSeparatedByString:@","];
        NSString *saleString = [saleArray componentsJoinedByString:@"   "];
        sallServiceCell.saleServiceLbl.text = saleString;
        return sallServiceCell;
    } else if (indexPath.section == 4) {//商品评价(个数)
        judgeCountCell.totalCountLbl.text = [NSString stringWithFormat:@"商品评价(%ld)", _goodsModel.commentCount];
        return judgeCountCell;
    } else if (indexPath.section == 5) {// 商品评价内容
        commentListsCell.commentModel = _goodsModel.comment[indexPath.row];
        return commentListsCell;
    } else if (indexPath.section == 6) {//查看全部评价
        return moreJudgeTableViewCell;
    } else if (indexPath.section == 7) {// 商家信息展示
        
        shopInfoCell.shopModel = _goodsModel.storeInfo;
        return shopInfoCell;
    } else if (indexPath.section == 8) {//为您推荐
        TCRecommandTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TCRecommandTopTableViewCellID];
        return cell;
    } else {// 为您推荐 内容
        recommandCell.recommendArray = _goodsModel.recommend;
        return recommandCell;
    }
    return nil;
}

- (void)configureGoodsInfoCell:(TCGoodsInfoTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.goodsModel = self.goodsModel;
}

- (float)configGoodsInfoCellWithModel {
    if (self.goodsModel.goodsInfo.store_id == 1) {//判断是否是自营商品，添加自营图标
        NSString *goodsName = self.goodsModel.goodsInfo.goods_name;
        NSMutableAttributedString *goodsNameAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", goodsName]];
        goodsNameAttributeStr.yy_font = [UIFont boldSystemFontOfSize:14];
        goodsNameAttributeStr.yy_color = MAIN_TEXT_COLOR;
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"self_buy_normal"];
        attach.bounds = CGRectMake(0, -3, 45, 15);
        NSAttributedString *attributeStr2 = [NSAttributedString attributedStringWithAttachment:attach];
        [goodsNameAttributeStr insertAttributedString:attributeStr2 atIndex:0];
        return [goodsNameAttributeStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20 - 44, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 156;
    } else {
        return [self.goodsModel.goodsInfo.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20 - 44, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:H14}  context:nil].size.height + 156;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return SCREEN_WIDTH;
    } else if (indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:TCGoodsInfoTableViewCellID cacheByIndexPath:indexPath configuration:^(TCGoodsInfoTableViewCell *cell) {
            [self configureGoodsInfoCell:cell atIndexPath:indexPath];
        }];
//        return 300;
//        [self configGoodsInfoCellWithModel];
    } else if (indexPath.section == 2) {
        return 142;
    } else if ( indexPath.section == 6 || indexPath.section == 8) {
        return 44;
    } else if (indexPath.section == 3) {
        return 50;
    } else if (indexPath.section == 4) {
        return 40;
    } else if (indexPath.section == 5) {
        return [tableView fd_heightForCellWithIdentifier:TCGoodsCommentListsCellID cacheByIndexPath:indexPath configuration:^(TCGoodsCommentListsCell *cell) {
            cell.commentModel = self.goodsModel.comment[indexPath.row];
        }];
    } else if (indexPath.section == 7) {
        return 205;
    }
     return (SCREEN_WIDTH - 20)/3 + 65 + 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4 || section == 8) {// 商品评价 个数
        return 1.0f;
    }else if (section == 7) {
        return 10.0f;
    }
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10.0f;
    } else if (section == 7) {
        if (self.goodsModel.goodsInfo.store_id == 1) {
            return 0.0f;
        }
        return 10.0f;
    }
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    BOOL hiddenNavBar;
    if (scrollView == self.contentTableView) {
        hiddenNavBar = YES;
    } else {
        hiddenNavBar = NO;
        // WebView中的ScrollView
        if (offset <= -kEndH) {
            self.bottomLab.text = @"释放回到\"商品详情\"";
        } else {
            self.bottomLab.text = @"下拉回到\"商品详情\"";
        }
    }
    if ([_delegate respondsToSelector:@selector(TCBabyDeailtyViewControllerOffsetY:hiddenNavBar:)]) {
        [_delegate TCBabyDeailtyViewControllerOffsetY:scrollView.contentOffset.y hiddenNavBar:hiddenNavBar];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == self.contentTableView) {
            if (offset < 0) {
                minY = MIN(minY, offset);
            } else {
                maxY = MAX(maxY, offset);
            }
        } else {
            minY = MIN(minY, offset);
        }
        
        // 滚到底部视图
        if (maxY >= self.contentTableView.contentSize.height - SCREEN_HEIGHT + kEndH) {
            [UIView animateWithDuration:0.5 animations:^{
                self.segmentBar.mj_y = -kStatusBarAndNavigationBarHeight;
                self.titileLbl.mj_y = 0;
            }];
    
            _isShowBottom = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0,-SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                maxY = 0.0f;
                _isShowBottom = YES;
            }];
        }
        // 滚到中间视图
        if (minY <= -kEndH && _isShowBottom) {
            [UIView animateWithDuration:0.5 animations:^{
                self.segmentBar.mj_y = 0;
                self.titileLbl.mj_y = 35;
            }];
            
            _isShowBottom = NO;
            [UIView animateWithDuration:0.4 animations:^{
                self.contentView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                minY = 0.0f;
            }];
        }
    }
}
#pragma mark - TCGoodsInfoTableViewCellDelegate
- (void)goodsInfoCellChooseAddressWithIndex:(NSIndexPath *)indexPath {
//    __weak typeof(self) _weakSelf = self;
//    TCGoodsInfoTableViewCell *cell = (TCGoodsInfoTableViewCell *)[_contentTableView cellForRowAtIndexPath:indexPath];
//    NSArray *dataSource = self.addressDataSource; // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）

//    [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeCity dataSource:dataSource defaultSelected:nil isAutoSelect:NO themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
//        cell.chooseAddress = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name] ;
////        [_weakSelf getGoodsInfoFeeWithCity_id:city.code];
//    } cancelBlock:^{
//        NSLog(@"点击了背景视图或取消按钮");
//    }];
}
- (void)goodsInfoTableViewCellCollect:(UIButton *)button {
//    if (!User_ID) {
//        [self presentLoginVC];
//        return;
//    }
    [self goodsCollectMethod];
}

//- (void)presentLoginVC {
//    //跳到登录页面
//    TCUserLoginViewController *loginVC = [TCUserLoginViewController new];
//    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
//}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    2、都有效果
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

#pragma mark - 懒加载
-(UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabbarHeight) style:UITableViewStyleGrouped];
        _contentTableView.contentSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT - kTabbarHeight) * 2);
        _contentTableView.delegate   = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = LINE_BACK_COLOR;
        _contentTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _contentTableView.showsVerticalScrollIndicator = NO;
        
        [_contentTableView registerClass:[TCCycleScrollTableViewCell class] forCellReuseIdentifier:TCCycleScrollTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCGoodsInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:TCGoodsInfoTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCBabyDeailtyCell class]) bundle:nil] forCellReuseIdentifier:TCBabyDeailtyCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCSaleServiceCell class]) bundle:nil] forCellReuseIdentifier:TCSaleServiceCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCBabyDetailJudgeCountTableViewCell class]) bundle:nil] forCellReuseIdentifier:TCBabyDetailJudgeCountTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCBabyDetailMoreJudgeTableViewCell class]) bundle:nil] forCellReuseIdentifier:TCBabyDetailMoreJudgeTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCBabyDeailtyShopBasicInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:MerchandiseShopBasicInfoTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCRecommandTopTableViewCell class]) bundle:nil] forCellReuseIdentifier:TCRecommandTopTableViewCellID];
        [_contentTableView registerClass:[TCRecommandTableViewCell class] forCellReuseIdentifier:TCRecommandTableViewCellID];
//        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCRecommandTableViewCell class]) bundle:nil] forCellReuseIdentifier:TCRecommandTableViewCellID];
        [_contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TCGoodsCommentListsCell class]) bundle:nil] forCellReuseIdentifier:TCGoodsCommentListsCellID];
        
        _contentTableView.tableFooterView = self.babyDeaityFootView;
    }
    return _contentTableView;
}
- (NSMutableArray *)addressDataSource {
    if (!_addressDataSource) {
        _addressDataSource  = [[NSMutableArray alloc] init];
    }
    return _addressDataSource;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2);
        _contentView.backgroundColor = RGB0X(0xf4f4f4);
    }
    return _contentView;
}

- (UILabel *)bottomLab {
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -kEndH, SCREEN_WIDTH, kEndH)];
        _bottomLab.font = [UIFont systemFontOfSize:13.0f];
        _bottomLab.textAlignment = NSTextAlignmentCenter;
        _bottomLab.text = @"下拉返回中间View";
        [self.goodsWebView.scrollView addSubview:_bottomLab];
    }
    return _bottomLab;
}

- (UIWebView *)goodsWebView {
    if(!_goodsWebView){
        _goodsWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + kStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight)];
        _goodsWebView.delegate = self;
        _goodsWebView.scrollView.delegate = self;
        _goodsWebView.scrollView.backgroundColor = RGB0X(0xf4f4f4);
        _goodsWebView.scrollView.showsHorizontalScrollIndicator =NO;
    }
    return _goodsWebView;
}

- (TCBabyDetailFooterView *)babyDeaityFootView {
    if (!_babyDeaityFootView) {
        _babyDeaityFootView  = XIB(TCBabyDetailFooterView);
        _babyDeaityFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kTabbarHeight);
    }
    return _babyDeaityFootView;
}
- (TCGoodsParameterView *)paramView {
    if (!_paramView) {
        _paramView  = XIB(TCGoodsParameterView);
        _paramView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        __weak typeof(self) _weakSelf = self;
        _paramView.goodsParamViewBlock = ^{
            
            [UIView animateWithDuration:0.3 animations:^{
                _weakSelf.paramView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                [_weakSelf.paramView removeFromSuperview];
            }];
        };
    }
    return _paramView;
}
//- (TCBabyDeailtyCouponView *)couponView {
//    if (!_couponView) {
//        _couponView  = XIB(TCBabyDeailtyCouponView);
//        _couponView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        _couponView.alpha = 0;
//        __weak typeof(self) _weakSelf = self;
//        _couponView.bayDeailtyCouponBlock = ^{
//            [UIView animateWithDuration:0.3 animations:^{
//                _weakSelf.couponView.downViewConstraint.constant = SCREEN_HEIGHT;
//                _weakSelf.couponView.alpha = 0;
//            }];
//        };
//    }
//    return _couponView;
//}
- (NSMutableArray *)bannerImgArray {
    if (!_bannerImgArray) {
        _bannerImgArray  = [[NSMutableArray alloc] init];
    }
    return _bannerImgArray;
}
@end
