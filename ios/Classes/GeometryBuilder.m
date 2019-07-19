#import "GeometryBuilder.h"
#import "Color.h"
#import "DecodableUtils.h"

@implementation GeometryBuilder

+ (SCNGeometry *) createGeometry:(NSDictionary *) geometryArguments withDevice: (NSObject*) device {
    SEL selector = NULL;
    if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitSphere"]) {
        selector = @selector(getSphere:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitPlane"]) {
        selector = @selector(getPlane:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitText"]) {
        selector = @selector(getText:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitBox"]) {
        selector = @selector(getBox:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitLine"]) {
        selector = @selector(getLine:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitCylinder"]) {
        selector = @selector(getCylinder:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitCone"]) {
        selector = @selector(getCone:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitPyramid"]) {
        selector = @selector(getPyramid:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitTube"]) {
        selector = @selector(getTube:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitTorus"]) {
        selector = @selector(getTorus:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitCapsule"]) {
        selector = @selector(getCapsule:);
    } else if ([geometryArguments[@"dartType"] isEqualToString:@"ARKitFace"]) {
        selector = @selector(getFace:withDeivce:);
    }
    
    if (selector == nil)
        return nil;
    
    IMP imp = [self methodForSelector:selector];
    SCNGeometry* (*func)(id, SEL, NSDictionary*, id) = (void *)imp;
    SCNGeometry *geometry = func(self, selector, geometryArguments, device);
    
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
    material.doubleSided = [materialString[@"doubleSided"] boolValue];
    
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

+ (SCNSphere *) getSphere:(NSDictionary *) geometryArguments {
    NSNumber* radius = geometryArguments[@"radius"];
    return [SCNSphere sphereWithRadius:[radius doubleValue]];
}

+ (SCNPlane *) getPlane:(NSDictionary *) geometryArguments {
    float width = [geometryArguments[@"width"] floatValue];
    float height = [geometryArguments[@"height"] floatValue];
    int widthSegmentCount = [geometryArguments[@"widthSegmentCount"] intValue];
    int heightSegmentCount = [geometryArguments[@"heightSegmentCount"] intValue];
    
    SCNPlane* plane = [SCNPlane planeWithWidth:width height:height];
    plane.widthSegmentCount = widthSegmentCount;
    plane.heightSegmentCount = heightSegmentCount;
    return plane;
}

+ (SCNText *) getText:(NSDictionary *) geometryArguments {
    float extrusionDepth = [geometryArguments[@"extrusionDepth"] floatValue];
    return [SCNText textWithString:geometryArguments[@"text"] extrusionDepth:extrusionDepth];
}

+ (SCNBox *) getBox:(NSDictionary *) geometryArguments {
    NSNumber* width = geometryArguments[@"width"];
    NSNumber* height = geometryArguments[@"height"];
    NSNumber* length = geometryArguments[@"length"];
    NSNumber* chamferRadius = geometryArguments[@"chamferRadius"];
    return [SCNBox boxWithWidth:[width floatValue] height:[height floatValue] length:[length floatValue] chamferRadius:[chamferRadius floatValue]];
}

+ (SCNGeometry *) getLine:(NSDictionary *) geometryArguments {
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
    return [SCNGeometry geometryWithSources: @[source] elements: @[element]];
}

+ (SCNCylinder *) getCylinder:(NSDictionary *) geometryArguments {
    NSNumber* radius = geometryArguments[@"radius"];
    NSNumber* height = geometryArguments[@"height"];
    return [SCNCylinder cylinderWithRadius:[radius floatValue] height:[height floatValue]];
}

+ (SCNCone *) getCone:(NSDictionary *) geometryArguments {
    NSNumber* topRadius = geometryArguments[@"topRadius"];
    NSNumber* bottomRadius = geometryArguments[@"bottomRadius"];
    NSNumber* height = geometryArguments[@"height"];
    return [SCNCone coneWithTopRadius:[topRadius floatValue] bottomRadius:[bottomRadius floatValue] height:[height floatValue]];
}

+ (SCNPyramid *) getPyramid:(NSDictionary *) geometryArguments {
    NSNumber* width = geometryArguments[@"width"];
    NSNumber* height = geometryArguments[@"height"];
    NSNumber* length = geometryArguments[@"length"];
    return [SCNPyramid pyramidWithWidth:[width floatValue] height:[height floatValue] length:[length floatValue]];
}

+ (SCNTube *) getTube:(NSDictionary *) geometryArguments {
    NSNumber* innerRadius = geometryArguments[@"innerRadius"];
    NSNumber* outerRadius = geometryArguments[@"outerRadius"];
    NSNumber* height = geometryArguments[@"height"];
    return [SCNTube tubeWithInnerRadius:[innerRadius floatValue] outerRadius:[outerRadius floatValue] height:[height floatValue]];
}

+ (SCNTorus *) getTorus:(NSDictionary *) geometryArguments {
    NSNumber* ringRadius = geometryArguments[@"ringRadius"];
    NSNumber* pipeRadius = geometryArguments[@"pipeRadius"];
    return [SCNTorus torusWithRingRadius:[ringRadius floatValue] pipeRadius:[pipeRadius floatValue]];
}

+ (SCNCapsule *) getCapsule:(NSDictionary *) geometryArguments {
    NSNumber* capRadius = geometryArguments[@"capRadius"];
    NSNumber* height = geometryArguments[@"height"];
    return [SCNCapsule capsuleWithCapRadius:[capRadius floatValue] height:[height floatValue]];
}

+ (ARSCNFaceGeometry *) getFace:(NSDictionary *) geometryArguments withDeivce:(id) device{
    return [ARSCNFaceGeometry faceGeometryWithDevice:device];
}

@end
