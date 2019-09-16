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
@property (readwrite) ARConfiguration *configuration;
@property BOOL forceUserTapOnCenter;
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
  } else if ([[call method] isEqualToString:@"removeARKitNode"]) {
      [self onRemoveNode:call result:result];
  } else if ([[call method] isEqualToString:@"getNodeBoundingBox"]) {
      [self onGetNodeBoundingBox:call result:result];
  } else if ([[call method] isEqualToString:@"positionChanged"]) {
      [self updatePosition:call andResult:result];
  } else if ([[call method] isEqualToString:@"rotationChanged"]) {
      [self updateRotation:call andResult:result];
  } else if ([[call method] isEqualToString:@"eulerAnglesChanged"]) {
      [self updateEulerAngles:call andResult:result];
  } else if ([[call method] isEqualToString:@"scaleChanged"]) {
      [self updateScale:call andResult:result];
  } else if ([[call method] isEqualToString:@"updateSingleProperty"]) {
      [self updateSingleProperty:call andResult:result];
  } else if ([[call method] isEqualToString:@"updateMaterials"]) {
      [self updateMaterials:call andResult:result];
  } else if ([[call method] isEqualToString:@"updateFaceGeometry"]) {
      [self updateFaceGeometry:call andResult:result];
  } else if ([[call method] isEqualToString:@"getLightEstimate"]) {
      [self onGetLightEstimate:call andResult:result];
  } else if ([[call method] isEqualToString:@"projectPoint"]) {
      [self onProjectPoint:call andResult:result];
  } else if ([[call method] isEqualToString:@"dispose"]) {
      [self.sceneView.session pause];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* showStatistics = call.arguments[@"showStatistics"];
    self.sceneView.showsStatistics = [showStatistics boolValue];
  
    NSNumber* autoenablesDefaultLighting = call.arguments[@"autoenablesDefaultLighting"];
    self.sceneView.autoenablesDefaultLighting = [autoenablesDefaultLighting boolValue];
    
    NSNumber* forceUserTapOnCenter = call.arguments[@"forceUserTapOnCenter"];
    self.forceUserTapOnCenter = [forceUserTapOnCenter boolValue];
  
    NSNumber* requestedPlaneDetection = call.arguments[@"planeDetection"];
    self.planeDetection = [self getPlaneFromNumber:[requestedPlaneDetection intValue]];
    
    if ([call.arguments[@"enableTapRecognizer"] boolValue]) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    }
    
    if ([call.arguments[@"enablePinchRecognizer"] boolValue]) {
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
        [self.sceneView addGestureRecognizer:pinchGestureRecognizer];
    }
    
    if ([call.arguments[@"enablePanRecognizer"] boolValue]) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        [self.sceneView addGestureRecognizer:panGestureRecognizer];
    }
    
    self.sceneView.debugOptions = [self getDebugOptions:call.arguments];
    
    _configuration = [self buildConfiguration: call.arguments];

    [self.sceneView.session runWithConfiguration:[self configuration]];
    result(nil);
}

- (ARConfiguration*) buildConfiguration: (NSDictionary*)params {
    int configurationType = [params[@"configuration"] intValue];
    ARConfiguration* _configuration;
    
    if (configurationType == 0) {
        if (ARWorldTrackingConfiguration.isSupported) {
            ARWorldTrackingConfiguration* worldTrackingConfiguration = [ARWorldTrackingConfiguration new];
            worldTrackingConfiguration.planeDetection = self.planeDetection;
            NSString* detectionImages = params[@"detectionImagesGroupName"];
            if ([detectionImages isKindOfClass:[NSString class]]) {
                worldTrackingConfiguration.detectionImages = [ARReferenceImage referenceImagesInGroupNamed:detectionImages bundle:nil];
            }
            _configuration = worldTrackingConfiguration;
        }
    } else if (configurationType == 1) {
        if (ARFaceTrackingConfiguration.isSupported) {
            ARFaceTrackingConfiguration* faceTrackingConfiguration = [ARFaceTrackingConfiguration new];
            _configuration = faceTrackingConfiguration;
        }
    }
    NSNumber* worldAlignment = params[@"worldAlignment"];
    _configuration.worldAlignment = [self getWorldAlignmentFromNumber:[worldAlignment intValue]];
    return _configuration;
}

