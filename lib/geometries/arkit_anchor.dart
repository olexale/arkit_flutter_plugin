import 'package:arkit_plugin/geometries/arkit_face.dart';
import 'package:arkit_plugin/geometries/arkit_skeleton.dart';
import 'package:arkit_plugin/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

part 'arkit_anchor.g.dart';

/// Object representing a physical location and orientation in 3D space.
abstract class ARKitAnchor {
  const ARKitAnchor(
    this.nodeName,
    this.identifier,
    this.transform,
  );

  factory ARKitAnchor.fromJson(Map<String, dynamic> arguments) {
    final type = arguments['anchorType'].toString();
    switch (type) {
      case 'planeAnchor':
        return ARKitPlaneAnchor.fromJson(arguments);
      case 'imageAnchor':
        return ARKitImageAnchor.fromJson(arguments);
      case 'faceAnchor':
        return ARKitFaceAnchor.fromJson(arguments);
      case 'bodyAnchor':
        return ARKitBodyAnchor.fromJson(arguments);
    }
    return ARKitUnkownAnchor.fromJson(arguments);
  }

  /// Represents the name of the node anchor attached to.
  final String nodeName;

  /// Unique identifier of the anchor.
  final String identifier;

  /// The transformation matrix that defines the anchor’s rotation, translation and scale in world coordinates.
  @MatrixConverter()
  final Matrix4 transform;

  Map<String, dynamic> toJson();
}

/// The anchor of this type is not supported by the plugin yet.
@JsonSerializable()
class ARKitUnkownAnchor extends ARKitAnchor {
  const ARKitUnkownAnchor(
    this.anchorType,
    String nodeName,
    String identifier,
    Matrix4 transform,
  ) : super(nodeName, identifier, transform);

  final String anchorType;

  static ARKitUnkownAnchor fromJson(Map<String, dynamic> json) =>
      _$ARKitUnkownAnchorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitUnkownAnchorToJson(this);
}

/// An anchor representing a planar surface in the world.
/// Planes are defined in the X and Z direction, where Y is the surface’s normal.
@JsonSerializable()
class ARKitPlaneAnchor extends ARKitAnchor {
  const ARKitPlaneAnchor(
    this.center,
    this.extent,
    String nodeName,
    String identifier,
    Matrix4 transform,
  ) : super(
          nodeName,
          identifier,
          transform,
        );

  /// The center of the plane in the anchor’s coordinate space.
  @Vector3Converter()
  final Vector3 center;

  /// The extent of the plane in the anchor’s coordinate space.
  @Vector3Converter()
  final Vector3 extent;

  static ARKitPlaneAnchor fromJson(Map<String, dynamic> json) =>
      _$ARKitPlaneAnchorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitPlaneAnchorToJson(this);
}

/// An anchor representing an image in the world.
@JsonSerializable()
class ARKitImageAnchor extends ARKitAnchor {
  const ARKitImageAnchor(
    this.referenceImageName,
    this.referenceImagePhysicalSize,
    this.isTracked,
    String nodeName,
    String identifier,
    Matrix4 transform,
  ) : super(
          nodeName,
          identifier,
          transform,
        );

  /// Name of the detected image (might be null).
  final String referenceImageName;

  @Vector2Converter()
  final Vector2 referenceImagePhysicalSize;

  /// Tracking state of the anchor
  /// The isTracked value is used to determine the anchor transform’s validity. When the object being tracked is no longer detected in the
  /// camera image, its anchor will return NO for isTracked.
  final bool isTracked;

  static ARKitImageAnchor fromJson(Map<String, dynamic> json) =>
      _$ARKitImageAnchorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitImageAnchorToJson(this);
}

/// An anchor representing a face and its geometry.
@JsonSerializable()
class ARKitFaceAnchor extends ARKitAnchor {
  const ARKitFaceAnchor(
    // this.geometry,
    this.blendShapes,
    this.isTracked,
    String nodeName,
    String identifier,
    Matrix4 transform,
    this.leftEyeTransform,
    this.rightEyeTransform,
  ) : super(
          nodeName,
          identifier,
          transform,
        );

  /// The face geometry updated based on the computed blend shapes.
  // final ARKitFace geometry;

  /// The left eye’s rotation and translation relative to the anchor’s origin.
  @MatrixConverter()
  final Matrix4 leftEyeTransform;

  /// The right eye’s rotation and translation relative to the anchor’s origin.
  @MatrixConverter()
  final Matrix4 rightEyeTransform;

  /// A dictionary of blend shape coefficients for each blend shape location.
  /// Blend shapes coefficients define the amount of displacement of a neutral shape at a specific location on the face.
  final Map<String, double> blendShapes;

  /// Tracking state of the anchor
  /// The isTracked value is used to determine the anchor transform’s validity. When the object being tracked is no longer detected in the
  /// camera image, its anchor will return NO for isTracked.
  final bool isTracked;

  static ARKitFaceAnchor fromJson(Map<String, dynamic> json) =>
      _$ARKitFaceAnchorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitFaceAnchorToJson(this);
}

/// An anchor representing a body in the world.
@JsonSerializable()
class ARKitBodyAnchor extends ARKitAnchor {
  ARKitBodyAnchor(
    this.skeleton,
    this.isTracked,
    String nodeName,
    String identifier,
    Matrix4 transform,
  ) : super(
          nodeName,
          identifier,
          transform,
        );

  /// The tracked skeleton in 3D.
  /// The default height of this skeleton, measured from lowest to highest joint in standing position, is defined to be 1.71 meters.
  final ARKitSkeleton skeleton;

  /// Tracking state of the anchor
  /// The isTracked value is used to determine the anchor transform’s validity. When the object being tracked is no longer detected in the
  /// camera image, its anchor will return NO for isTracked.
  final bool isTracked;

  static ARKitBodyAnchor fromJson(Map<String, dynamic> json) =>
      _$ARKitBodyAnchorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitBodyAnchorToJson(this);
}
