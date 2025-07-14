//
//  JHGPopupFadeAnimation.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/16.
//

#import "JHGPopupViewFadeAnimation.h"

@implementation JHGPopupViewFadeAnimation

- (void)animateInWithPopupView:(JHGPopupView * _Nonnull)popupView completion:(void (^ _Nullable)(void))completion {
    popupView.alpha = 0;
    if (!self.disableAnimateInZoom) {
        popupView.contentView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
    }
    [UIView animateWithDuration:self.animateInDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        popupView.alpha = 1;
        if (!self.disableAnimateInZoom) {
            popupView.contentView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        !completion ?: completion();
    }];
}

- (void)animateOutWithPopupView:(JHGPopupView * _Nonnull)popupView completion:(void (^ _Nullable)(void))completion {
    popupView.alpha = 1;
    if (!self.disableAnimateOutZoom) {
        popupView.contentView.transform = CGAffineTransformIdentity;
    }
    [UIView animateWithDuration:self.animateOutDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        popupView.alpha = 0;
        if (!self.disableAnimateOutZoom) {
            popupView.contentView.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
        }
    } completion:^(BOOL finished) {
        !completion ?: completion();
    }];
}

@end
