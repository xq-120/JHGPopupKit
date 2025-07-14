//
//  JHGPopupBaseAnimation.h
//  JHGPopupView
//
//  Created by uzzi on 2024/4/5.
//

#import <Foundation/Foundation.h>
#import "JHGPopupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupViewControllerBaseAnimation : NSObject <JHGPopupViewControllerAnimationProtocol>

@property (nonatomic, assign) NSTimeInterval animateInDuration;

@property (nonatomic, assign) NSTimeInterval animateOutDuration;

@property (nonatomic, assign) JHGPopupAnimateDirectionType directionType;

- (void)animateInWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)animateOutWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
