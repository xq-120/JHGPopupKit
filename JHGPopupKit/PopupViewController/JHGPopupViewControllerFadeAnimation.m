//
//  JHGPopupFadeAnimation.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/16.
//

#import "JHGPopupViewControllerFadeAnimation.h"

@implementation JHGPopupViewControllerFadeAnimation

- (void)animateInWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    JHGPopupViewController *contentVC = nil;
    if ([toVC isKindOfClass:JHGPopupViewController.class]) {
        contentVC = (JHGPopupViewController *)toVC;
    } else if ([toVC isKindOfClass:UINavigationController.class]) {
        contentVC = [(UINavigationController *)toVC viewControllers].firstObject;
    }
    if (![contentVC isKindOfClass:JHGPopupViewController.class]) {
        return;
    }
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    UIView *containerView = transitionContext.containerView;
    
    toVC.view.frame = finalFrame;
    toVC.view.alpha = 0;
    
    [containerView addSubview:toVC.view];
    
    [contentVC.view layoutIfNeeded];
    if (!self.disableAnimateInZoom) {
        contentVC.contentView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
    }
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha = 1;
        if (!self.disableAnimateInZoom) {
            contentVC.contentView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (void)animateOutWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    JHGPopupViewController *contentVC = nil;
    if ([fromVC isKindOfClass:JHGPopupViewController.class]) {
        contentVC = (JHGPopupViewController *)fromVC;
    } else if ([fromVC isKindOfClass:UINavigationController.class]) {
        contentVC = [(UINavigationController *)fromVC viewControllers].firstObject;
    }
    if (![contentVC isKindOfClass:JHGPopupViewController.class]) {
        return;
    }
    
    fromVC.view.alpha = 1;
    if (!self.disableAnimateOutZoom) {
        contentVC.contentView.transform = CGAffineTransformIdentity;
    }

    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.alpha = 0;
        if (!self.disableAnimateOutZoom) {
            contentVC.contentView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

@end
