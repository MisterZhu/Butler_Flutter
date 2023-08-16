//
//  SCFlutterNativePlugin.h
//  Runner
//
//  Created by ly on 2022/10/28.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCFlutterNativePlugin : NSObject<FlutterStreamHandler>

/// 单项管道，有可能使用多次
@property (nonatomic, copy) FlutterEventSink eventSink;

/// flutterController
@property (nonatomic, strong) FlutterViewController *flutterController;

/// 初始化
+ (SCFlutterNativePlugin *)shared;

- (void)registerWithFlutterViewController:(FlutterViewController *)flutterViewController;

/// 原生向flutter发送消息
- (void)postData:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
