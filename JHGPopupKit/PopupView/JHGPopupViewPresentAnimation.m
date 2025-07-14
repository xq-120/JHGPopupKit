//
//  JHGPopupPresentAnimation.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/16.
//

#import "JHGPopupViewPresentAnimation.h"

@implementation JHGPopupViewPresentAnimation

- (void)animateInWithPopupView:(JHGPopupView * _Nonnull)popupView completion:(void (^ _Nullable)(void))completion {
    [popupView layoutIfNeeded];
    
    CGRect currentFrame = popupView.contentView.frame;
    
    CGRect fromFrame = currentFrame;
    fromFrame.origin.y = popupView.frame.size.height + popupView.contentView.frame.size.height;
    popupView.contentView.frame = fromFrame;
    
    CGRect toFrame = currentFrame;
    
    popupView.alpha = 0;
    
    [UIView animateWithDuration:self.animateInDuration animations:^{
        popupView.alpha = 1;
        popupView.contentView.frame = toFrame;
    } completion:^(BOOL finished) {
        !completion ?: completion();
    }];
}

- (void)animateOutWithPopupView:(JHGPopupView * _Nonnull)popupView completion:(void (^ _Nullable)(void))completion {
    CGRect toFrame = popupView.contentView.frame;
    toFrame.origin.y = popupView.frame.size.height + popupView.contentView.frame.size.height;
    
    [UIView animateWithDuration:self.animateOutDuration animations:^{
        popupView.alpha = 0;
        popupView.contentView.frame = toFrame;
    } completion:^(BOOL finished) {
        !completion ?: completion();
    }];
}

@end
