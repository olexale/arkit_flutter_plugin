#import <Flutter/Flutter.h>
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface FlutterArkitController : NSObject <FlutterPlatformView, ARSCNViewDelegate>

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (UIView*)view;

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) ARWorldTrackingConfiguration *configuration;

@end

@interface FlutterArkitFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
