//
//  JHGPopupProtocol.h
//  Pods
//
//  Created by uzzi on 2025/7/14.
//

#ifndef JHGPopupProtocol_h
#define JHGPopupProtocol_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 弹窗协议
@protocol JHGPopupProtocol <NSObject>

/// 是否正在显示。
@property (nonatomic, assign, readonly, getter=isShowing) BOOL showing;

/// 优先级设置。默认0。
@property (nonatomic, assign) NSInteger priority;

/// 标识id
@property (nonatomic, copy) NSString *identifier;

/// 蒙层视图
@property (nonatomic, strong, readonly) UIView *backView;

/// 点击蒙层时是否关闭弹窗
@property (nonatomic, assign) BOOL shouldDismissOnTouchBackView;

/// 点击蒙层回调
@property (nonatomic, copy) void (^ _Nullable onTouchBackViewActionBlk)(void);

/// 弹窗内容载体视图，所有视图应该添加在contentView上。
/// 在设置从左到右，从上到下的约束后，contentView的size是自适应的。
@property (nonatomic, readonly, strong) UIView * _Nonnull contentView;

/// 弹出弹窗。
/// - Parameters:
///   - animated: 是否动画
///   - completion: 显示完成回调
- (void)showWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

/// 关闭弹窗
/// - Parameters:
///   - animated: 是否动画
///   - completion: 关闭完成回调
- (void)hiddenWithAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END

#endif /* JHGPopupProtocol_h */
