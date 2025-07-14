//
//  JHGPopupFadeAnimation.h
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/16.
//

#import <Foundation/Foundation.h>
#import "JHGPopupViewBaseAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupViewFadeAnimation : JHGPopupViewBaseAnimation

@property (nonatomic, assign) BOOL disableAnimateInZoom;

@property (nonatomic, assign) BOOL disableAnimateOutZoom;

@end

NS_ASSUME_NONNULL_END
