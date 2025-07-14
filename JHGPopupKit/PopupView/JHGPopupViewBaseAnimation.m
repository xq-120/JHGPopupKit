//
//  JHGPopupBaseAnimation.m
//  JHGPopupView
//
//  Created by uzzi on 2024/4/5.
//

#import "JHGPopupViewBaseAnimation.h"

@implementation JHGPopupViewBaseAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        _animateInDuration = 0.25;
        _animateOutDuration = 0.25;
    }
    return self;
}

- (void)animateInWithPopupView:(JHGPopupView *)popupView completion:(void (^)(void))completion {
    
}

- (void)animateOutWithPopupView:(JHGPopupView *)popupView completion:(void (^)(void))completion {
    
}

@end
