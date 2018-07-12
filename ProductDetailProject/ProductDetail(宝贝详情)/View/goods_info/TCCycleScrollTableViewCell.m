   //
//  TCCycleScrollTableViewCell.m
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "TCCycleScrollTableViewCell.h"
#import "PBView.h"

@implementation TCCycleScrollTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCell];
    }
    return self;
}

#pragma mark - 重写set方法
- (void)setBannerArray:(NSArray *)bannerArray {
    _bannerArray = bannerArray;
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
    for (NSString *banner in bannerArray) {
        [tempArray addObject:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, banner]];
    }
    [self.bannerShowUrlArray addObjectsFromArray:tempArray];
    self.cycleScrollView.imageURLStringsGroup = tempArray;
}
-(void)setImageGroupUrls:(NSArray<NSString *> *)imageGroupUrls {
    _imageGroupUrls = imageGroupUrls;
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
    for (Banner *banner in imageGroupUrls) {
        [tempArray addObject:[NSString stringWithFormat:@"%@%@", URL_IMG_PREFIX, banner.img_url]];
    }
    self.cycleScrollView.imageURLStringsGroup = tempArray;
}

-(void)setLocalImageGroupUrls:(NSArray<NSString *> *)localImageGroupUrls {
    _localImageGroupUrls = localImageGroupUrls;
    self.cycleScrollView.localizationImageNamesGroup = localImageGroupUrls;
}

-(void)setImageTextValueArr:(NSArray<NSString *> *)imageTextValueArr {
    _imageTextValueArr = imageTextValueArr;
    self.cycleScrollView.titlesGroup = imageTextValueArr;
}

- (void)setupCell {
    
    [self addSubview:self.cycleScrollView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.equalTo(self).offset(0);
    }];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    PBView * pbView = [[PBView alloc] init];
    pbView.imgUrlArr = self.bannerShowUrlArray;
    pbView.currentIndex = index;
    [pbView show];
}
#pragma mark - 懒加载
-(SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:GOODS_SCROLL_HODLER_IMAGE]];
        _cycleScrollView.currentPageDotColor = kMAIN_RED_COLOR; // 自定义分页控件小圆标颜色
        _cycleScrollView.pageDotColor = lightGray_color;
        _cycleScrollView.autoScrollTimeInterval = 5;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _cycleScrollView;
}
- (NSMutableArray *)bannerShowUrlArray {
    if (!_bannerShowUrlArray) {
        _bannerShowUrlArray  = [[NSMutableArray alloc] init];
    }
    return _bannerShowUrlArray;
}
@end
