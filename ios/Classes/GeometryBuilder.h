@import SceneKit;

NS_ASSUME_NONNULL_BEGIN

@interface GeometryBuilder : NSObject

+ (SCNGeometry *) createGeometry:(NSDictionary *) geometryArguments;

@end

NS_ASSUME_NONNULL_END
