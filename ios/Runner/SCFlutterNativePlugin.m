//
//  SCFlutterNativePlugin.m
//  Runner
//
//  Created by ly on 2022/10/28.
//

#import "SCFlutterNativePlugin.h"
#import "GeneratedPluginRegistrant.h"
#import "SCCurrentViewController.h"
#import "SCWebViewController.h"

#define kNativeToFlutter @"native_flutter"
#define kFlutterNative @"flutter_native"

static SCFlutterNativePlugin *plugin;

@interface SCFlutterNativePlugin ()

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation SCFlutterNativePlugin

+ (SCFlutterNativePlugin *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        plugin = [[SCFlutterNativePlugin alloc] init];
    });
    return plugin;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)registerWithFlutterViewController:(FlutterViewController *)flutterViewController{
    self.flutterController = flutterViewController;
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterController];
    [self nativeToFlutter];
    [self flutterToNative];
}

/// 原生向flutter发送消息
- (void)postData:(NSDictionary *)params {
    if (self.eventSink) {
        self.eventSink(params);
    }else {
        [self.messageArray addObject:params];
    }
}

/// 原生-flutter
- (void)nativeToFlutter{
    FlutterEventChannel *event = [FlutterEventChannel eventChannelWithName:kNativeToFlutter binaryMessenger:self.flutterController.binaryMessenger];
    [event setStreamHandler:self];
}

/// flutter-原生
- (void)flutterToNative{
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:kFlutterNative binaryMessenger:self.flutterController.binaryMessenger];
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"kShowAlert"]) {// 弹窗
            [self showAlert:call.arguments];
        }
    }];
}

#pragma - mark flutter-delegate
/// flutter-delegate
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    if (events) {
        self.eventSink  = events;
        if (self.messageArray.count > 0) {
            for (NSDictionary *dic in self.messageArray) {
                self.eventSink(dic);
            }
            [self.messageArray removeAllObjects];
        }
    }
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    return nil;
}

- (void)showAlert:(id)params {
}

- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _messageArray;
}

@end
