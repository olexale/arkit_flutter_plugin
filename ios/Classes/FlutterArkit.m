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
  ARPlaneDetection planeDetection;
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
  } else if ([[call method] isEqualToString:@"addPlane"]) {
      [self onAddPlane:call result:result];
  } else if ([[call method] isEqualToString:@"addText"]) {
      [self onAddText:call result:result];
  } else if ([[call method] isEqualToString:@"positionChanged"]) {
      [self updatePosition:call andResult:result];
  } else if ([[call method] isEqualToString:@"rotationChanged"]) {
      [self updateRotation:call andResult:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* showStatistics = call.arguments[@"showStatistics"];
    _sceneView.showsStatistics = [showStatistics boolValue];
  
    NSNumber* autoenablesDefaultLighting = call.arguments[@"autoenablesDefaultLighting"];
    _sceneView.autoenablesDefaultLighting = [autoenablesDefaultLighting boolValue];
  
    NSNumber* requestedPlaneDetection = call.arguments[@"planeDetection"];
    planeDetection = [self getPlaneFromNumber:[requestedPlaneDetection intValue]];
    
    if ([call.arguments[@"enableTapRecognizer"] boolValue]) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    }
    
    self.sceneView.debugOptions = [self getDebugOptions:call.arguments];
    
    ARConfiguration* configuration = self.configuration;
    [self.sceneView.session runWithConfiguration:configuration];
    result(nil);
}

- (void)onAddSphere:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber* radius = call.arguments[@"radius"];
    SCNSphere* geometry = [SCNSphere sphereWithRadius:[radius doubleValue]];
    geometry.materials = [self getMaterials: call.arguments[@"materials"]];
    
    [self addNodeToSceneWithGeometry:geometry andCall:call andResult:result];
}

- (void)onAddPlane:(FlutterMethodCall*)call result:(FlutterResult)result {
    float width = [call.arguments[@"width"] floatValue];
    float height = [call.arguments[@"height"] floatValue];
    int widthSegmentCount = [call.arguments[@"widthSegmentCount"] intValue];
    int heightSegmentCount = [call.arguments[@"heightSegmentCount"] intValue];
    
    SCNPlane* geometry = [SCNPlane planeWithWidth:width height:height];
    geometry.widthSegmentCount = widthSegmentCount;
    geometry.heightSegmentCount = heightSegmentCount;
    geometry.materials = [self getMaterials: call.arguments[@"materials"]];
    
    [self addNodeToSceneWithGeometry:geometry andCall:call andResult:result];
}

- (void)onAddText:(FlutterMethodCall*)call result:(FlutterResult)result {
    float extrusionDepth = [call.arguments[@"extrusionDepth"] floatValue];
    SCNText* geometry = [SCNText textWithString:call.arguments[@"text"] extrusionDepth:extrusionDepth];
    geometry.materials = [self getMaterials: call.arguments[@"materials"]];
    
    [self addNodeToSceneWithGeometry:geometry andCall:call andResult:result];
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

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (node.name == nil) {
        node.name = [NSUUID UUID].UUIDString;
    }
    NSDictionary* params = [self prepareParamsForAnchorEventwithNode:node andAnchor:anchor];
    [_channel invokeMethod: @"didAddNodeForAnchor" arguments: params];
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSDictionary* params = [self prepareParamsForAnchorEventwithNode:node andAnchor:anchor];
    [_channel invokeMethod: @"didUpdateNodeForAnchor" arguments: params];
}

#pragma mark - Lazy loads

-(ARWorldTrackingConfiguration *)configuration {
    if (_configuration) {
        return _configuration;
    }
    
    if (!ARWorldTrackingConfiguration.isSupported) {}
    
    _configuration = [ARWorldTrackingConfiguration new];
    _configuration.planeDetection = planeDetection;
    return _configuration;
}

#pragma mark - Scene tap event
- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    SCNView* sceneView = (SCNView *)recognizer.view;
    CGPoint touchLocation = [recognizer locationInView:sceneView];
    NSArray<SCNHitTestResult *> * hitResults = [sceneView hitTest:touchLocation options:@{}];
    if ([hitResults count] != 0) {
        SCNNode *node = hitResults[0].node;
        [_channel invokeMethod: @"onTap" arguments: node.name];
    }
}

#pragma mark - Parameters
- (void) updatePosition:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:NO];
    node.position = [self parseVector3:call.arguments];
    result(nil);
}

