//
//  JHGPopupPresentAnimation.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/16.
//

#import "JHGPopupViewControllerPresentAnimation.h"

@implementation JHGPopupViewControllerPresentAnimation

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
    
    [containerView addSubview:toVC.view];
    
    [contentVC.view layoutIfNeeded];
    CGRect contentViewFrame = contentVC.contentView.frame;
    contentVC.contentView.frame = CGRectMake(contentViewFrame.origin.x, contentViewFrame.origin.y + contentViewFrame.size.height, contentViewFrame.size.width, contentViewFrame.size.height);
    contentVC.backView.alpha = 0;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        contentVC.backView.alpha = 1;
        contentVC.contentView.frame = contentViewFrame;
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
    
    CGRect contentViewFrame = contentVC.contentView.frame;
    contentVC.backView.alpha = 1;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        contentVC.backView.alpha = 0;
        contentVC.contentView.frame = CGRectMake(contentViewFrame.origin.x, contentViewFrame.origin.y + contentViewFrame.size.height, contentViewFrame.size.width, contentViewFrame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

@end
