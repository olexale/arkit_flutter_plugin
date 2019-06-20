@import SceneKit;
@import ARKit;

NS_ASSUME_NONNULL_BEGIN

@interface GeometryBuilder : NSObject

+ (SCNGeometry *) createGeometry:(NSDictionary *) geometryArguments withDevice: (NSObject*) device;

@end

NS_ASSUME_NONNULL_END
