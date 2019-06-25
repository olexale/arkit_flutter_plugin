#import "CodableUtils.h"

@implementation CodableUtils

+ (NSString*) convertSimdFloat3ToString: (simd_float3) vector {
    return [NSString stringWithFormat:@"%f %f %f", vector[0], vector[1], vector[2]];
}

+ (NSString*) convertSimdFloat4x4ToString: (simd_float4x4) matrix {
    NSMutableString* ret = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i< 4; i++) {
        for (int j = 0; j< 4; j++) {
            [ret appendString:[NSString stringWithFormat:@"%f ", matrix.columns[i][j]]];
        }
    }
    return ret;
}

+ (NSDictionary*) convertARAnchorToDictionary: (ARAnchor*) anchor {
    NSMutableDictionary<NSString*, NSString*>* params = [@{@"identifier": [anchor.identifier UUIDString],
                                                           @"transform": [CodableUtils convertSimdFloat4x4ToString:anchor.transform]
                                                           } mutableCopy];
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]]) {
        ARPlaneAnchor *plane = (ARPlaneAnchor*)anchor;
        [params setObject:@"planeAnchor" forKey:@"anchorType"];
        [params setObject:[CodableUtils convertSimdFloat3ToString:plane.center] forKey:@"center"];
        [params setObject:[CodableUtils convertSimdFloat3ToString:plane.extent] forKey:@"extent"];
    }
    if ([anchor isMemberOfClass:[ARImageAnchor class]]) {
        ARImageAnchor *image = (ARImageAnchor*)anchor;
        [params setObject:@"imageAnchor" forKey:@"anchorType"];
        [params setObject:image.referenceImage.name forKey:@"referenceImageName"];
    }
    if ([anchor isMemberOfClass:[ARFaceAnchor class]]) {
        [params setObject:@"faceAnchor" forKey:@"anchorType"];
        ARFaceAnchor *faceAnchor = (ARFaceAnchor*)anchor;
        [params setObject:[CodableUtils convertSimdFloat4x4ToString:faceAnchor.leftEyeTransform] forKey:@"leftEyeTransform"];
        [params setObject:[CodableUtils convertSimdFloat4x4ToString:faceAnchor.rightEyeTransform] forKey:@"rightEyeTransform"];
        [params setObject:faceAnchor.blendShapes forKey:@"blendShapes"];
    }
    return params;
}

@end
