import 'package:arkit_plugin/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:arkit_plugin/geometries/arkit_position.dart';
import 'package:meta/meta.dart';

/// Represents a rectangle with controllable width and height. The plane has one visible side.
class ARKitPlane extends ARKitGeometry {
  ARKitPlane({
    this.width = 1,
    this.height = 1,
    this.widthSegmentCount = 1,
    this.heightSegmentCount = 1,
    @required ARKitPosition position,
    List<ARKitMaterial> materials,
  }) : super(position, materials: materials);

  /// The plane extent along the X axis.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final double width;

  /// The plane extent along the Y axis.
  /// If the value is less than or equal to 0, the geometry is empty.
  /// The default value is 1.
  final double height;

  /// The number of subdivisions along the X axis.
  /// If the value is less than 1, the behavior is undefined.
  /// The default value is 1.
  final int widthSegmentCount;

  /// The number of subdivisions along the Y axis. The default value is 1.
  /// If the value is less than 1, the behavior is undefined.
  /// The default value is 1.
  final int heightSegmentCount;

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'width': width,
        'height': height,
        'widthSegmentCount': widthSegmentCount,
        'heightSegmentCount': heightSegmentCount,
      }..addAll(super.toMap());
}
