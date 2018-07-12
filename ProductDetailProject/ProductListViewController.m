//
//  ProductListViewController.m
//  ProductDetailProject
//
//  Created by Huazhixi on 2018/7/11.
//  Copyright © 2018年 HuaxiGroup. All rights reserved.
//

#import "ProductListViewController.h"
#import "Masonry.h"
#import "02 Macro.h"
#import "03 Constant.h"
#import "MJExtension.h"

#import "TCHomeModel.h"
#import "TCGoodsCell.h"
#import "TCGoodsModel.h"
#import "TCBabyDeailtyRootVC.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

static NSString *const TCGoodsCellID = @"TCGoodsCell";

@interface ProductListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/**     */
@property (strong, nonatomic) UICollectionView *collectionView;
/**     */
@property (strong, nonatomic) NSMutableArray *goodsArray;

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self fetchProductListData];
    
    [self.collectionView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight);
        make.left.bottom.right.equalTo(self.view).offset(0);
    }];
}

#pragma mark - 网络请求
/**
  商品列表 数据
 */
- (void)fetchProductListData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"productlist" ofType:@"json"];
    NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    NSDictionary *productlistDic = [productlistStr mj_JSONObject];
    self.goodsArray = [RecommendProduct mj_objectArrayWithKeyValuesArray:productlistDic[@"recommendProduct"]];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TCGoodsCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:TCGoodsCellID forIndexPath:indexPath];
    goodsCell.goodsModel = self.goodsArray[indexPath.row];
    return goodsCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"productDetail" ofType:@"json"];
    NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    NSDictionary *productlistDic = [productlistStr mj_JSONObject];
    TCGoodsModel *goodsModel = [TCGoodsModel mj_objectWithKeyValues:productlistDic[@"data"]];
    
    TCBabyDeailtyRootVC *detailRootVC = [TCBabyDeailtyRootVC new];
    detailRootVC.goodsID = @"402";
    detailRootVC.goodsModel = goodsModel;
    [self.navigationController pushViewController:detailRootVC animated:YES];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((SCREEN_WIDTH - 25)/2, (SCREEN_WIDTH - 25)/2 + 70);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,10,0,10);//分别为上、左、下、右
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor  = LINE_BACK_COLOR;
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        [_collectionView registerClass:[TCGoodsCell class] forCellWithReuseIdentifier:TCGoodsCellID];
    }
    return _collectionView;
}
- (NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray  = [[NSMutableArray alloc] init];
    }
    return _goodsArray;
}

@end