- (void) updateRotation:(FlutterMethodCall*)call andResult:(FlutterResult)result{
    NSString* name = call.arguments[@"name"];
    SCNNode* node = [self.sceneView.scene.rootNode childNodeWithName:name recursively:NO];
    node.rotation = [self parseVector4:call.arguments];
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

-(NSArray<SCNMaterial*>*) getMaterials: (NSArray*) materialsString {
    if (materialsString == nil || [materialsString count] == 0)
        return nil;
    NSMutableArray *materials = [NSMutableArray arrayWithCapacity:[materialsString count]];
    for (NSDictionary* material in materialsString) {
        [materials addObject:[self getMaterial:material]];
    }
    return materials;
}

-(SCNMaterial*) getMaterial: (NSDictionary*) materialString {
    SCNMaterial* material = [SCNMaterial material];
    for(NSString* property in @[@"diffuse", @"ambient", @"specular", @"emission", @"transparent", @"reflective", @"multiply" , @"normal", @"displacement", @"ambientOcclusion", @"selfIllumination", @"metalness", @"roughness"]) {
        [self applyMaterialProperty:property withPropertyDictionary:materialString and:material];
    }
    
    material.shininess = [materialString[@"shininess"] doubleValue];
    material.transparency = [materialString[@"transparency"] doubleValue];
    material.lightingModelName = [self getLightingMode: [materialString[@"lightingModelName"] integerValue]];
    material.fillMode = [materialString[@"fillMode"] integerValue];
    material.cullMode = [materialString[@"cullMode"] integerValue];
    material.transparencyMode = [materialString[@"transparencyMode"] integerValue];
    material.locksAmbientWithDiffuse = [materialString[@"locksAmbientWithDiffuse"] boolValue];
    material.writesToDepthBuffer =[materialString[@"writesToDepthBuffer"] boolValue];
    material.colorBufferWriteMask = [self getColorMask:[materialString[@"colorBufferWriteMask"] integerValue]];
    material.blendMode = [materialString[@"blendMode"] integerValue];
    
    return material;
}

-(void) applyMaterialProperty: (NSString*) propertyName withPropertyDictionary: (NSDictionary*) dict and:(SCNMaterial *) material {
    if (dict[propertyName] != nil) {
        SCNMaterialProperty *property = [material valueForKey: propertyName];
        property.contents = [self getMaterialProperty:dict[propertyName]];
    }
}

-(id) getMaterialProperty: (NSDictionary*) propertyString {
    if (propertyString[@"image"] != nil) {
        UIImage* img = [UIImage imageNamed:propertyString[@"image"]];
        return img;
        
    } else if (propertyString[@"color"] != nil) {
        NSNumber* color = propertyString[@"color"];
        return [self UIColorFromRGB:([color integerValue])];
    }
    
    return nil;
}

- (UIColor *)UIColorFromRGB:(NSInteger)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:((float)((rgbValue & 0xFF000000) >> 24))/255.0];
}

- (SCNLightingModel) getLightingMode:(NSInteger) mode {
    switch (mode) {
        case 0:
            return SCNLightingModelPhong;
        case 1:
            return SCNLightingModelBlinn;
        case 2:
            return SCNLightingModelLambert;
        case 3:
            return SCNLightingModelConstant;
        default:
            return SCNLightingModelPhysicallyBased;
    }
}

- (SCNColorMask) getColorMask:(NSInteger) mode {
    switch (mode) {
        case 0:
            return SCNColorMaskNone;
        case 1:
            return SCNColorMaskRed;
        case 2:
            return SCNColorMaskGreen;
        case 3:
            return SCNColorMaskBlue;
        case 4:
            return SCNColorMaskAlpha;
        default:
            return SCNColorMaskAll;
    }
}

- (SCNNode *) getNodeWithGeometry:(SCNGeometry *)geometry fromDict:(NSDictionary *)dict {
    SCNNode* node = [SCNNode nodeWithGeometry:geometry];
    node.position = [self parseVector3:dict[@"position"]];
    
    if (dict[@"scale"] != nil) {
        node.scale = [self parseVector3:dict[@"scale"]];
    }
    if (dict[@"rotation"] != nil) {
        node.rotation = [self parseVector4:dict[@"rotation"]];
    }
    if (dict[@"name"] != nil) {
        node.name = dict[@"name"];
    }
    return node;
}

- (SCNVector3) parseVector3:(NSDictionary*) vector {
    NSNumber* x = vector[@"x"];
    NSNumber* y = vector[@"y"];
    NSNumber* z = vector[@"z"];
    return SCNVector3Make([x floatValue], [y floatValue],[z floatValue]);
}

- (SCNVector4) parseVector4:(NSDictionary*) vector {
    NSNumber* x = vector[@"x"];
    NSNumber* y = vector[@"y"];
    NSNumber* z = vector[@"z"];
    NSNumber* w = vector[@"w"];
    return SCNVector4Make([x floatValue], [y floatValue],[z floatValue],[w floatValue]);
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

- (NSString*) convertSimdFloat4x4ToString: (simd_float4x4) matrix {
    NSMutableString* ret = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i< 4; i++) {
        for (int j = 0; j< 4; j++) {
            [ret appendString:[NSString stringWithFormat:@"%f ", matrix.columns[i][j]]];
        }
    }
    return ret;
}

- (NSString*) convertSimdFloat3ToString: (simd_float3) vector {
    return [NSString stringWithFormat:@"%f %f %f", vector[0], vector[1], vector[2]];
}

- (NSDictionary<NSString*, NSString*>*) prepareParamsForAnchorEventwithNode: (SCNNode*) node andAnchor: (ARAnchor*) anchor {
    NSMutableDictionary<NSString*, NSString*>* params = [@{@"node_name": node.name,
                                                           @"identifier": [anchor.identifier UUIDString],
                                                           @"transform": [self convertSimdFloat4x4ToString:anchor.transform]
                                                           } mutableCopy];
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        ARPlaneAnchor *plane = (ARPlaneAnchor*)anchor;
        [params setObject:@"planeAnchor" forKey:@"anchorType"];
        [params setObject:[self convertSimdFloat3ToString:plane.center] forKey:@"center"];
        [params setObject:[self convertSimdFloat3ToString:plane.extent] forKey:@"extent"];
    }
    return params;
}

@end
