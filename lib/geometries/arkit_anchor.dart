import 'package:arkit_plugin/geometries/arkit_face.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/utils/matrix4_utils.dart';
import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

/// Object representing a physical location and orientation in 3D space.
class ARKitAnchor {
  ARKitAnchor(
    this.nodeName,
    this.identifier,
    this.transform,
  );

  /// Represents the name of the node anchor attached to.
  final String nodeName;

  /// Unique identifier of the anchor.
  final String identifier;

  /// The transformation matrix that defines the anchor’s rotation, translation and scale in world coordinates.
  final Matrix4 transform;

  static ARKitAnchor fromMap(Map<dynamic, dynamic> map) => ARKitAnchor(
        map['node_name'],
        map['identifier'],
        getMatrixFromString(map['transform']),
      );
}

/// An anchor representing a planar surface in the world.
/// Planes are defined in the X and Z direction, where Y is the surface’s normal.
class ARKitPlaneAnchor extends ARKitAnchor {
  ARKitPlaneAnchor(
    this.center,
    this.extent,
    String nodeName,
    String identifier,
    Matrix4 transorm,
  ) : super(
          nodeName,
          identifier,
          transorm,
        );

  /// The center of the plane in the anchor’s coordinate space.
  final Vector3 center;

  /// The extent of the plane in the anchor’s coordinate space.
  final Vector3 extent;

  static ARKitPlaneAnchor fromMap(Map<String, String> map) => ARKitPlaneAnchor(
        createVector3FromString(map['center']),
        createVector3FromString(map['extent']),
        map['node_name'],
        map['identifier'],
        getMatrixFromString(map['transform']),
      );
}

/// An anchor representing an image in the world.
class ARKitImageAnchor extends ARKitAnchor {
  ARKitImageAnchor(
    this.referenceImageName,
    String nodeName,
    String identifier,
    Matrix4 transorm,
  ) : super(
          nodeName,
          identifier,
          transorm,
        );

  /// Name of the detected image.
  final String referenceImageName;

  static ARKitImageAnchor fromMap(Map<String, String> map) => ARKitImageAnchor(
        map['referenceImageName'],
        map['node_name'],
        map['identifier'],
        getMatrixFromString(map['transform']),
      );
}

/// An anchor representing a face and its geometry.
class ARKitFaceAnchor extends ARKitAnchor {
  ARKitFaceAnchor(
    this.geometry,
    this.blendShapes,
    String nodeName,
    String identifier,
    Matrix4 transorm,
    this.leftEyeTransform,
    this.rightEyeTransform,
  ) : super(
          nodeName,
          identifier,
          transorm,
        );

  /// The face geometry updated based on the computed blend shapes.
  final ARKitFace geometry;

  /// The left eye’s rotation and translation relative to the anchor’s origin.
  final Matrix4 leftEyeTransform;

  /// The right eye’s rotation and translation relative to the anchor’s origin.
  final Matrix4 rightEyeTransform;

  /// A dictionary of blend shape coefficients for each blend shape location.
  /// Blend shapes coefficients define the amount of displacement of a neutral shape at a specific location on the face.
  final Map<String, double> blendShapes;

  static ARKitFaceAnchor fromMap(Map<String, dynamic> map) => ARKitFaceAnchor(
        ARKitFace(materials: [ARKitMaterial()]),
        map.cast<String, Map>()['blendShapes'].cast<String, double>(),
        map['node_name'],
        map['identifier'],
        getMatrixFromString(map['transform']),
        getMatrixFromString(map['leftEyeTransform']),
        getMatrixFromString(map['rightEyeTransform']),
      );
}