- (void)onAddNode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* geometryArguments = call.arguments[@"geometry"];
    SCNGeometry* geometry = [GeometryBuilder createGeometry:geometryArguments withDevice: _sceneView.device];
    [self addNodeToSceneWithGeometry:geometry andCall:call andResult:result];
}

- (void)onRemoveNode:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* nodeName = call.arguments[@"nodeName"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:nodeName recursively:YES];
    [node removeFromParentNode];
    result(nil);
}

- (void)onGetNodeBoundingBox:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* geometryArguments = call.arguments[@"geometry"];
    SCNGeometry* geometry = [GeometryBuilder createGeometry:geometryArguments withDevice: _sceneView.device];
    SCNNode* node = [self getNodeWithGeometry:geometry fromDict:call.arguments];
    SCNVector3 minVector, maxVector;
    [node getBoundingBoxMin:&minVector max:&maxVector];
    
    result(@[[CodableUtils convertSimdFloat3ToString:SCNVector3ToFloat3(minVector)],
             [CodableUtils convertSimdFloat3ToString:SCNVector3ToFloat3(maxVector)]]
           );
}

#pragma mark - Lazy loads

-(ARConfiguration *)configuration {
    return _configuration;
}

#pragma mark - Scene tap event
- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    if (![recognizer.view isKindOfClass:[ARSCNView class]])
        return;
    
    ARSCNView* sceneView = (ARSCNView *)recognizer.view;
    CGPoint touchLocation = self.forceUserTapOnCenter
        ? self.sceneView.center
        : [recognizer locationInView:sceneView];
    NSArray<SCNHitTestResult *> * hitResults = [sceneView hitTest:touchLocation options:@{}];
    if ([hitResults count] != 0) {
        SCNNode *node = hitResults[0].node;
        [_channel invokeMethod: @"onNodeTap" arguments: node.name];
    }

    NSArray<ARHitTestResult *> *arHitResults = [sceneView hitTest:touchLocation types:ARHitTestResultTypeFeaturePoint
                                                + ARHitTestResultTypeEstimatedHorizontalPlane
                                                + ARHitTestResultTypeEstimatedVerticalPlane
                                                + ARHitTestResultTypeExistingPlane
                                                + ARHitTestResultTypeExistingPlaneUsingExtent
                                                + ARHitTestResultTypeExistingPlaneUsingGeometry
                                                ];
    if ([arHitResults count] != 0) {
        NSMutableArray<NSDictionary*>* results = [NSMutableArray arrayWithCapacity:[arHitResults count]];
        for (ARHitTestResult* r in arHitResults) {
            [results addObject:[self getDictFromHitResult:r]];
        }
        [_channel invokeMethod: @"onARTap" arguments: results];
    }
}

- (void) handlePinchFrom: (UIPinchGestureRecognizer *) recognizer
{
    if (![recognizer.view isKindOfClass:[ARSCNView class]])
        return;
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        ARSCNView* sceneView = (ARSCNView *)recognizer.view;
        CGPoint touchLocation = [recognizer locationInView:sceneView];
        NSArray<SCNHitTestResult *> * hitResults = [sceneView hitTest:touchLocation options:@{}];
        
        NSMutableArray<NSDictionary*>* results = [NSMutableArray arrayWithCapacity:[hitResults count]];
        for (SCNHitTestResult* r in hitResults) {
            if (r.node.name != nil) {
                [results addObject:@{@"name" : r.node.name, @"scale" : @(recognizer.scale)}];
            }
        }
        if ([results count] != 0) {
            [_channel invokeMethod: @"onNodePinch" arguments: results];
        }
        recognizer.scale = 1;
    }
}

