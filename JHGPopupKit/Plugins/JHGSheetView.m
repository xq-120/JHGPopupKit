//
//  JHGPopupView.m
//  JHGPopupKit
//
//  Created by 薛权 on 2025/7/26.
//

#import "JHGSheetView.h"
#import <Masonry/Masonry.h>
#import "JHGPopupKit/JHGPopupViewPresentAnimation.h"
#import "JHGPopupKit/UIView+JHGRoundingCorners.h"

@interface JHGSheetView ()

@property (nonatomic, strong, readwrite) UILabel *sheetTitleLabel;
@property (nonatomic, strong, readwrite) UILabel *sheetSubtitleLabel;
@property (nonatomic, strong) UIStackView *titlesStackView;

@property (nonatomic, strong, readwrite) UIView *seperateView;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;

@property (nonatomic, strong, readwrite) NSMutableArray *buttons;

@property (nonatomic, strong, readwrite) NSMutableDictionary *actionsDict;

@property (nonatomic, copy) void(^actionBlk)(NSInteger);

@end

@implementation JHGSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _contentViewCorner = 10.0;
        
        _topMargin = 0;
        _subtitleBtnMargin = 0;
        _titleExtraHeight = 30.0;
        _subtitleExtraHeight = 10.0;
        _seperateViewHeight = 6;
        
        _sheetBtnHeight = 50;
        _btnTitleFont = [UIFont systemFontOfSize:14];
        _btnTitleColor = [UIColor blackColor];
        
        _btnLineViewHeight = 1/[UIScreen mainScreen].scale;
        _btnLineViewBgColor = [UIColor colorWithRed:205 / 255.0 green:205 / 255.0 blue:205 / 255.0 alpha:1];
        
        self.animator = [[JHGPopupViewPresentAnimation alloc] init];
        self.shouldDismissOnTouchBackView = true;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titlesStackView];
    [self.titlesStackView addArrangedSubview:self.sheetTitleLabel];
    [self.titlesStackView addArrangedSubview:self.sheetSubtitleLabel];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
    }];
    
    [self.titlesStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(self.topMargin);
    }];
    
    [self.sheetTitleLabel sizeToFit];
    CGFloat titleH = ceil(self.sheetTitleLabel.frame.size.height);
    [self.sheetSubtitleLabel sizeToFit];
    CGFloat subtitleH = ceil(self.sheetSubtitleLabel.frame.size.height);
    
    [self.sheetTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleH + self.titleExtraHeight);
    }];
    [self.sheetSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(subtitleH + self.subtitleExtraHeight);
    }];
    
    if (self.hiddenTitleLabel) {
        self.sheetTitleLabel.hidden = YES;
    }
    if (self.hiddenSubtitleLabel) {
        self.sheetSubtitleLabel.hidden = YES;
    }
    
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        UIButton *btn = [self.buttons objectAtIndex:i];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.backgroundColor = self.btnLineViewBgColor;
        [btn addSubview:lineView];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.contentView);
            make.top.equalTo(self.titlesStackView.mas_bottom).offset(i * self.sheetBtnHeight + self.subtitleBtnMargin);
            make.height.mas_equalTo(self.sheetBtnHeight);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(btn).offset(self.btnLineViewEdgePadding);
            make.trailing.equalTo(btn).offset(-self.btnLineViewEdgePadding);
            make.height.mas_equalTo(self.btnLineViewHeight);
            make.bottom.equalTo(btn);
        }];
        if (i == 0 && !(self.hiddenTitleLabel && self.hiddenSubtitleLabel)) {
            UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
            topLineView.backgroundColor = self.btnLineViewBgColor;
            [btn addSubview:topLineView];
            
            [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(btn).offset(self.btnLineViewEdgePadding);
                make.trailing.equalTo(btn).offset(-self.btnLineViewEdgePadding);
                make.height.mas_equalTo(self.btnLineViewHeight);
                make.top.equalTo(btn);
            }];
        }
        if (i == self.buttons.count - 1) {
            lineView.hidden = true;
        }
    }
    
    UIButton *lastBtn = self.buttons.lastObject;
    UIView *preView = lastBtn == nil ? self.titlesStackView : lastBtn;
    
    if (!self.hiddenCancelButton) {
        [self.contentView addSubview:self.seperateView];
        [self.contentView addSubview:self.cancelButton];
        
        [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(0);
            make.trailing.equalTo(self.contentView).offset(0);
            make.top.equalTo(preView.mas_bottom);
            make.height.mas_equalTo(self.seperateViewHeight);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.contentView);
            make.top.equalTo(self.seperateView.mas_bottom);
            make.height.mas_equalTo(self.sheetBtnHeight);
            make.bottom.equalTo(self.contentView).offset(-[UIDevice jh_homeIndicatorHeight]);
        }];
    } else {
        [preView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-[UIDevice jh_homeIndicatorHeight]);
        }];
    }
    
    [self layoutIfNeeded];
    [self.contentView jh_addRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(_contentViewCorner, _contentViewCorner)];
}

