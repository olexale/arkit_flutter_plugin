#import "ArkitPlugin.h"
#import "FlutterArkit.h"

@implementation ArkitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterArkitFactory* arkitFactory =
      [[FlutterArkitFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:arkitFactory withId:@"arkit"];
}

@end
