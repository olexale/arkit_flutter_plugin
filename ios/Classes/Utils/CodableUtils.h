@import ARKit;

NS_ASSUME_NONNULL_BEGIN

@interface CodableUtils: NSObject

+ (NSString*) convertSimdFloat2ToString: (simd_float2) vector;
+ (NSString*) convertSimdFloat3ToString: (simd_float3) vector;
+ (NSString*) convertSimdFloat4x4ToString: (simd_float4x4) matrix;
+ (NSDictionary*) convertARAnchorToDictionary: (ARAnchor*) anchor;

@end

NS_ASSUME_NONNULL_END
