//
//  SCFlutterKey.h
//  Runner
//
//  Created by mjl on 2023/1/29.
//

#ifndef SCFlutterKey_h
#define SCFlutterKey_h

#define ISNULL(x) ((x) == nil || [(x) isEqualToString:@"(null)"] ? @"" : (x))

#define kNativeToFlutter @"native_flutter"

#define kFlutterNative @"flutter_native"

#define kWebView @"kNativeIOSWebView"

/// 领料
#define kGotoMaterialKey @"kGotoMaterialKey"


#endif /* SCFlutterKey_h */