- (void) handlePanFrom: (UIPanGestureRecognizer *) recognizer
{
    if (![recognizer.view isKindOfClass:[ARSCNView class]])
        return;
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        ARSCNView* sceneView = (ARSCNView *)recognizer.view;
        CGPoint touchLocation = [recognizer locationInView:sceneView];
        CGPoint translation = [recognizer translationInView:sceneView];
        NSArray<SCNHitTestResult *> * hitResults = [sceneView hitTest:touchLocation options:@{}];
        
        NSMutableArray<NSDictionary*>* results = [NSMutableArray arrayWithCapacity:[hitResults count]];
        for (SCNHitTestResult* r in hitResults) {
            if (r.node.name != nil) {
                [results addObject:@{@"name" : r.node.name, @"x" : @(translation.x), @"y":@(translation.y)}];
            }
        }
        if ([results count] != 0) {
            [_channel invokeMethod: @"onNodePan" arguments: results];
        }
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

- (void) updateEulerAngles:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    node.eulerAngles = [DecodableUtils parseVector3:call.arguments];
    result(nil);
}

- (void) updateScale:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    node.scale = [DecodableUtils parseVector3:call.arguments];
    result(nil);
}

- (void) updateSingleProperty:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    
    NSString* keyProperty = call.arguments[@"keyProperty"];
    id object = [node valueForKey:keyProperty];
    
    [object setValue:call.arguments[@"propertyValue"] forKey:call.arguments[@"propertyName"]];
    result(nil);
}

- (void) updateMaterials:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    SCNGeometry* geometry = [GeometryBuilder createGeometry:call.arguments withDevice: _sceneView.device];
    node.geometry = geometry;
    result(nil);
}

- (void) updateFaceGeometry:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:YES];
    ARSCNFaceGeometry* geometry = (ARSCNFaceGeometry*)node.geometry;
    ARFaceAnchor* faceAnchor = [self findAnchor:call.arguments[@"fromAnchorId"] inArray:self.sceneView.session.currentFrame.anchors];
    
    [geometry updateFromFaceGeometry:faceAnchor.geometry];
    
    result(nil);
}

-(ARFaceAnchor*)findAnchor:(NSString*)searchUUID inArray:(NSArray<ARAnchor *>*)array{
    for (ARAnchor* obj in array){
        if([[obj.identifier UUIDString] isEqualToString:searchUUID])
            return (ARFaceAnchor*)obj;
    }
    return NULL;
}

- (void) onGetLightEstimate:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    ARFrame* frame = self.sceneView.session.currentFrame;
    if (frame != nil && frame.lightEstimate != nil) {
        NSDictionary* res = @{
                              @"ambientIntensity": @(frame.lightEstimate.ambientIntensity),
                              @"ambientColorTemperature": @(frame.lightEstimate.ambientColorTemperature)
                              };
        result(res);
    }
    result(nil);
}

- (void) onProjectPoint:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    SCNVector3 point =  [DecodableUtils parseVector3:call.arguments[@"point"]];
    SCNVector3 projectedPoint = [_sceneView projectPoint:point];
    NSString* coded = [CodableUtils convertSimdFloat3ToString:SCNVector3ToFloat3(projectedPoint)];
    result(coded);
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

-(ARWorldAlignment) getWorldAlignmentFromNumber: (int) number {
    if (number == 0) {
        return ARWorldAlignmentGravity;
    } else if (number == 1) {
        return ARWorldAlignmentGravityAndHeading;
    }
    return ARWorldAlignmentCamera;
}

