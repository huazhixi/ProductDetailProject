//
//  TCRecommandTableViewCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/3/7.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCRecommandTableViewCell.h"
#import "Masonry.h"
#import "02 Macro.h"
#import "03 Constant.h"
#import "TCGoodsCell.h"
#import "UIViewController+Utils.h"
#import "TCBabyDeailtyRootVC.h"
//#import "TCWarehouseDetailRootViewController.h"
#import "TCGoodsModel.h"
#import "MJExtension.h"

static NSString *const TCGoodsCellID = @"TCGoodsCell";

@interface TCRecommandTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation TCRecommandTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCell];
    }
    return self;
}
- (void)setIsDiancang:(BOOL)isDiancang {
    _isDiancang = isDiancang;
}

- (void)setRecommendArray:(NSArray *)recommendArray {
    _recommendArray = recommendArray;
    
    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.equalTo(self).offset(0);
    }];
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/3, (SCREEN_WIDTH - 20)/3 + 65+10);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = clear_color;
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:[TCGoodsCell class] forCellWithReuseIdentifier:TCGoodsCellID];
    }
    return _collectionView;
}
-(void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _recommendArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TCGoodsCellID forIndexPath:indexPath];
    cell.isDiancang = _isDiancang;
    cell.goodsModel = _recommendArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moreProductDetail" ofType:@"json"];
    NSString *productlistStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    NSDictionary *productlistDic = [productlistStr mj_JSONObject];
    TCGoodsModel *goodsModel = [TCGoodsModel mj_objectWithKeyValues:productlistDic[@"data"]];
    
    TCBabyDeailtyRootVC *babyDetailVC = [TCBabyDeailtyRootVC new];
    babyDetailVC.goodsModel = goodsModel;
    babyDetailVC.goodsID = @"405";
    [CurrentViewController.navigationController pushViewController:babyDetailVC animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 10, 0, 10);
}

@end
