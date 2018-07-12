//
//  TCChooseGoodsAttributeViewController.m
//  TCMall
//
//  Created by Huazhixi on 2018/3/14.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCChooseGoodsAttributeViewController.h"
#import "Masonry.h"
#import "02 Macro.h"
#import "03 Constant.h"
#import "EasyTextView.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+HXExtension.h"
#import "PurchaseCarAnimationTool.h"
//#import "BaseTabBarController.h"

#import "TCPropertyCell.h"
#import "TCPropertyHeader.h"
#import "TCPropertyFooter.h"
#import "TCCountFooterView.h"
#import "ORSKUDataFilter.h"

#import "TCAttributeModel.h"
//#import "TCFinalOrderViewController.h"

static NSString *const TCPropertyCellID = @"TCPropertyCell";
static NSString *const TCPropertyHeaderID = @"TCPropertyHeader";
static NSString *const TCPropertyFooterID = @"TCPropertyFooter";
static NSString *const TCCountFooterViewID = @"TCCountFooterView";

@interface TCChooseGoodsAttributeViewController()<ORSKUDataFilterDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *skuData;;
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;;
@property (nonatomic, strong) ORSKUDataFilter *filter;

@property (strong, nonatomic)  UIImageView *goodImageView;
@property (strong, nonatomic)  UILabel *lb_price;
@property (strong, nonatomic)  UILabel *lb_stock;
@property (strong, nonatomic)  UILabel *lb_detail;
/** 关闭 */
@property (strong, nonatomic)  UIButton *closeBtn;
/**     */
@property (strong, nonatomic) UIView *line;
/**     */
@property (strong, nonatomic) UICollectionView *collectionView;
/** 确定 */
@property (strong, nonatomic)  UIButton *sureBtn;
/** 加入购物车 */
@property (strong, nonatomic)  UIButton *addCartBtn;
/** 立即购买 */
@property (strong, nonatomic)  UIButton *buyGoodsBtn;
/**  商品属性模型   */
@property (strong, nonatomic) TCAttributeModel *attrModel;
/** 已选商品属性id  */
@property (nonatomic, copy) NSString *spec_id;
/** 选择商品的数量  */
@property (nonatomic, copy) NSString *quantity;
/** 选择商品的属性描述  */
@property (nonatomic, copy) NSString *specification;
/**  所选属性最大数量   */
@property (nonatomic, assign) NSInteger maxQuantity;
/**  已选商品属性模型   */
@property (strong, nonatomic) Attribute *choosedAttribute;
/**  立即购买返回的订单模型   */
//@property (strong, nonatomic) TCConfirmOrderModel *confirmOrderModel;
/** 选择提示语  */
@property (nonatomic, copy) NSString *noteSpec;
@end

