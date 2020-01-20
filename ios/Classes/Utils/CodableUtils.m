#import "CodableUtils.h"

@implementation CodableUtils

+ (NSString*) convertSimdFloat2ToString: (simd_float2) vector {
    return [NSString stringWithFormat:@"%f %f", vector[0], vector[1]];
}

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
    else if ([anchor isMemberOfClass:[ARImageAnchor class]]) {
        ARImageAnchor *image = (ARImageAnchor*)anchor;
        [params setObject:@"imageAnchor" forKey:@"anchorType"];
        [params setObject:image.referenceImage.name forKey:@"referenceImageName"];
        [params setObject:image.isTracked ? @"1" : @"0" forKey:@"isTracked"];
        simd_float2 size = simd_make_float2(image.referenceImage.physicalSize.width, image.referenceImage.physicalSize.height);
        [params setObject:[CodableUtils convertSimdFloat2ToString:size] forKey:@"referenceImagePhysicalSize"];
    }
    else if ([anchor isMemberOfClass:[ARFaceAnchor class]]) {
        [params setObject:@"faceAnchor" forKey:@"anchorType"];
        ARFaceAnchor *faceAnchor = (ARFaceAnchor*)anchor;
        [params setObject:faceAnchor.isTracked ? @"1" : @"0" forKey:@"isTracked"];
        [params setObject:[CodableUtils convertSimdFloat4x4ToString:faceAnchor.leftEyeTransform] forKey:@"leftEyeTransform"];
        [params setObject:[CodableUtils convertSimdFloat4x4ToString:faceAnchor.rightEyeTransform] forKey:@"rightEyeTransform"];
        [params setObject:faceAnchor.blendShapes forKey:@"blendShapes"];
    }
    else if ([anchor isMemberOfClass:[ARBodyAnchor class]]) {
        [params setObject:@"bodyAnchor" forKey:@"anchorType"];
        
        ARBodyAnchor *body = (ARBodyAnchor*)anchor;
      
        [params setObject:body.isTracked ? @"1" : @"0" forKey:@"isTracked"];
        
        NSDictionary* modelTransforms = @{
            @"root": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameRoot]],
            @"head": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameHead]],
            @"leftHand": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameLeftHand]],
            @"rightHand": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameRightHand]],
            @"leftFoot": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameLeftFoot]],
            @"rightFoot": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameRightFoot]],
            @"leftShoulder": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameLeftShoulder]],
            @"rightShoulder": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton modelTransformForJointName:ARSkeletonJointNameRightShoulder]]
        };
        
        NSDictionary* localTransforms = @{
            @"root": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameRoot]],
            @"head": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameHead]],
            @"leftHand": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameLeftHand]],
            @"rightHand": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameRightHand]],
            @"leftFoot": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameLeftFoot]],
            @"rightFoot": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameRightFoot]],
            @"leftShoulder": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameLeftShoulder]],
            @"rightShoulder": [CodableUtils convertSimdFloat4x4ToString:[body.skeleton localTransformForJointName:ARSkeletonJointNameRightShoulder]]
        };
        
        NSDictionary<NSString*, NSDictionary*>* skeleton = @{
            @"modelTransforms":modelTransforms,
            @"localTransforms":localTransforms
        };
        [params setObject:skeleton forKey:@"skeleton"];
    }
    return params;
}

@end
