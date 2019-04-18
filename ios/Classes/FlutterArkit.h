@import Flutter;
@import ARKit;
@import SceneKit;

API_AVAILABLE(ios(11.3))
@interface FlutterArkitController : NSObject <FlutterPlatformView>

- (nonnull instancetype)initWithWithFrame:(CGRect)frame
                           viewIdentifier:(int64_t)viewId
                                arguments:(id _Nullable)args
                          binaryMessenger:(nonnull NSObject<FlutterBinaryMessenger>*)messenger;

- (nonnull UIView*)view;

@property (readonly, nonatomic, strong, nonnull) ARSCNView *sceneView;
@property (readonly, nonatomic, strong, nonnull) ARWorldTrackingConfiguration *configuration;

@end

@interface FlutterArkitFactory : NSObject <FlutterPlatformViewFactory>
- (nonnull instancetype)initWithMessenger:(nonnull NSObject<FlutterBinaryMessenger>*)messenger;
@end