- (SCNNode *) getNodeWithGeometry:(SCNGeometry *)geometry fromDict:(NSDictionary *)dict {
    SCNNode* node;
    if ([dict[@"dartType"] isEqualToString:@"ARKitNode"]) {
        node = [SCNNode nodeWithGeometry:geometry];
    } else if ([dict[@"dartType"] isEqualToString:@"ARKitReferenceNode"]) {
        NSString* url = dict[@"url"];
        NSURL* referenceURL = [[NSBundle mainBundle] URLForResource:url withExtension:nil];
        node = [SCNReferenceNode referenceNodeWithURL:referenceURL];
        [(SCNReferenceNode*)node load];
    } else {
        return nil;
    }
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
    if (dict[@"light"] != nil) {
        NSDictionary *light = dict[@"light"];
        node.light = [self getLightFromDict: light];
    }
    
    NSNumber* renderingOrder = dict[@"renderingOrder"];
    node.renderingOrder = [renderingOrder integerValue];
    
    return node;
}

- (SCNPhysicsBody *) getPhysicsBodyFromDict:(NSDictionary *)dict {
    NSNumber* type = dict[@"type"];
    
    SCNPhysicsShape* shape;
    if (dict[@"shape"] != nil) {
        NSDictionary* shapeDict = dict[@"shape"];
        if (shapeDict[@"geometry"] != nil) {
            shape = [SCNPhysicsShape shapeWithGeometry:[GeometryBuilder createGeometry:shapeDict[@"geometry"] withDevice:_sceneView.device] options:nil];
        }
    }
    
    SCNPhysicsBody* physicsBody = [SCNPhysicsBody bodyWithType:[type intValue] shape:shape];
    if (dict[@"categoryBitMask"] != nil) {
        NSNumber* mask = dict[@"categoryBitMask"];
        physicsBody.categoryBitMask = [mask unsignedIntegerValue];
    }
    
    return physicsBody;
}

- (SCNLight *) getLightFromDict:(NSDictionary *)dict {
    SCNLight* light = [SCNLight light];
    if (dict[@"type"] != nil) {
        SCNLightType lightType;
        int type = [dict[@"type"] intValue];
        switch (type) {
            case 0:
                lightType = SCNLightTypeAmbient;
                break;
            case 1:
                lightType = SCNLightTypeOmni;
                break;
            case 2:
                lightType =SCNLightTypeDirectional;
                break;
            case 3:
                lightType =SCNLightTypeSpot;
                break;
            case 4:
                lightType =SCNLightTypeIES;
                break;
            case 5:
                lightType =SCNLightTypeProbe;
                break;
            default:
                break;
        }
        light.type = lightType;
    }
    if (dict[@"temperature"] != nil) {
        NSNumber* temperature = dict[@"temperature"];
        light.temperature = [temperature floatValue];
    }
    if (dict[@"intensity"] != nil) {
        NSNumber* intensity = dict[@"intensity"];
        light.intensity = [intensity floatValue];
    }
    if (dict[@"spotInnerAngle"] != nil) {
        NSNumber* spotInnerAngle = dict[@"spotInnerAngle"];
        light.spotInnerAngle = [spotInnerAngle floatValue];
    }
    if (dict[@"spotOuterAngle"] != nil) {
        NSNumber* spotOuterAngle = dict[@"spotOuterAngle"];
        light.spotOuterAngle = [spotOuterAngle floatValue];
    }
    if (dict[@"color"] != nil) {
        NSNumber* color = dict[@"color"];
        light.color = [UIColor fromRGB: [color integerValue]];
    }
    return light;
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

- (NSDictionary*) getDictFromHitResult: (ARHitTestResult*) result {
    NSMutableDictionary* dict = [@{
             @"type": @(result.type),
             @"distance": @(result.distance),
             @"localTransform": [CodableUtils convertSimdFloat4x4ToString:result.localTransform],
             @"worldTransform": [CodableUtils convertSimdFloat4x4ToString:result.worldTransform]
             } mutableCopy];
    if (result.anchor != nil) {
        [dict setValue:[CodableUtils convertARAnchorToDictionary:result.anchor] forKey:@"anchor"];
    }
    return dict;
}

@end
