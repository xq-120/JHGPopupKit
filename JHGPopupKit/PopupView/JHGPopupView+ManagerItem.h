//
//  JHGPopupView+Manager.h
//  JHGPopupManagerDemo
//
//  Created by uzzi on 2025/7/14.
//

#import "JHGPopupView.h"
#import "JHGPopupKit/JHGPopupManagerCompatible.h"

NS_ASSUME_NONNULL_BEGIN

#if JHGPopupManager_ENABLED

@interface JHGPopupView (ManagerItem) <JHGPopupManagerItemProtocol>

- (void)jh_showWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (void)jh_hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

- (BOOL)jh_shouldPopupIn:(UIViewController *)viewController;

@end

#endif

NS_ASSUME_NONNULL_END
