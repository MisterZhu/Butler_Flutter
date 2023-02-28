//
//  SCWebViewController.h
//  Runner
//
//  Created by mjl on 2023/1/13.
//  webview

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCWebViewController : UIViewController

/// title
@property (nonatomic, copy) NSString *titleString;

/// url
@property (nonatomic, copy) NSString  *urlString;

/// 完成回调
@property (nonatomic, copy) void(^completeHandler)(id data);

@end

NS_ASSUME_NONNULL_END
