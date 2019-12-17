import 'package:arkit_plugin/geometries/material/arkit_blend_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_color_mask.dart';
import 'package:arkit_plugin/geometries/material/arkit_cull_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_fill_mode.dart';
import 'package:arkit_plugin/geometries/material/arkit_lighting_model.dart';
import 'package:arkit_plugin/geometries/material/arkit_material_property.dart';
import 'package:arkit_plugin/geometries/material/arkit_transparency_mode.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_material.g.dart';

/// An ARKitMaterial determines how a geometry is rendered.
/// It encapsulates the colors and textures that define the appearance of 3d geometries.
@JsonSerializable()
class ARKitMaterial {
  ARKitMaterial({
    this.diffuse,
    this.ambient,
    this.specular,
    this.emission,
    this.transparent,
    this.reflective,
    this.multiply,
    this.normal,
    this.displacement,
    this.ambientOcclusion,
    this.selfIllumination,
    this.metalness,
    this.roughness,
    this.shininess = 1.0,
    this.transparency = 1.0,
    this.lightingModelName = ARKitLightingModel.blinn,
    this.fillMode = ARKitFillMode.fill,
    this.cullMode = ARKitCullMode.back,
    this.transparencyMode = ARKitTransparencyMode.aOne,
    this.locksAmbientWithDiffuse = true,
    this.writesToDepthBuffer = true,
    this.colorBufferWriteMask = ARKitColorMask.all,
    this.doubleSided = false,
    this.blendMode = ARKitBlendMode.alpha,
  });

  /// Specifies the receiver's diffuse property.
  /// The diffuse property specifies the amount of light diffusely reflected
  /// from the surface. The diffuse light is reflected equally in all directions and is
  /// therefore independent of the point of view.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty diffuse;

  /// Specifies the receiver's ambient property.
  /// The ambient property specifies the amount of ambient light to reflect.
  /// This property has no visual impact on scenes that have no ambient light.
  /// Setting the ambient has no effect if locksAmbientWithDiffuse is set to YES.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty ambient;

  /// Specifies the receiver's specular property.
  /// The specular property specifies the amount of light to reflect in a mirror-like manner.
  /// The specular intensity increases when the point of view lines up with the direction of the reflected light.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty specular;

  /// The emission property specifies the amount of light the material emits.
  /// This emission does not light up other surfaces in the scene.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty emission;

  /// The transparent property specifies the transparent areas of the material.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty transparent;

  /// The reflective property specifies the reflectivity of the surface.
  /// The surface will not actually reflect other objects in the scene.
  /// This property may be used as a sphere mapping to reflect a precomputed environment.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty reflective;

  /// The multiply property specifies a color or an image used to multiply the output fragments with.
  /// The computed fragments are multiplied with the multiply value to produce the final fragments.
  /// This property may be used for shadow maps, to fade out or tint 3d objects.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty multiply;

  /// The normal property specifies the surface orientation.
  /// When an image is set on the normal property the material is automatically lit per pixel.
  /// Setting a color has no effect.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty normal;

  /// The displacement property specifies how vertex are translated in tangent space.
  /// Pass a grayscale image for a simple 'elevation' or rgb image for a vector displacement.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty displacement;

  /// The ambientOcclusion property specifies the ambient occlusion of the surface.
  /// The ambient occlusion is multiplied with the ambient light, then the result is added to the lighting contribution.
  /// This property has no visual impact on scenes that have no ambient light.
  /// When an ambient occlusion map is set, the ambient property is ignored.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty ambientOcclusion;

  /// The selfIllumination property specifies a texture or a color that is added to the lighting contribution of the surface.
  /// When a selfIllumination is set, the emission property is ignored.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty selfIllumination;

  /// The metalness property specifies how metallic the material's surface appears.
  /// Lower values (darker colors) cause the material to appear more like a dielectric surface.
  /// Higher values (brighter colors) cause the surface to appear more metallic.
  /// This property is only used when 'lightingModelName' is 'SCNLightingModelPhysicallyBased'.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty metalness;

  /// The roughness property specifies the apparent smoothness of the surface.
  /// Lower values (darker colors) cause the material to appear shiny, with well-defined specular highlights.
  /// Higher values (brighter colors) cause specular highlights to spread out and the diffuse property of the material to become more retroreflective.
  /// This property is only used when 'lightingModelName' is 'SCNLightingModelPhysicallyBased'.
  @ARKitMaterialPropertyConverter()
  final ARKitMaterialProperty roughness;

  /// Specifies the receiver's shininess value. Defaults to 1.0.
  final double shininess;

  /// Specifies the receiver's transparency value. Defaults to 1.0.
  /// The color of the transparent property is multiplied by this property.
  /// The result is then used to produce the final transparency according to the rule defined by the transparencyMode property.
  final double transparency;

  /// Determines the receiver's lighting model.
  /// Defaults to ARKitLightingModel.blinn.
  @ARKitLightingModelConverter()
  final ARKitLightingModel lightingModelName;

  /// Determines of to how to rasterize the receiver's primitives. Defaults to ARKitFillMode.fill.
  @ARKitFillModeConverter()
  final ARKitFillMode fillMode;

  /// Determines the culling mode of the receiver. Defaults to ARKitCullMode.back;
  @ARKitCullModeConverter()
  final ARKitCullMode cullMode;

  /// Determines the transparency mode of the receiver. Defaults to ARKitTransparencyMode.aOne.
  @ARKitTransparencyModeConverter()
  final ARKitTransparencyMode transparencyMode;

  /// Makes the ambient property automatically match the diffuse property. Defaults to true.
  final bool locksAmbientWithDiffuse;

  /// Determines whether the receiver writes to the depth buffer when rendered. Defaults to true.
  final bool writesToDepthBuffer;

  /// Determines whether the receiver writes to the color buffer when rendered. Defaults to ARKitColorMask.all.
  @ARKitColorMaskConverter()
  final ARKitColorMask colorBufferWriteMask;

  /// Specifies the receiver's blend mode. Defaults to ARKitBlendMode.alpha.
  @ARKitBlendModeConverter()
  final ARKitBlendMode blendMode;

  /// Determines whether the receiver is double sided. Defaults to false.
  final bool doubleSided;

  static ARKitMaterial fromJson(Map<String, dynamic> json) =>
      _$ARKitMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$ARKitMaterialToJson(this);
}
