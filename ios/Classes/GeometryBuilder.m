#import "GeometryBuilder.h"
#import "Color.h"
#import "DecodableUtils.h"

@implementation GeometryBuilder

+ (SCNGeometry *) createGeometry:(NSDictionary *) geometryArguments {
    SCNGeometry *geometry;
    if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitSphere"]) {
        NSNumber* radius = geometryArguments[@"radius"];
        geometry = [SCNSphere sphereWithRadius:[radius doubleValue]];
    }
    if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitPlane"]) {
        float width = [geometryArguments[@"width"] floatValue];
        float height = [geometryArguments[@"height"] floatValue];
        int widthSegmentCount = [geometryArguments[@"widthSegmentCount"] intValue];
        int heightSegmentCount = [geometryArguments[@"heightSegmentCount"] intValue];
        
        SCNPlane* plane = [SCNPlane planeWithWidth:width height:height];
        plane.widthSegmentCount = widthSegmentCount;
        plane.heightSegmentCount = heightSegmentCount;
        geometry = plane;
    }
    if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitText"]) {
        float extrusionDepth = [geometryArguments[@"extrusionDepth"] floatValue];
        geometry = [SCNText textWithString:geometryArguments[@"text"] extrusionDepth:extrusionDepth];
    }
    if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitLine"]) {
        SCNVector3 fromVector =  [DecodableUtils parseVector3:geometryArguments[@"fromVector"]];
        SCNVector3 toVector = [DecodableUtils parseVector3:geometryArguments[@"toVector"]];
        SCNVector3 vertices[] = {fromVector, toVector};
        SCNGeometrySource *source =  [SCNGeometrySource geometrySourceWithVertices: vertices
                                                                             count: 2];
        int indexes[] = { 0, 1 };
        NSData *dataIndexes = [NSData dataWithBytes:indexes length:sizeof(indexes)];
        SCNGeometryElement *element = [SCNGeometryElement geometryElementWithData:dataIndexes
                                                                    primitiveType:SCNGeometryPrimitiveTypeLine
                                                                   primitiveCount:1
                                                                    bytesPerIndex:sizeof(int)];
        geometry = [SCNGeometry geometryWithSources: @[source]
                                           elements: @[element]];
    }
    
    if (geometry != nil) {
        geometry.materials = [self getMaterials: geometryArguments[@"materials"]];
    }
    return geometry;
}

+ (NSArray<SCNMaterial*>*) getMaterials: (NSArray*) materialsString {
    if (materialsString == nil || [materialsString count] == 0)
        return nil;
    NSMutableArray *materials = [NSMutableArray arrayWithCapacity:[materialsString count]];
    for (NSDictionary* material in materialsString) {
        [materials addObject:[self getMaterial:material]];
    }
    return materials;
}


+ (SCNMaterial*) getMaterial: (NSDictionary*) materialString {
    SCNMaterial* material = [SCNMaterial material];
    for(NSString* property in @[@"diffuse", @"ambient", @"specular", @"emission", @"transparent", @"reflective", @"multiply" , @"normal", @"displacement", @"ambientOcclusion", @"selfIllumination", @"metalness", @"roughness"]) {
        [self applyMaterialProperty:property withPropertyDictionary:materialString and:material];
    }
    
    material.shininess = [materialString[@"shininess"] doubleValue];
    material.transparency = [materialString[@"transparency"] doubleValue];
    material.lightingModelName = [self getLightingMode: [materialString[@"lightingModelName"] integerValue]];
    material.fillMode = [materialString[@"fillMode"] integerValue];
    material.cullMode = [materialString[@"cullMode"] integerValue];
    material.transparencyMode = [materialString[@"transparencyMode"] integerValue];
    material.locksAmbientWithDiffuse = [materialString[@"locksAmbientWithDiffuse"] boolValue];
    material.writesToDepthBuffer =[materialString[@"writesToDepthBuffer"] boolValue];
    material.colorBufferWriteMask = [self getColorMask:[materialString[@"colorBufferWriteMask"] integerValue]];
    material.blendMode = [materialString[@"blendMode"] integerValue];
    
    return material;
}

+ (void) applyMaterialProperty: (NSString*) propertyName withPropertyDictionary: (NSDictionary*) dict and:(SCNMaterial *) material {
    if (dict[propertyName] != nil) {
        SCNMaterialProperty *property = [material valueForKey: propertyName];
        property.contents = [self getMaterialProperty:dict[propertyName]];
    }
}

+ (id) getMaterialProperty: (NSDictionary*) propertyString {
    if (propertyString[@"image"] != nil) {
        UIImage* img = [UIImage imageNamed:propertyString[@"image"]];
        return img;
        
    } else if (propertyString[@"color"] != nil) {
        NSNumber* color = propertyString[@"color"];
        return [UIColor fromRGB: [color integerValue]];
    }
    
    return nil;
}

+ (SCNLightingModel) getLightingMode:(NSInteger) mode {
    switch (mode) {
        case 0:
            return SCNLightingModelPhong;
        case 1:
            return SCNLightingModelBlinn;
        case 2:
            return SCNLightingModelLambert;
        case 3:
            return SCNLightingModelConstant;
        default:
            return SCNLightingModelPhysicallyBased;
    }
}

+ (SCNColorMask) getColorMask:(NSInteger) mode {
    switch (mode) {
        case 0:
            return SCNColorMaskNone;
        case 1:
            return SCNColorMaskRed;
        case 2:
            return SCNColorMaskGreen;
        case 3:
            return SCNColorMaskBlue;
        case 4:
            return SCNColorMaskAlpha;
        default:
            return SCNColorMaskAll;
    }
}


@end
