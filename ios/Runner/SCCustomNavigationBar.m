//
//  SCCustomNavigationBar.m
//  Runner
//
//  Created by mjl on 2023/1/29.
//

#import "SCCustomNavigationBar.h"
#import <Masonry/Masonry.h>

@interface SCCustomNavigationBar ()

/// 导航栏
@property (nonatomic, strong) UIView *navView;

/// 返回按钮
@property (nonatomic, strong) UIButton *backBtn;

/// 关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;

/// title
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation SCCustomNavigationBar

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.navView];
    [self.navView addSubview:self.backBtn];
    [self.navView addSubview:self.closeBtn];
    [self.navView addSubview:self.titleLabel];
    
    [self setupLayout];
}

- (void)setupLayout {
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusBarHeight);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24.0, 44.0));
        make.left.mas_equalTo(16.0);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24.0, 44.0));
        make.left.equalTo(self.backBtn.mas_right).offset(10.0);
        make.top.bottom.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120.0);
        make.right.mas_equalTo(-120.0);
        make.top.bottom.mas_equalTo(0);
    }];
}

/// 返回
- (void)backAction:(UIButton *)sender {
    if (self.backHandler) {
        self.backHandler();
    }
}

/// 关闭
- (void)closeAction:(UIButton *)sender {
    if (self.closeHandler) {
        self.closeHandler();
    }
}

/// 设置title
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

/// 导航栏内容高度
- (CGFloat)navBarContentHeight {
    return 44.0;
}

/// 状态栏高度
- (CGFloat)statusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/// 导航栏
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
    }
    return _navView;
}

/// 返回按钮
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_backBtn setImage:[[UIImage imageNamed:@"icon_navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

/// 关闭按钮
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeBtn setImage:[[UIImage imageNamed:@"icon_navigation_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

/// title
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:27.0/255.0 green:29.0/255.0 blue:51.0/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:18.0 weight:500];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
