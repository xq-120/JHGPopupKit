//
//  JHGPopupUtils.m
//  JHGPopupView
//
//  Created by 薛权 on 2025/7/12.
//

#import "JHGPopupUtils.h"

@implementation JHGPopupUtils

+ (UIViewController *)topViewController {
    UIWindow *window = [self appMainWindow];
    if (!window || !window.rootViewController) {
        return nil;
    }
    return [self topViewControllerWithController:window.rootViewController];
}

+ (UIViewController *)topViewControllerWithController:(UIViewController *)controller {
    if (controller.presentedViewController) {
        return [self topViewControllerWithController:controller.presentedViewController];
    } else if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)controller;
        if (nav.topViewController) {
            return [self topViewControllerWithController:nav.topViewController];
        }
        return nav;
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)controller;
        if (tab.selectedViewController) {
            return [self topViewControllerWithController:tab.selectedViewController];
        }
        return tab;
    } else {
        return controller;
    }
}

+ (UIWindow *)appMainWindow {
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *window in windowScene.windows) {
                    if (window.windowLevel == UIWindowLevelNormal) {
                        return window;
                    }
                }
            }
        }
        // fallback
        return UIApplication.sharedApplication.delegate.window;
    } else {
        return UIApplication.sharedApplication.delegate.window;
    }
}


@end