@implementation TCChooseGoodsAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *dataSource = @[@{@"name" : @"款式",
//                              @"value" : @[@"male", @"famale"]},
//                            @{@"name" : @"颜色",
//                              @"value" : @[@"red", @"green", @"blue"]},
//                            @{@"name" : @"尺寸",
//                              @"value" : @[@"XXL", @"XL", @"L", @"S", @"M"]},
//                            @{@"name" : @"test",
//                              @"value" : @[@"A", @"B", @"C"]},];
//    _dataSource = dataSource;

//    _skuData = @[
//                 @{@"contition":@"male,red,XL,A",
//                   @"price":@"1120",
//                   @"store":@"167"},
//                 @{@"contition":@"male,red,M,B",
//                   @"price":@"1200",
//                   @"store":@"289"},
//                 @{@"contition":@"male,green,L,A",
//                   @"price":@"889",
//                   @"store":@"300"},
//                 @{@"contition":@"male,green,M,B",
//                   @"price":@"991",
//                   @"store":@"178"},
//                 @{@"contition":@"famale,red,XL,A",
//                   @"price":@"1000",
//                   @"store":@"200"},
//                 @{@"contition":@"famale,blue,L,B",
//                   @"price":@"880",
//                   @"store":@"12"},
//                 @{@"contition":@"famale,blue,XXL,C",
//                   @"price":@"1210",
//                   @"store":@"300"},
//                 @{@"contition":@"male,blue,L,C",
//                   @"price":@"888",
//                   @"store":@"121"},
//                 @{@"contition":@"famale,green,M,C",
//                   @"price":@"1288",
//                   @"store":@"125"},
//                 @{@"contition":@"male,blue,L,A",
//                   @"price":@"1210",
//                   @"store":@"123"}
//                 ];
    
//
//    _filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
//
//    [self setupSubViews];
    
    [self fetchGoodsAttributesData];
}
#pragma mark - 网络请求
/**
 刷新页面视图
 */
- (void)fetchGoodsAttributesData {
    NSDictionary *productlistDic = [NSDictionary new];
    
    if ([_goods_id isEqual:@"402"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"productSpec1" ofType:@"json"];
        NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        productlistDic = [productlistStr mj_JSONObject];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"productSpec2" ofType:@"json"];
        NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
        productlistDic = [productlistStr mj_JSONObject];
    }
    
    self.attrModel = [TCAttributeModel mj_objectWithKeyValues:productlistDic[@"data"]];
    self.dataSource = productlistDic[@"data"][@"spec"];
    
    NSMutableArray *noteSpecArr = @[].mutableCopy;
    for (NSDictionary *dic in self.dataSource) {// 组合选择提示语
        [noteSpecArr addObject:dic[@"key"]];
    }
    self.noteSpec = [noteSpecArr componentsJoinedByString:@" "];
    
    NSMutableArray *skuArray = @[].mutableCopy;
    for (Attribute *model in self.attrModel.list) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        dic[@"contition"] = model.spec;
        dic[@"price"] = [NSString stringWithFormat:@"%.2f", model.price];
        dic[@"store"] = model.stock;
        dic[@"model"] = model;
        [skuArray addObject:dic];
    }
    self.skuData = skuArray;
    [self refreshAttributesView];
}
/**
 加入购物车
 */
- (void)addCartGoodsIsBuyNow:(BOOL)isBuyNow {
    
}
- (void)refreshAttributesView {
    
    _selectedIndexPaths = [NSMutableArray array];
    _filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
    [self setupSubViews];
}

