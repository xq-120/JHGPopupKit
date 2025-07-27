//
//  UIView+JHGRoundingCorners.m
//  JHGPopupView
//
//  Created by uzzi on 2020/3/14.
//  Copyright © 2020 uzzi. All rights reserved.
//

#import "UIView+JHGRoundingCorners.h"
#import "JHGPopupUtils.h"

@implementation UIView (JHGRoundingCorners)

- (void)jh_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

- (void)jh_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    // 显示部分
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    // 边框
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.path = maskPath.CGPath;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = borderWidth;
    [self.layer addSublayer:borderLayer];
}

@end

@implementation UIDevice (FullScreen)

+ (BOOL)jh_isIPhoneX {
    if (@available(iOS 11.0, *)) {
        if ([JHGPopupUtils appMainWindow].safeAreaInsets.bottom > 0) {
            return true;
        }
    }
    return false;
}

+ (CGFloat)jh_homeIndicatorHeight {
    if (@available(iOS 11.0, *)) {
        return [JHGPopupUtils appMainWindow].safeAreaInsets.bottom;
    }
    return 0;
}

@end
