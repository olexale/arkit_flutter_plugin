#import "SceneViewDelegate.h"

@interface SceneViewDelegate()
@property FlutterMethodChannel* channel;
@end


@implementation SceneViewDelegate

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
    self.channel = channel;
  }
  return self;
}

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

#pragma mark - Helpers

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

- (NSString*) convertSimdFloat3ToString: (simd_float3) vector {
  return [NSString stringWithFormat:@"%f %f %f", vector[0], vector[1], vector[2]];
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

@end
