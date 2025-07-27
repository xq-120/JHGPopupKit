//
//  JHGPopupView.h
//  JHGPopupKit
//
//  Created by 薛权 on 2025/7/26.
//

#import <JHGPopupKit/JHGPopupView.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGSheetView: JHGPopupView

/// 顶部圆角值。默认10.0
@property (nonatomic, assign) CGFloat contentViewCorner;

/// 默认0
@property (nonatomic, assign) CGFloat topMargin;

/// 标题的补偿高度，默认30。标题的总高度为：文本+titleExtraHeight
@property (nonatomic, assign) CGFloat titleExtraHeight;

/// 副标题的补偿高度，默认10。副标题的总高度为：文本+subtitleExtraHeight
@property (nonatomic, assign) CGFloat subtitleExtraHeight;

/// 默认0
@property (nonatomic, assign) CGFloat subtitleBtnMargin;

/// 选项按钮的高度，默认50.
@property (nonatomic, assign) CGFloat sheetBtnHeight;

/// 默认0
@property (nonatomic, assign) CGFloat btnLineViewEdgePadding;
/// 默认1/[UIScreen mainScreen].scale
@property (nonatomic, assign) CGFloat btnLineViewHeight;
@property (nonatomic, strong) UIColor *btnLineViewBgColor;

/// 取消按钮和选项按钮间的分割视图高度。默认6。
@property (nonatomic, assign) CGFloat seperateViewHeight;

@property (nonatomic, strong, readonly) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readonly) UILabel *sheetSubtitleLabel;

@property (nonatomic, strong, readonly) UIView *seperateView;
@property (nonatomic, strong, readonly) UIButton *cancelButton;

@property (nonatomic, assign) BOOL hiddenTitleLabel;
@property (nonatomic, assign) BOOL hiddenSubtitleLabel;
/// 是否隐藏取消按钮，默认NO。设置YES-隐藏取消按钮，并且分割视图也会被隐藏。
@property (nonatomic, assign) BOOL hiddenCancelButton;

@property (nonatomic, strong) UIFont *btnTitleFont;
@property (nonatomic, strong) UIColor *btnTitleColor;

/// 添加的按钮数组。不包括取消按钮。
@property (nonatomic, copy, readonly) NSArray<UIButton *> *buttonsArray;

/// 点击cancel按钮时的回调
@property (nonatomic, copy) void(^cancelActionBlock)(void);

/**
 添加按钮.
 
 务必在show前添加按钮。

 @param configHandler 按钮配置block
 @param handler 按钮事件回调block
*/
- (void)addBtnWithConfigHandler:(void (^_Nullable)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSInteger buttonIndex))handler;

/// 快捷方法.buttonTitles的顺序在addBtn之后，建议不要混用。
- (void)showSheetWithTitle:(nullable NSString *)title
                  subtitle:(nullable NSString *)subtitle
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                 actionBlk:(void(^)(NSInteger index))actionBlk
                completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
