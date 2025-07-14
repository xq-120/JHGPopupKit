//
//  JHGPopupBaseAnimation.m
//  JHGPopupView
//
//  Created by uzzi on 2024/4/5.
//

#import "JHGPopupViewControllerBaseAnimation.h"

@implementation JHGPopupViewControllerBaseAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        _animateInDuration = 0.25;
        _animateOutDuration = 0.25;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.directionType == JHGPopupAnimateDirectionIn) {
        return self.animateInDuration;
    }
    return self.animateOutDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.directionType == JHGPopupAnimateDirectionIn) {
        [self animateInWithTransitionContext:transitionContext];
    } else {
        [self animateOutWithTransitionContext:transitionContext];
    }
}

- (void)animateInWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

- (void)animateOutWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
}

@end
