#import "FlutterArkit.h"
#import "Color.h"
#import "GeometryBuilder.h"
#import "SceneViewDelegate.h"
#import "CodableUtils.h"
#import "DecodableUtils.h"

@interface FlutterArkitFactory()
@property NSObject<FlutterBinaryMessenger>* messenger;
@end

@implementation FlutterArkitFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    self.messenger = messenger;
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
                                        binaryMessenger:self.messenger];
  return arkitController;
}

@end

@interface FlutterArkitController()
@property ARPlaneDetection planeDetection;
@property int64_t viewId;
@property FlutterMethodChannel* channel;
@property (strong) SceneViewDelegate* delegate;
@property (readwrite) ARWorldTrackingConfiguration *configuration;
@end

@implementation FlutterArkitController

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
    self.delegate = [[SceneViewDelegate alloc] initWithChannel: _channel];
    _sceneView.delegate = self.delegate;
  }
  return self;
}

- (UIView*)view {
  return _sceneView;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([[call method] isEqualToString:@"init"]) {
    [self init:call result:result];
  } else if ([[call method] isEqualToString:@"addARKitNode"]) {
      [self onAddNode:call result:result];
  } else if ([[call method] isEqualToString:@"positionChanged"]) {
      [self updatePosition:call andResult:result];
  } else if ([[call method] isEqualToString:@"rotationChanged"]) {
      [self updateRotation:call andResult:result];
  } else if ([[call method] isEqualToString:@"updateSingleGeometryProperty"]) {
      [self updateSingleProperty:call andResult:result];
  } else if ([[call method] isEqualToString:@"updateMaterials"]) {
      [self updateMaterials:call andResult:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* showStatistics = call.arguments[@"showStatistics"];
    self.sceneView.showsStatistics = [showStatistics boolValue];
  
    NSNumber* autoenablesDefaultLighting = call.arguments[@"autoenablesDefaultLighting"];
    self.sceneView.autoenablesDefaultLighting = [autoenablesDefaultLighting boolValue];
  
    NSNumber* requestedPlaneDetection = call.arguments[@"planeDetection"];
    self.planeDetection = [self getPlaneFromNumber:[requestedPlaneDetection intValue]];
    
    if ([call.arguments[@"enableTapRecognizer"] boolValue]) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    }
    
    self.sceneView.debugOptions = [self getDebugOptions:call.arguments];
    
    ARWorldTrackingConfiguration* configuration = self.configuration;
    NSString* detectionImages = call.arguments[@"detectionImagesGroupName"];
    if ([detectionImages isKindOfClass:[NSString class]]) {
        configuration.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:detectionImages bundle:nil];
    }
    [self.sceneView.session runWithConfiguration:configuration];
    result(nil);
}

- (void)onAddNode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* geometryArguments = call.arguments[@"geometry"];
    SCNGeometry* geometry = [GeometryBuilder createGeometry:geometryArguments];
    [self addNodeToSceneWithGeometry:geometry andCall:call andResult:result];
}

#pragma mark - Lazy loads

-(ARWorldTrackingConfiguration *)configuration {
    if (_configuration) {
        return _configuration;
    }
    
    if (!ARWorldTrackingConfiguration.isSupported) {}
    
    _configuration = [ARWorldTrackingConfiguration new];
    _configuration.planeDetection = self.planeDetection;
    return _configuration;
}

#pragma mark - Scene tap event
- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    ARSCNView* sceneView = (ARSCNView *)recognizer.view;
    CGPoint touchLocation = [recognizer locationInView:sceneView];
    NSArray<SCNHitTestResult *> * hitResults = [sceneView hitTest:touchLocation options:@{}];
    if ([hitResults count] != 0) {
        SCNNode *node = hitResults[0].node;
        [_channel invokeMethod: @"onTap" arguments: node.name];
    }
    NSArray<ARHitTestResult *> *arHitResults = [sceneView hitTest:touchLocation types:ARHitTestResultTypeExistingPlaneUsingExtent];
    if ([arHitResults count] != 0) {
        [_channel invokeMethod: @"onPlaneTap" arguments: [CodableUtils convertSimdFloat4x4ToString:arHitResults[0].worldTransform]];
    }
}

