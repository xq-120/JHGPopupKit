//
//  JHGPopupView+Manager.m
//  JHGPopupManagerDemo
//
//  Created by uzzi on 2025/7/14.
//

#import "JHGPopupView+ManagerItem.h"

@implementation JHGPopupView (ManagerItem)

- (void)jh_showWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self showWithAnimated:animated completion:completion];
}

- (void)jh_hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self hiddenWithAnimated:animated completion:completion];
}

- (BOOL)jh_shouldPopupIn:(UIViewController *)viewController {
    return true;
}

@end
