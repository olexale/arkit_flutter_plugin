#import "Utils.h"

@implementation Utils

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

@end