#pragma mark - Parameters
- (void) updatePosition:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    node.position = [DecodableUtils parseVector3:call.arguments];
    result(nil);
}

- (void) updateRotation:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    node.rotation = [DecodableUtils parseVector4:call.arguments];
    result(nil);
}

- (void) updateSingleProperty:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    [node.geometry setValue:call.arguments[@"propertyValue"] forKey:call.arguments[@"propertyName"]];
    result(nil);
}

- (void) updateMaterials:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    SCNGeometry* geometry = [GeometryBuilder createGeometry:call.arguments];
    node.geometry = geometry;
    result(nil);
}

#pragma mark - Utils
-(ARPlaneDetection) getPlaneFromNumber: (int) number {
  if (number == 0) {
    return ARPlaneDetectionNone;
  } else if (number == 1) {
    return ARPlaneDetectionHorizontal;
  }
  return ARPlaneDetectionVertical;
}

- (SCNNode *) getNodeWithGeometry:(SCNGeometry *)geometry fromDict:(NSDictionary *)dict {
    SCNNode* node = [SCNNode nodeWithGeometry:geometry];
    node.position = [DecodableUtils parseVector3:dict[@"position"]];
    
    if (dict[@"scale"] != nil) {
        node.scale = [DecodableUtils parseVector3:dict[@"scale"]];
    }
    if (dict[@"rotation"] != nil) {
        node.rotation = [DecodableUtils parseVector4:dict[@"rotation"]];
    }
    if (dict[@"name"] != nil) {
        node.name = dict[@"name"];
    }
    if (dict[@"physicsBody"] != nil) {
        NSDictionary *physics = dict[@"physicsBody"];
        node.physicsBody = [self getPhysicsBodyFromDict:physics];
    }
    return node;
}

- (SCNPhysicsBody *) getPhysicsBodyFromDict:(NSDictionary *)dict {
    NSNumber* type = dict[@"type"];
    
    SCNPhysicsShape* shape;
    if (dict[@"shape"] != nil) {
        NSDictionary* shapeDict = dict[@"shape"];
        if (shapeDict[@"geometry"] != nil) {
            shape = [SCNPhysicsShape shapeWithGeometry:[GeometryBuilder createGeometry:shapeDict[@"geometry"]] options:nil];
        }
    }
    
    SCNPhysicsBody* physicsBody = [SCNPhysicsBody bodyWithType:[type intValue] shape:shape];
    if (dict[@"categoryBitMask"] != nil) {
        NSNumber* mask = dict[@"categoryBitMask"];
        physicsBody.categoryBitMask = [mask unsignedIntegerValue];
    }
    
    return physicsBody;
}

- (void) addNodeToSceneWithGeometry:(SCNGeometry*)geometry andCall: (FlutterMethodCall*)call andResult:(FlutterResult)result{
    SCNNode* node = [self getNodeWithGeometry:geometry fromDict:call.arguments];
    if (call.arguments[@"parentNodeName"] != nil) {
        SCNNode *parentNode = [self.sceneView.scene.rootNode childNodeWithName:call.arguments[@"parentNodeName"] recursively:YES];
        [parentNode addChildNode:node];
    } else {
        [self.sceneView.scene.rootNode addChildNode:node];
    }
    result(nil);
}

- (SCNDebugOptions) getDebugOptions:(NSDictionary*)arguments{
    SCNDebugOptions debugOptions = SCNDebugOptionNone;
    if ([arguments[@"showFeaturePoints"] boolValue]) {
        debugOptions += ARSCNDebugOptionShowFeaturePoints;
    }
    if ([arguments[@"showWorldOrigin"] boolValue]) {
        debugOptions += ARSCNDebugOptionShowWorldOrigin;
    }
    return debugOptions;
}

@end
