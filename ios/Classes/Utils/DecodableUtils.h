@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface DecodableUtils : NSObject

+ (SCNVector3) parseVector3:(NSDictionary*) vector;
+ (SCNVector4) parseVector4:(NSDictionary*) vector;

@end

NS_ASSUME_NONNULL_END
