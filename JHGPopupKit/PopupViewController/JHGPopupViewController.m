//
//  JHBaseAlertViewController.m
//  Pods-JHGPopupViewDemo
//
//  Created by uzzi on 2020/9/13.
//

#import "JHGPopupViewController.h"
#import "JHGPopupUtils.h"
#import "JHGPopupViewControllerFadeAnimation.h"

@interface JHGPopupViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIButton *backView;
@property (nonatomic, readwrite, strong) UIView *contentView;

@end

@implementation JHGPopupViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _shouldDismissOnTouchBackView = NO;
        
        _animator = [[JHGPopupViewControllerFadeAnimation alloc] init];
        
        _identifier = NSStringFromClass(self.class);
    }
    return self;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    if (@available(iOS 13.0, *)) {
//        return UIStatusBarStyleDarkContent;
//    } else {
//        return UIStatusBarStyleDefault;
//    }
//}
//
//- (BOOL)modalPresentationCapturesStatusBarAppearance {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.contentView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.backView.frame = self.view.frame;
}

- (BOOL)isShowing {
    return self.view.window != nil;
}

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self showIn:self.inViewController animated:animated completion:completion];
}

- (void)showIn:(UIViewController *)viewController completion:(void (^)(void))completion {
    [self showIn:viewController animated:YES completion:completion];
}

- (void)showIn:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    [self showIn:viewController isWrapInNavigationController:NO animated:animated completion:completion];
}

- (void)showIn:(UIViewController *)viewController isWrapInNavigationController:(BOOL)isWrap animated:(BOOL)animated completion:(void (^)(void))completion {
    if (viewController == nil) {
        viewController = [JHGPopupUtils topViewController];
    }
    if (viewController == nil) {
        return;
    }
    
    self.inViewController = viewController;
    UIViewController *presentedViewController = self;
    if (isWrap) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
        presentedViewController = nav;
    }
    presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    presentedViewController.transitioningDelegate = self;
    [viewController presentViewController:presentedViewController animated:animated completion:completion];
}

- (void)hiddenWithCompletion:(void (^)(void))completion {
    [self hiddenWithAnimated:YES completion:completion];
}

- (void)hiddenWithAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
}

#pragma mark- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animator.directionType = JHGPopupAnimateDirectionIn;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animator.directionType = JHGPopupAnimateDirectionOut;
    return self.animator;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    UIPresentationController *controller = [[UIPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
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
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        _contentView = view;
    }
    return _contentView;
}

@end
