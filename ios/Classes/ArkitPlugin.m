#import "ArkitPlugin.h"
#if __has_include(<arkit_plugin/arkit_plugin-Swift.h>)
#import <arkit_plugin/arkit_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "arkit_plugin-Swift.h"
#endif

@implementation ArkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftArkitPlugin registerWithRegistrar:registrar];
}
@end
