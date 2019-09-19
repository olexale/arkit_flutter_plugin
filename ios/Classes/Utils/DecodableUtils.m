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

+ (simd_float4x4) parseFloat4x4: (NSDictionary*) matrix {
    SCNVector4 a = [DecodableUtils parseVector4:matrix[@"a"]];
    SCNVector4 b = [DecodableUtils parseVector4:matrix[@"b"]];
    SCNVector4 c = [DecodableUtils parseVector4:matrix[@"c"]];
    SCNVector4 d = [DecodableUtils parseVector4:matrix[@"d"]];
    
    simd_float4 a_float = simd_make_float4(a.x, a.y, a.z, a.w);
    simd_float4 b_float = simd_make_float4(b.x, b.y, b.z, b.w);
    simd_float4 c_float = simd_make_float4(c.x, c.y, c.z, c.w);
    simd_float4 d_float = simd_make_float4(d.x, d.y, d.z, d.w);
    simd_float4x4 m = simd_matrix(a_float, b_float, c_float, d_float);
    return m;
}


@end
