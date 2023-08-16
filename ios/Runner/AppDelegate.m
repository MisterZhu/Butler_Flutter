#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "SCFlutterNativePlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [GeneratedPluginRegistrant registerWithRegistry:self];
    
    [[SCFlutterNativePlugin shared] registerWithFlutterViewController:(FlutterViewController *)self.window.rootViewController];
    

    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
