//
//  UIViewController+Utils.h
//  JiaBoWang
//
//  Created by Huazhixi on 2017/4/13.
//  Copyright © 2017年 HandTV. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CurrentViewController [UIViewController currentViewController]

@interface UIViewController (Utils)

@property(nonatomic,strong,readonly)UINavigationController *myNavigationController;

+ (UIViewController *) currentViewController;
@end
