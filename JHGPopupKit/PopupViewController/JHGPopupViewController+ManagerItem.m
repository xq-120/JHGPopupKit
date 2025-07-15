//
//  JHGPopupViewController+ManagerItem.m
//  JHGPopupManagerDemo
//
//  Created by uzzi on 2025/7/15.
//

#import "JHGPopupViewController+ManagerItem.h"

@implementation JHGPopupViewController (ManagerItem)

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
