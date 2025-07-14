//
//  JHAlertView.m
//  JHGPopupView
//
//  Created by uzzi on 2025/7/10.
//

#import "JHGAlertView.h"
#import <Masonry/Masonry.h>

@implementation JHGAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _contentViewCorner = 8.0;
        
        _topMargin = 30;
        _titleContentMargin = 15;
        _contentBtnMargin = 30;
        
        _alertViewEdgeMargin = 30;
        _titleEdgeMargin = 20;
        _contentEdgeMargin = 20;
        _buttonEdgeMargin = 20;
        _buttonIntervalMargin = 12;
        _bottomMargin = 0;
        
        _buttonHeight = 50;
        _minAlertHeight = -1;
        
        _buttonLayoutStyle = JHGAlertViewButtonLayoutStyleHorizon;
        
        [self initializeSubviews];
    }
    return self;
}

- (void)initializeSubviews {
    self.contentView.layer.cornerRadius = self.contentViewCorner;
    self.contentView.layer.masksToBounds = true;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.leftBtn];
    [self.contentView addSubview:self.rightBtn];
    [self.contentView addSubview:self.line1View];
    [self.contentView addSubview:self.line2View];
}

- (void)makeSubviewContraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(self.alertViewEdgeMargin);
        make.center.equalTo(self);
        if (self.minAlertHeight != -1) {
            make.height.mas_greaterThanOrEqualTo(self.minAlertHeight);
        }
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(self.titleEdgeMargin);
        make.trailing.equalTo(self.contentView).offset(-self.titleEdgeMargin);
        make.top.equalTo(self.contentView).offset(self.topMargin);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(self.contentEdgeMargin);
        make.trailing.equalTo(self.contentView).offset(-self.contentEdgeMargin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(self.titleContentMargin);
    }];
    
    if (self.buttonLayoutStyle == JHGAlertViewButtonLayoutStyleHorizon) {
        [self.line1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(0);
            make.trailing.equalTo(self.contentView).offset(-0);
            make.top.equalTo(self.leftBtn.mas_top).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.minAlertHeight != -1) {
                make.top.greaterThanOrEqualTo(self.contentLabel.mas_bottom).offset(self.contentBtnMargin);
            } else {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(self.contentBtnMargin);
            }
            make.leading.equalTo(self.contentView);
            if (self.onlyShowLeftBtn) {
                make.trailing.equalTo(self.contentView);
            }
            make.height.mas_equalTo(self.buttonHeight);
            make.bottom.equalTo(self.contentView).offset(-self.bottomMargin);
        }];
        
        self.rightBtn.hidden = self.onlyShowLeftBtn;
        
        if (!self.onlyShowLeftBtn) {
            [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.height.width.equalTo(self.leftBtn);
                make.leading.equalTo(self.leftBtn.mas_trailing);
                make.trailing.equalTo(self.contentView);
            }];
            
            [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line1View.mas_bottom).offset(10);
                make.centerX.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView).offset(-10);
                make.width.mas_equalTo(0.5);
            }];
        }
    } else {
        [self.line1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(0);
            make.trailing.equalTo(self.contentView).offset(-0);
            make.top.equalTo(self.leftBtn.mas_top).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.minAlertHeight != -1) {
                make.top.greaterThanOrEqualTo(self.contentLabel.mas_bottom).offset(self.contentBtnMargin);
            } else {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(self.contentBtnMargin);
            }
            make.leading.equalTo(self.contentView).offset(self.buttonEdgeMargin);
            make.trailing.equalTo(self.contentView).offset(-self.buttonEdgeMargin);
            make.height.mas_equalTo(self.buttonHeight);
            
            if (self.onlyShowLeftBtn) {
                make.bottom.equalTo(self.contentView).offset(-self.bottomMargin);
            }
        }];
        
        self.rightBtn.hidden = self.onlyShowLeftBtn;
        if (!self.onlyShowLeftBtn) {
            [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.leftBtn.mas_bottom).offset(self.buttonIntervalMargin / 2.0);
                make.leading.equalTo(self.contentView).offset(0);
                make.trailing.equalTo(self.contentView).offset(-0);
                make.height.mas_equalTo(0.5);
            }];
            
            [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.leftBtn.mas_bottom).offset(self.buttonIntervalMargin);
                make.height.equalTo(self.leftBtn);
                make.leading.equalTo(self.leftBtn);
                make.trailing.equalTo(self.leftBtn);
                make.bottom.equalTo(self.contentView).offset(-self.bottomMargin);
            }];
        }
    }
}

- (void)showIn:(UIView *)view animated:(BOOL)animated completion:(void (^)(void))completion {
    [self makeSubviewContraints];
    [super showIn:view animated:animated completion:completion];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *v = [UILabel new];
        v.numberOfLines = 0;
        v.textColor = UIColor.blackColor;
        v.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        v.textAlignment = NSTextAlignmentCenter;
        _titleLabel = v;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *v = [UILabel new];
        v.numberOfLines = 0;
        v.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        v.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        v.textAlignment = NSTextAlignmentCenter;
        _contentLabel = v;
    }
    return _contentLabel;
}

- (UIView *)line1View {
    if (_line1View == nil) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05];
        _line1View = v;
    }
    return _line1View;
}

- (UIView *)line2View {
    if (_line2View == nil) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05];
        _line2View = v;
    }
    return _line2View;
}

- (UIButton *)leftBtn {
    if (_leftBtn == nil) {
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.adjustsImageWhenHighlighted = NO;
        v.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        [v setTitle:@"取消" forState:(UIControlStateNormal)];
        [v setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:(UIControlStateNormal)];
        [v addTarget:self action:@selector(onTapLeftBtn) forControlEvents:(UIControlEventTouchUpInside)];
        _leftBtn = v;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (_rightBtn == nil) {
        UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
        v.adjustsImageWhenHighlighted = NO;
        v.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        [v setTitle:@"确定" forState:(UIControlStateNormal)];
        [v setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:(UIControlStateNormal)];
        [v addTarget:self action:@selector(onTapRightBtn) forControlEvents:(UIControlEventTouchUpInside)];
        _rightBtn = v;
    }
    return _rightBtn;
}

- (void)onTapLeftBtn {
    [self hiddenWithAnimated:true completion:self.leftActionBlk];
}

- (void)onTapRightBtn {
    [self hiddenWithAnimated:true completion:self.rightActionBlk];
}

@end
