//
//  SCCustomNavigationBar.h
//  Runner
//
//  Created by mjl on 2023/1/29.
//  导航栏

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCCustomNavigationBar : UIView

/// 返回
@property (nonatomic, copy) void(^backHandler)(void);

/// 关闭
@property (nonatomic, copy) void(^closeHandler)(void);

/// title
@property (nonatomic, copy) NSString *title;

/// 导航栏内容高度
- (CGFloat)navBarContentHeight;

/// 状态栏高度
- (CGFloat)statusBarHeight;

@end

NS_ASSUME_NONNULL_END