- (void)setupSubViews {
    
    self.view.backgroundColor = white_color;
    
    _goodImageView = [[UIImageView alloc] initWithImage:IMAGE(GOODS_PLACE_HOLDER)];
    _goodImageView.contentMode = UIViewContentModeScaleAspectFill;
    _goodImageView.clipsToBounds = YES;
    ViewBorderRadius(_goodImageView, 5, 5, white_color);
    [self.view addSubview:_goodImageView];
    
    _lb_price = [UILabel new];
    _lb_price.textColor = kMAIN_RED_COLOR;
    _lb_price.font = H14;
    _lb_price.numberOfLines = 0;
    _lb_price.text = @"￥14.50";
    [self.view addSubview:_lb_price];
    
    _lb_stock = [UILabel new];
    _lb_stock.textColor = NORMAL_TEXT_COLOR;
    _lb_stock.font = H14;
    _lb_stock.numberOfLines = 0;
    _lb_stock.text = @"库存100000件";
    [self.view addSubview:_lb_stock];
    
    _lb_detail = [UILabel new];
    _lb_detail.textColor = NORMAL_TEXT_COLOR;
    _lb_detail.font = H14;
    _lb_detail.numberOfLines = 0;
    _lb_detail.text = @"请选择 属性";
    [self.view addSubview:_lb_detail];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setBackgroundImage:IMAGE(@"blackClose") forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(dismissViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    
    _line = [UIView new];
    _line.backgroundColor = LINE_BACK_COLOR;
    [self.view addSubview:_line];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = white_color;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[TCPropertyCell class] forCellWithReuseIdentifier:TCPropertyCellID];
    [_collectionView registerClass:[TCPropertyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TCPropertyHeaderID];
    [_collectionView registerClass:[TCPropertyFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:TCPropertyFooterID];
    [_collectionView registerClass:[TCCountFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:TCCountFooterViewID];
    [_collectionView reloadData];
    [_collectionView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
    [self.view addSubview:_collectionView];
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0  inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    _addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_addCartBtn setTitleColor:white_color forState:UIControlStateNormal];
    [_addCartBtn setBackgroundColor:kMAIN_YELLOW_COLOR];
    _addCartBtn.titleLabel.font = H14;
    [_addCartBtn addTarget:self action:@selector(addCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addCartBtn];
    
    _buyGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyGoodsBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_buyGoodsBtn setTitleColor:white_color forState:UIControlStateNormal];
    [_buyGoodsBtn setBackgroundColor:kMAIN_RED_COLOR];
    _buyGoodsBtn.titleLabel.font = H14;
    [_buyGoodsBtn addTarget:self action:@selector(buyNowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buyGoodsBtn];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:white_color forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:kMAIN_RED_COLOR];
    _sureBtn.titleLabel.font = H14;
    [self.view addSubview:_sureBtn];
    
    if (_isFromBuyCart) {// 购物车页面进入，不可修改数量
        _sureBtn.hidden = NO;
        
    } else {// 商品详情页面进入，可以修改数量
        _sureBtn.hidden = YES;
    }

    __weak typeof(self) _weakSelf = self;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, _goods_img]] placeholderImage:ZHENG_HOLDER_IMAGE completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            _weakSelf.goodImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                _weakSelf.goodImageView.alpha = 1.0f;
            }];
        } else {
            _weakSelf.goodImageView.alpha = 1.0f;
        }
    }];
    _quantity = @"1";
    _maxQuantity = _goodsModel.storeInfo.goodsCount;
    _lb_stock.text = [NSString stringWithFormat:@"库存%ld件", _goodsModel.storeInfo.goodsCount];
    if (_goodsModel.goodsInfo.store_id == 72) {
        _lb_price.text = [NSString stringWithFormat:@"%.2f", _goodsModel.goodsInfo.price];
    } else {
        _lb_price.text = [NSString stringWithFormat:@"￥%.2f", _goodsModel.goodsInfo.price];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).offset(-Padding * 2);
        make.left.equalTo(self.view).offset(Padding);
        make.width.height.offset(100);
    }];
    
    [_lb_price mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).offset(Padding);
        make.left.equalTo(self.goodImageView.mas_right).offset(Padding);
    }];
    
    [_lb_stock mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.lb_price.mas_bottom).offset(5);
        make.left.equalTo(self.lb_price).offset(0);
    }];
    
    [_lb_detail mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.lb_stock.mas_bottom).offset(5);
        make.left.equalTo(self.lb_price).offset(0);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).offset(Padding);
        make.right.equalTo(self.view.mas_right).offset(-Padding);
        make.width.height.offset(25);
    }];

    [_line mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.goodImageView.mas_bottom).offset(BigPadding);
        make.left.equalTo(self.view).offset(Padding);
        make.right.equalTo(self.view.mas_right).offset(-Padding);
        make.height.offset(1);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.addCartBtn.mas_top).offset(0);
    }];

    [_addCartBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.buyGoodsBtn.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabbarSafeBottomMargin);
        make.height.offset(44);
//        make.width.offset(SCREEN_WIDTH / 2);
    }];
    if (_fromBuyNowBtn) {
        [_buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.addCartBtn.mas_bottom).offset(0);
            make.height.offset(44);
            make.width.offset(SCREEN_WIDTH);
        }];
    } else {
        [_buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.addCartBtn.mas_bottom).offset(0);
            make.height.offset(44);
            make.width.offset(SCREEN_WIDTH / 2);
        }];
    }
    
