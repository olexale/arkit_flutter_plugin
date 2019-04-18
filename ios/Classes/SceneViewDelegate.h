@import ARKit;
@import Flutter;

@interface SceneViewDelegate: NSObject<ARSCNViewDelegate>
- (instancetype)initWithChannel:(FlutterMethodChannel*) channel;
@end
