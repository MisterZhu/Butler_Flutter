//
//  SCFlutterNativePlugin.h
//  Runner
//
//  Created by ly on 2022/10/28.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCFlutterNativePlugin : NSObject<FlutterPlugin>

///// 单项管道，有可能使用多次
//@property (nonatomic, copy) FlutterEventSink eventSink;
//
///// flutterController
//@property (nonatomic, strong) SCFlutterViewController *flutterController;
//
///// 获取当前用户
//+ (SCFlutterNativePlugin *)shared;
//
///// 原生向Flutter传递参数
//- (void)postData:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
