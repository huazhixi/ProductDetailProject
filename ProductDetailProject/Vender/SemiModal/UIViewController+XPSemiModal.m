//
//  UIViewController+XPSemiModal.m
//  https://github.com/xiaopin/SemiModal.git
//
//  Created by nhope on 2018/1/10.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "UIViewController+XPSemiModal.h"
#import "XPSemiModalPresentationController.h"
#import "XPSemiModalTransitioningDelegate.h"
#import <objc/runtime.h>

@implementation UIViewController (XPSemiModal)

- (void)presentSemiModalViewController:(UIViewController *)contentViewController contentHeight:(CGFloat)contentHeight configuration:(XPSemiModalConfiguration *)configuration completion:(void (^)(void))completion {
    NSAssert(configuration, @"The configuration argument cann't be nil.");
    if (self.presentedViewController) { return; }
    contentViewController.modalPresentationStyle = UIModalPresentationCustom;
    contentViewController.preferredContentSize = CGSizeMake(0.0, contentHeight);
    
    XPSemiModalTransitioningDelegate *transitioningDelegate = [[XPSemiModalTransitioningDelegate alloc] init];
    contentViewController.transitioningDelegate = transitioningDelegate;
    // Keep strong references.
    static char delegateKey;
    objc_setAssociatedObject(contentViewController, &delegateKey, transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    XPSemiModalPresentationController *presentationController = (XPSemiModalPresentationController *)contentViewController.presentationController;
    presentationController.configuration = configuration;
    
    if (configuration.enableShadow) {
        // Add shadow effect.
        contentViewController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        contentViewController.view.layer.shadowOffset = CGSizeMake(0.0, -3.0);
        contentViewController.view.layer.shadowRadius = configuration.shadowRadius;
        contentViewController.view.layer.shadowOpacity = configuration.shadowOpacity;
        contentViewController.view.layer.shouldRasterize = YES;
        contentViewController.view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    }
    
    [self presentViewController:contentViewController animated:YES completion:completion];
}


- (void)presentSemiModalView:(UIView *)contentView contentHeight:(CGFloat)contentHeight configuration:(XPSemiModalConfiguration *)configuration completion:(void (^)(void))completion {
    NSAssert(contentView, @"The contentView cann't be nil.");
    UIViewController *contentViewController = [[UIViewController alloc] init];
    contentViewController.view.backgroundColor = [UIColor clearColor];
    [contentViewController.view addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    
    [self presentSemiModalViewController:contentViewController contentHeight:contentHeight configuration:configuration completion:completion];
}


@end