- (void)showSheetWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionBlk:(void (^)(NSInteger))actionBlk completion:(void (^)(void))completion {
    self.sheetTitleLabel.text = title;
    self.sheetSubtitleLabel.text = subtitle;
    self.actionBlk = actionBlk;
    NSInteger index = 0;
    for (NSString *title in buttonTitles) {
        UIButton *btn = [self createBtnWithConfigHandler:nil title:title];
        btn.tag = 1000 + index;
        [self.buttons addObject:btn];
        index += 1;
    }
    [self showIn:nil animated:YES completion:completion];
}

- (void)showIn:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    if (self.sheetTitleLabel.text.length == 0 && self.sheetTitleLabel.attributedText.length == 0) {
        self.hiddenTitleLabel = YES;
    }
    if (self.sheetSubtitleLabel.text.length == 0 && self.sheetSubtitleLabel.attributedText.length == 0) {
        self.hiddenSubtitleLabel = YES;
    }
    [self setupViews];
    [super showIn:view animated:animated completion:completion];
}

- (void)addBtnWithConfigHandler:(void (^)(UIButton *button))configHandler actionHandler:(void (^)(UIButton *button, NSInteger buttonIndex))handler
{
    UIButton *btn = [self createBtnWithConfigHandler:configHandler title:nil];
    [self.buttons addObject:btn];
    
    NSInteger index = [self.buttons indexOfObject:btn];
    btn.tag = 100 + index;
    [self.actionsDict setObject:[handler copy] forKey:@(index)];
}

- (UIButton *)createBtnWithConfigHandler:(void (^_Nullable)(UIButton *button))configHandler title:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.titleLabel.font = self.btnTitleFont;
    btn.backgroundColor = [UIColor whiteColor];
    if (configHandler) {
        configHandler(btn);
    }
    [btn addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)onClicked:(UIButton *)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if (sender.tag >= 1000) {
        [self hiddenWithCompletion:^{
            if (self.actionBlk) {
                self.actionBlk(index);
            }
        }];
    } else {
        void (^actionBlk)(UIButton *, NSInteger) = [self.actionsDict objectForKey:@(index)];
        [self hiddenWithCompletion:^{
            if (actionBlk) {
                actionBlk(sender, index);
            }
        }];
    }
}

- (void)cancelButtonTapped:(UIButton *)sender {
    [self hiddenWithCompletion:self.cancelActionBlock];
}

- (UIStackView *)titlesStackView {
    if (_titlesStackView == nil) {
        UIStackView *s = [[UIStackView alloc] init];
        _titlesStackView = s;
        s.spacing = 0;
        s.axis = UILayoutConstraintAxisVertical;
        s.distribution = UIStackViewDistributionFill;
        s.alignment = UIStackViewAlignmentFill;
    }
    return _titlesStackView;
}

- (NSArray *)buttonsArray {
    return self.buttons.copy;
}

- (NSMutableArray<UIButton *> *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableDictionary *)actionsDict {
    if (_actionsDict == nil) {
        _actionsDict = [NSMutableDictionary dictionary];
    }
    return _actionsDict;
}

- (UIView *)seperateView {
    if (_seperateView == nil) {
        _seperateView = UIView.new;
        _seperateView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    }
    return _seperateView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"取消" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton = btn;
    }
    return _cancelButton;
}

- (UILabel *)sheetTitleLabel {
    if (_sheetTitleLabel == nil) {
        _sheetTitleLabel = [[UILabel alloc] init];
        _sheetTitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
        _sheetTitleLabel.font = [UIFont systemFontOfSize:16];
        _sheetTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sheetTitleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _sheetTitleLabel;
}

- (UILabel *)sheetSubtitleLabel {
    if (_sheetSubtitleLabel == nil) {
        _sheetSubtitleLabel = [[UILabel alloc] init];
        _sheetSubtitleLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
        _sheetSubtitleLabel.font = [UIFont systemFontOfSize:12];
        _sheetSubtitleLabel.textAlignment = NSTextAlignmentCenter;
        _sheetSubtitleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _sheetSubtitleLabel;
}

@end