//    [_buyGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make){
//        make.right.equalTo(self.view.mas_right).offset(0);
//        make.bottom.equalTo(_addCartBtn.mas_bottom).offset(0);
//        make.height.offset(44);
//        make.width.offset(SCREEN_WIDTH / 2);
//    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-kTabbarSafeBottomMargin);
        make.height.offset(44);
    }];
}
//- (void)setFromBuyNowBtn:(BOOL)fromBuyNowBtn {
//    _fromBuyNowBtn = fromBuyNowBtn;
//    if (fromBuyNowBtn) {
//        [_buyGoodsBtn mas_updateConstraints:^(MASConstraintMaker *make){
//            make.width.offset(SCREEN_WIDTH);
//        }];
//    }
//}
#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource[section][@"value"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TCPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TCPropertyCellID forIndexPath:indexPath];
    NSArray *data = _dataSource[indexPath.section][@"value"];
    cell.propertyL.text = data[indexPath.row];
    
    if ([_filter.availableIndexPathsSet containsObject:indexPath]) {
        cell.contentView.backgroundColor = LINE_BACK_COLOR;
        cell.propertyL.textColor = NORMAL_TEXT_COLOR;
    }else {
        cell.contentView.backgroundColor = LINE_BACK_COLOR;
        cell.propertyL.textColor = NOT_CHOOSE_COLOR;
    }
    
    if ([_filter.selectedIndexPaths containsObject:indexPath]) {
        cell.contentView.backgroundColor = kMAIN_RED_COLOR;
        cell.propertyL.textColor = white_color;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) _weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TCPropertyHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCPropertyHeaderID forIndexPath:indexPath];
        view.headernameL.text = _dataSource[indexPath.section][@"key"];
        return view;
    } else {
        if (indexPath.section == _dataSource.count - 1) {
            TCCountFooterView *countView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCCountFooterViewID forIndexPath:indexPath];
            countView.maxValue = _maxQuantity;
            countView.changeNumCellBlock = ^(CGFloat number) {//选择商品数量
                _weakSelf.quantity = [NSString stringWithFormat:@"%.0f", number];
            };
            return countView;
        }
        TCPropertyFooter *line = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:TCPropertyFooterID forIndexPath:indexPath];
        return line;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [_filter didSelectedPropertyWithIndexPath:indexPath];
    
    [collectionView reloadData];
    [self action_complete];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = _dataSource[indexPath.section][@"value"];
    NSString *text = data[indexPath.row];
    CGFloat width = [NSString calculateRowWidth:text withHeight:20 font:12];
    
    return CGSizeMake(width + Padding * 4, 25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, Padding, 0, Padding);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 44);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == _dataSource.count - 1) {
        return CGSizeMake(ScreenWidth, 60);
    }
    return CGSizeMake(ScreenWidth - Padding * 2, 11);
}

#pragma mark -- ORSKUDataFilterDataSource
- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return _dataSource.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    return _dataSource[section][@"value"];
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return _skuData.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    NSString *condition = _skuData[row][@"contition"];
    return [condition componentsSeparatedByString:@","];
}

- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    NSDictionary *dic = _skuData[row];
    return @{@"price": dic[@"price"],
             @"store": dic[@"store"],
             @"model": dic[@"model"]
             };
}
- (void)action_complete {

    NSDictionary *dic = _filter.currentResult;
    if (dic == nil) {
        NSLog(@"请选择完整 属性");
        if (_goodsModel.goodsInfo.store_id == 72) {
            _lb_price.text = [NSString stringWithFormat:@"%.2f", _goodsModel.goodsInfo.price];
        } else {
            _lb_price.text = [NSString stringWithFormat:@"￥%.2f", _goodsModel.goodsInfo.price];
        }
        _lb_stock.text = [NSString stringWithFormat:@"库存%ld件", _goodsModel.storeInfo.goodsCount];
        _lb_detail.text = @"请选择 属性";
//        _choosedAttribute.info = nil;
        return;
    }
    Attribute *attribute = dic[@"model"];
    if (_goodsModel.goodsInfo.store_id == 72) {
        _lb_price.text = [NSString stringWithFormat:@"%@", dic[@"price"]];
    } else {
        _lb_price.text = [NSString stringWithFormat:@"￥%@", dic[@"price"]];
    }
    _lb_stock.text = [NSString stringWithFormat:@"库存%@件",dic[@"store"]];
    _lb_detail.text = [NSString stringWithFormat:@"已选择 %@", attribute.spec];
    __weak typeof(self) _weakSelf = self;
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, attribute.img]] placeholderImage:ZHENG_HOLDER_IMAGE completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            _weakSelf.goodImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                _weakSelf.goodImageView.alpha = 1.0f;
            }];
        } else {
            _weakSelf.goodImageView.alpha = 1.0f;
        }
    }];
    
    // 重置最大选择数量
    _maxQuantity = [attribute.stock integerValue];
    _choosedAttribute = attribute;
}
#pragma mark - 私有方法
/**
 加入购物车
 */
