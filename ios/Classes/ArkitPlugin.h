#import <Flutter/Flutter.h>

@interface ArkitPlugin : NSObject<FlutterPlugin>
@property (class, nonatomic) NSObject<FlutterPluginRegistrar> *registrar;
@end
