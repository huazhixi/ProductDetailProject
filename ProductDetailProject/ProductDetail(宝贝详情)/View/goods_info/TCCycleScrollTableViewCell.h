//
//  TCCycleScrollTableViewCell.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/6.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "TCHomeModel.h"

@interface TCCycleScrollTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
/**网络图片数组*/
@property (nonatomic,strong) NSArray <NSString *> *imageGroupUrls;
/**本地图片数组*/
@property (nonatomic,strong) NSArray <NSString *> *localImageGroupUrls;
/**图片描述文字数组*/
@property (nonatomic,strong) NSArray <NSString *> *imageTextValueArr;
/**     */
@property (strong, nonatomic) NSArray *bannerArray;
/**     */
@property (strong, nonatomic) NSMutableArray *bannerShowUrlArray;
@end
