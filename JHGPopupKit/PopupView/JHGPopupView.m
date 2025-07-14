//
//  JHGPopupView.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2022/7/15.
//

#import "JHGPopupView.h"
#import "JHGPopupUtils.h"
#import "JHGPopupViewFadeAnimation.h"

@interface JHGPopupView ()

@property (nonatomic, strong) UIButton *backView;
@property (nonatomic, readwrite, strong) UIView * _Nonnull contentView;

@end

@implementation JHGPopupView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    _animator = [[JHGPopupViewFadeAnimation alloc] init];
    
    _identifier = NSStringFromClass(self.class);
    
    self.backgroundColor = [UIColor clearColor];
    _shouldDismissOnTouchBackView = NO;
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self addSubview:self.backView];
    [self addSubview:self.contentView];
    
    self.backView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = true;
}

- (BOOL)isShowing {
    return self.window != nil;
}

- (void)showWithCompletion:(void (^)(void))completion {
    [self showIn:self.inView completion:completion];
}

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self showIn:self.inView animated:animated completion:completion];
}

- (void)showIn:(UIView *)view completion:(void (^)(void))completion {
    [self showIn:view animated:YES completion:completion];
}

- (void)showIn:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    if (view == nil) {
        view = [JHGPopupUtils appMainWindow];
    }
    if (view == nil) {
        return;
    }
    
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }
    [view addSubview:self];
    self.inView = view;
    
    if (!animated) {
        completion == nil ? nil : completion();
        return;
    }
    [self.animator animateInWithPopupView:self completion:completion];
}

- (void)hiddenWithCompletion:(void (^)(void))completion {
    [self hiddenWithAnimated:YES completion:completion];
}

- (void)hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    if (!animated) {
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.animator animateOutWithPopupView:self completion:^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        [strongSelf removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

- (void)backViewDidClicked:(id)sender {
    if (self.shouldDismissOnTouchBackView) {
        [self hiddenWithCompletion:self.onTouchBackViewActionBlk];
    } else if (self.onTouchBackViewActionBlk) {
        self.onTouchBackViewActionBlk();
    }
}

- (UIButton *)backView {
    if (_backView == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(backViewDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        _backView = btn;
    }
    return  _backView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

@end
