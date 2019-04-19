#import "DecodableUtils.h"

@implementation DecodableUtils

+ (SCNVector3) parseVector3:(NSDictionary*) vector {
    NSNumber* x = vector[@"x"];
    NSNumber* y = vector[@"y"];
    NSNumber* z = vector[@"z"];
    return SCNVector3Make([x floatValue], [y floatValue],[z floatValue]);
}

+ (SCNVector4) parseVector4:(NSDictionary*) vector {
    NSNumber* x = vector[@"x"];
    NSNumber* y = vector[@"y"];
    NSNumber* z = vector[@"z"];
    NSNumber* w = vector[@"w"];
    return SCNVector4Make([x floatValue], [y floatValue],[z floatValue],[w floatValue]);
}


@end
