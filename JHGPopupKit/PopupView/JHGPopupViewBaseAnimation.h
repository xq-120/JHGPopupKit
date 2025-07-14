//
//  JHGPopupBaseAnimation.h
//  JHGPopupView
//
//  Created by uzzi on 2024/4/5.
//

#import <Foundation/Foundation.h>
#import "JHGPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHGPopupViewBaseAnimation : NSObject <JHGPopupViewAnimationProtocol>

@property (nonatomic, assign) NSTimeInterval animateInDuration;

@property (nonatomic, assign) NSTimeInterval animateOutDuration;

@end

NS_ASSUME_NONNULL_END
