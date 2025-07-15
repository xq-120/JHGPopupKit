//
//  JHGPopupUtils.h
//  JHGPopupView
//
//  Created by uzzi on 2025/7/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupUtils : NSObject

+ (nullable UIViewController *)topViewController;
+ (nullable UIViewController *)topViewControllerWithController:(UIViewController *)controller;
+ (nullable UIWindow *)appMainWindow;

@end

NS_ASSUME_NONNULL_END
