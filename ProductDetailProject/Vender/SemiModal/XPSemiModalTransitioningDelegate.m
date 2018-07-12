//
//  XPSemiModalTransitioningDelegate.m
//  https://github.com/xiaopin/SemiModal.git
//
//  Created by nhope on 2018/1/10.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "XPSemiModalTransitioningDelegate.h"
#import "XPSemiModalAnimatedTransitioning.h"
#import "XPSemiModalPresentationController.h"

@implementation XPSemiModalTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[XPSemiModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    XPSemiModalAnimatedTransitioning *animated = [[XPSemiModalAnimatedTransitioning alloc] init];
    animated.presentation = YES;
    return animated;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    XPSemiModalAnimatedTransitioning *animated = [[XPSemiModalAnimatedTransitioning alloc] init];
    animated.presentation = NO;
    return animated;
}

@end
