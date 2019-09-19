@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface DecodableUtils : NSObject

+ (SCNVector3) parseVector3:(NSDictionary*) vector;
+ (SCNVector4) parseVector4:(NSDictionary*) vector;
+ (simd_float4x4) parseFloat4x4: (NSDictionary*) matrix;

@end

NS_ASSUME_NONNULL_END
