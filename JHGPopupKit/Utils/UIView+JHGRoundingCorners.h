//
//  UIView+JHGRoundingCorners.h
//  JHGPopupView
//
//  Created by uzzi on 2020/3/14.
//  Copyright © 2020 uzzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JHGRoundingCorners)

/**
 给UIView指定的角增加圆角
 
 @param rectCorner 指定增加的圆角的位置 如果是多个 用 “|”组合即可
 @param cornerRadii 圆角的大小
 */
- (void)jh_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;


/**
 给UIView指定的角增加圆角和边框

 @param rectCorner 圆角位置
 @param cornerRadii 圆角大小
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)jh_addRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

@interface UIDevice (FullScreen)

+ (BOOL)jh_isFullScreen;

+ (CGFloat)jh_homeIndicatorHeight;

@end