- (void)addCartBtnClick {
    
    if ([_lb_detail.text isEqual:@"请选择 属性"]) {
        [EasyTextView showText:@"请选择 完整属性"];
        return;
    }

    [self finishChooseAttribute];
    
    if (_store_id == 73) {
        [EasyTextView showText:@"此商品不能加入购物车！"];
        return;
    }
    
    if ([_specification isEqual:@""]) {// 未选择商品属性，给予提示
        [EasyTextView showInfoText:[NSString stringWithFormat:@"请选择 %@ ", _noteSpec]];
        return;
    }
    [self addCartGoodsIsBuyNow:NO];
}
- (void)finishChooseAttribute {
    
    _spec_id = s_Integer(_choosedAttribute.spec_id);
    NSMutableArray *specArray = @[].mutableCopy;
    for (AttributeInfo *info in _choosedAttribute.info) {
        NSString *tempStr = [NSString stringWithFormat:@"%@:%@", info.tabName, info.tabValue];
        [specArray addObject:tempStr];
    }
    _specification = [specArray componentsJoinedByString:@" "];
}
- (void)animateCartAdd {
    __weak typeof(self) _weakSelf = self;
    [[PurchaseCarAnimationTool shareTool] startAnimationandView:_goodImageView andRect:CGRectMake(0, 208, 100, 100) andFinisnRect:CGPointMake(ScreenWidth/4*2.5, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
        [_weakSelf dismissViewBtnClick];
//        BaseTabBarController *tab = (BaseTabBarController *)KeyWindow.rootViewController;
//        UIView *tabbarBtn = tab.tabBar.subviews[2];
//        [PurchaseCarAnimationTool shakeAnimation:tabbarBtn];
    }];
}
/**
 立即购买
 */
- (void)buyNowBtnClick {
    
    [self finishChooseAttribute];
    
    if ([_specification isEqual:@""]) {// 未选择商品属性，给予提示
        [EasyTextView showInfoText:[NSString stringWithFormat:@"请选择 %@ ", _noteSpec]];
        return;
    }
    
    [self addCartGoodsIsBuyNow:YES];
}

- (void)accessEnsureOrderView {
    
    [self dismissViewBtnClick];
    __weak typeof(self) _weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        TCFinalOrderViewController *finalOrderVC = [TCFinalOrderViewController new];
//        finalOrderVC.confirmOrderModel = _weakSelf.confirmOrderModel;
//        finalOrderVC.isBuyNow = YES;
//        if (_store_id == 72) {//天元商品购买
//            if ([_goods_id isEqual:@"1297"]) {
//                finalOrderVC.confirmOrderType = ConfirmOrderTypeSpecialGoods_1297;
//            } else {
//                finalOrderVC.confirmOrderType = ConfirmOrderTypeTianYuan;
//            }
//        } else if (_store_id == 73) {//天堂商品购买
//            finalOrderVC.confirmOrderType = ConfirmOrderTypeHeaven;
//        } else {
//            finalOrderVC.confirmOrderType = ConfirmOrderTypeNormal;
//        }
//        [_weakSelf.fatherVC.navigationController pushViewController:finalOrderVC animated:YES];
    });
}
- (void)dismissViewBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
