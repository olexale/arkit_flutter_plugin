#import "ArkitPlugin.h"
#import "FlutterArkit.h"

@implementation ArkitPlugin
NSObject<FlutterPluginRegistrar> *_registrar;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  self.registrar = registrar;
  FlutterArkitFactory* arkitFactory =
      [[FlutterArkitFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:arkitFactory withId:@"arkit"];
}

+ (NSObject<FlutterPluginRegistrar> *)registrar {
    return _registrar;
}

+ (void)setRegistrar:(NSObject<FlutterPluginRegistrar> *)newRegistrar {
    if (newRegistrar != _registrar) {
        _registrar = newRegistrar;
    }
}

@end
