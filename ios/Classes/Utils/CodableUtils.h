@import ARKit;

NS_ASSUME_NONNULL_BEGIN

@interface CodableUtils: NSObject

+ (NSString*) convertSimdFloat3ToString: (simd_float3) vector;
+ (NSString*) convertSimdFloat4x4ToString: (simd_float4x4) matrix;

@end

NS_ASSUME_NONNULL_END
