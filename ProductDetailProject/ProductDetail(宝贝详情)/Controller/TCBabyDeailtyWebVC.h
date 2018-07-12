//
//  TCBabyDeailtyWebVC.h
//  TCMall
//
//  Created by 栗子 on 2018/1/29.
//  Copyright © 2018年 HJB. All rights reserved.
//

#import "BaseViewController.h"
#import "LLSegmentBar.h"
//#import "BaseNatigationViewController.h"

@interface TCBabyDeailtyWebVC : BaseViewController

@property (nonatomic,strong)LLSegmentBar *segmentBar;

//@property (nonatomic,strong)BaseNatigationViewController *baseNavController;

@property (nonatomic,strong)UIViewController *fatherVC;
/**   */
@property (nonatomic, copy) NSString *htmlStr;
@end
