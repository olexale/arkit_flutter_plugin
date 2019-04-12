#import "FlutterArkit.h"

@implementation FlutterArkitFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  FlutterArkitController* arkitController =
      [[FlutterArkitController alloc] initWithWithFrame:frame
                                       viewIdentifier:viewId
                                            arguments:args
                                      binaryMessenger:_messenger];
  return arkitController;
}

@end

@implementation FlutterArkitController {
  ARSCNView* _sceneView;
  int64_t _viewId;
  FlutterMethodChannel* _channel;
}

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if ([super init]) {
    _viewId = viewId;
    _sceneView = [[ARSCNView alloc] initWithFrame:frame];
    NSString* channelName = [NSString stringWithFormat:@"arkit_%lld", viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      [weakSelf onMethodCall:call result:result];
    }];
      
      _sceneView.autoenablesDefaultLighting = YES;
    _sceneView.delegate = self;
  }
  return self;
}

- (UIView*)view {
  return _sceneView;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([[call method] isEqualToString:@"init"]) {
    [self init:call result:result];
  } else if ([[call method] isEqualToString:@"addSphere"]) {
    [self onAddSphere:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* showStatistics = call.arguments[@"showStatistics"];
    _sceneView.showsStatistics = [showStatistics boolValue];
    
    ARConfiguration* configuration = self.configuration;
    [self.sceneView.session runWithConfiguration:configuration];
    result(nil);
}

- (void)onAddSphere:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* radius = call.arguments[@"radius"];
    NSDictionary* position = call.arguments[@"position"];
    NSNumber* x = position[@"x"];
    NSNumber* y = position[@"y"];
    NSNumber* z = position[@"z"];
    
    SCNSphere* sphereGeometry = [SCNSphere sphereWithRadius:[radius doubleValue]];
    SCNNode* sphereNode = [SCNNode nodeWithGeometry:sphereGeometry];
    sphereNode.position = SCNVector3Make([x floatValue], [y floatValue],[z floatValue]);
    [self.sceneView.scene.rootNode addChildNode:sphereNode];
    result(nil);
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    [_channel invokeMethod: @"onError" arguments: @"Error"];
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

#pragma mark - Lazy loads

-(ARWorldTrackingConfiguration *)configuration {
    if (_configuration) {
        return _configuration;
    }
    
    if (!ARWorldTrackingConfiguration.isSupported) {}
    
    _configuration = [ARWorldTrackingConfiguration new];
    _configuration.planeDetection = ARPlaneDetectionHorizontal;
    return _configuration;
}

@end
