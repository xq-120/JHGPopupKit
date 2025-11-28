//
//  JHGPopupUtils.m
//  JHGPopupView
//
//  Created by uzzi on 2025/7/12.
//

#import "JHGPopupUtils.h"

@implementation JHGPopupUtils

+ (UIViewController *)topViewController {
    UIWindow *window = [self appKeyWindow];
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

+ (UIWindow *)appKeyWindow {
    UIWindow *window = nil;
    // iOS 13+ 先从 foregroundActive 的 scene 中找 isKeyWindow
    if (@available(iOS 13.0, *)) {
        NSSet<UIScene *> *scenes = [UIApplication sharedApplication].connectedScenes;
        
        for (UIScene *scene in scenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive &&
                [scene isKindOfClass:[UIWindowScene class]]) {
                
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                for (UIWindow *w in windowScene.windows) {
                    if (w.isKeyWindow) {
                        window = w;
                        break;
                    }
                }
            }
            if (window) break;
        }
    }
    if (window) {
        return window;
    }
    
    // 其次从 UIApplication.sharedApplication.windows 找
    for (UIWindow *w in UIApplication.sharedApplication.windows) {
        if (w.isKeyWindow) {
            window = w;
            break;
        }
    }
    if (window) {
        return window;
    }
    
    // 再次 fallback 到 keyWindow
    window = UIApplication.sharedApplication.keyWindow;
    if (window) {
        return window;
    }

    // 最后从 AppDelegate 拿
    id<UIApplicationDelegate> delegate = UIApplication.sharedApplication.delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        window = [delegate window];
    }
    
    return window;
}


@end
