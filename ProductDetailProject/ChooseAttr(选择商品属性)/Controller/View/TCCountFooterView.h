//
//  TCCountFooterView.h
//  TCMall
//
//  Created by Huazhixi on 2018/4/13.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@interface TCCountFooterView : UICollectionReusableView
/**     */
@property(nonatomic, retain)UILabel *countLbl;
/**     */
@property (strong, nonatomic) PPNumberButton *numberButton;
/**        */
@property (nonatomic, copy) void (^changeNumCellBlock)(CGFloat number);
/**     */
@property (nonatomic, assign) NSInteger maxValue;
@end
