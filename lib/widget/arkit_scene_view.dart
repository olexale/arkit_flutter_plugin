import 'dart:async';
import 'package:arkit_plugin/arkit_node.dart';
import 'package:arkit_plugin/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/geometries/arkit_plane.dart';
import 'package:arkit_plugin/utils/matrix4_utils.dart';
import 'package:arkit_plugin/widget/arkit_arplane_detection.dart';
import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

typedef ARKitPluginCreatedCallback = void Function(ARKitController controller);
typedef StringResultHandler = void Function(String text);
typedef AnchorEventHandler = void Function(ARKitAnchor anchor);
typedef Matrix4ResultHandler = void Function(Matrix4 point);

/// A widget that wraps ARSCNView from ARKit.
class ARKitSceneView extends StatefulWidget {
  const ARKitSceneView({
    Key key,
    @required this.onARKitViewCreated,
    this.showStatistics = false,
    this.autoenablesDefaultLighting = true,
    this.enableTapRecognizer = false,
    this.showFeaturePoints = false,
    this.showWorldOrigin = false,
    this.planeDetection = ARPlaneDetection.none,
    this.detectionImagesGroupName,
  }) : super(key: key);

  /// This function will be fired when ARKit view is created.
  final ARKitPluginCreatedCallback onARKitViewCreated;

  /// Determines whether the receiver should display statistics info like FPS.
  /// When set to true, statistics are displayed in a overlay on top of the rendered scene.
  /// Defaults to false.
  final bool showStatistics;

  /// Specifies whether the receiver should automatically light up scenes that have no light source.
  /// When enabled, a diffuse light is automatically added and placed while rendering scenes that have no light or only ambient lights.
  /// The default is true.
  final bool autoenablesDefaultLighting;

  /// Determines whether the receiver should recognize taps.
  /// The default is false.
  final bool enableTapRecognizer;

  /// Type of planes to detect in the scene.
  /// If set, new planes will continue to be detected and updated over time.
  /// Detected planes will be added to the session as ARPlaneAnchor objects.
  /// In the event that two planes are merged, the newer plane will be removed.
  /// Defaults to ARPlaneDetection.none.
  final ARPlaneDetection planeDetection;

  /// Show detected 3D feature points in the world.
  /// The default is false.
  final bool showFeaturePoints;

  /// Show the world origin in the scene.
  /// The default is false.
  final bool showWorldOrigin;

  /// Images to detect in the scene.
  /// If set the session will attempt to detect the specified images.
  /// When an image is detected an ARImageAnchor will be added to the session.
  final String detectionImagesGroupName;

  @override
  _ARKitSceneViewState createState() => _ARKitSceneViewState();
}

class _ARKitSceneViewState extends State<ARKitSceneView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'arkit',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text('$defaultTargetPlatform is not supported by this plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    if (widget.onARKitViewCreated == null) {
      return;
    }
    widget.onARKitViewCreated(ARKitController._init(
      id,
      widget.showStatistics,
      widget.autoenablesDefaultLighting,
      widget.enableTapRecognizer,
      widget.showFeaturePoints,
      widget.showWorldOrigin,
      widget.planeDetection,
      widget.detectionImagesGroupName,
    ));
  }
}

/// Controls an [ARKitSceneView].
///
/// An [ARKitController] instance can be obtained by setting the [ARKitSceneView.onARKitViewCreated]
/// callback for an [ARKitSceneView] widget.
class ARKitController {
  ARKitController._init(
    int id,
    bool showStatistics,
    bool autoenablesDefaultLighting,
    bool enableTapRecognizer,
    bool showFeaturePoints,
    bool showWorldOrigin,
    ARPlaneDetection planeDetection,
    String detectionImagesGroupName,
  ) {
    _channel = MethodChannel('arkit_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    _channel.invokeMethod<void>('init', {
      'showStatistics': showStatistics,
      'autoenablesDefaultLighting': autoenablesDefaultLighting,
      'enableTapRecognizer': enableTapRecognizer,
      'planeDetection': planeDetection.index,
      'showFeaturePoints': showFeaturePoints,
      'showWorldOrigin': showWorldOrigin,
      'detectionImagesGroupName': detectionImagesGroupName,
    });
  }

  MethodChannel _channel;
  StringResultHandler onError;
  StringResultHandler onTap;
  Matrix4ResultHandler onPlaneTap;

  AnchorEventHandler onAddNodeForAnchor;
  AnchorEventHandler onUpdateNodeForAnchor;

  void dispose() {
    _channel?.invokeMethod<void>('dispose');
  }

  Future<void> add(ARKitNode node, {String parentNodeName}) {
    assert(node != null);
    final params = _addParentNodeNameToParams(node.toMap(), parentNodeName);
    _subsribeToChanges(node);
    return _channel.invokeMethod('addARKitNode', params);
  }

  Map<String, dynamic> _addParentNodeNameToParams(
      Map geometryMap, String parentNodeName) {
    if (parentNodeName?.isNotEmpty ?? false)
      geometryMap['parentNodeName'] = parentNodeName;
    return geometryMap;
  }

  Future<void> _platformCallHandler(MethodCall call) {
    print('_platformCallHandler call ${call.method} ${call.arguments}');
    switch (call.method) {
      case 'onError':
        if (onError != null) {
          onError(call.arguments);
        }
        break;
      case 'onTap':
        if (onTap != null) {
          onTap(call.arguments);
        }
        break;
      case 'onPlaneTap':
        if (onPlaneTap != null) {
          onPlaneTap(getMatrixFromString(call.arguments));
        }
        break;
      case 'didAddNodeForAnchor':
        if (onAddNodeForAnchor != null) {
          final anchor = _buildAnchor(call.arguments);
          onAddNodeForAnchor(anchor);
        }
        break;
      case 'didUpdateNodeForAnchor':
        if (onUpdateNodeForAnchor != null) {
          final anchor = _buildAnchor(call.arguments);
          onUpdateNodeForAnchor(anchor);
        }
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
    return Future.value();
  }

  void _subsribeToChanges(ARKitNode node) {
    node.position.addListener(() => _handlePositionChanged(node));
    node.rotation.addListener(() => _handleRotationChanged(node));

    if (node.geometry != null) {
      node.geometry.materials.addListener(() => _updateMaterials(node));
      if (node.geometry is ARKitPlane) {
        final ARKitPlane plane = node.geometry;
        plane.width.addListener(() => _updateSingleProperty(
            node, 'width', plane.width.value, 'geometry'));
        plane.height.addListener(() => _updateSingleProperty(
            node, 'height', plane.height.value, 'geometry'));
      }
    }
    if (node.light != null) {
      node.light.intensity.addListener(() => _updateSingleProperty(
          node, 'intensity', node.light.intensity.value, 'light'));
    }
  }

  void _handlePositionChanged(ARKitNode node) {
    _channel.invokeMethod<void>('positionChanged',
        _getHandlerParams(node, convertVector3ToMap(node.position.value)));
  }

  void _handleRotationChanged(ARKitNode node) {
    _channel.invokeMethod<void>('rotationChanged',
        _getHandlerParams(node, convertVector4ToMap(node.rotation.value)));
  }

  void _updateMaterials(ARKitNode node) {
    _channel.invokeMethod<void>(
        'updateMaterials', _getHandlerParams(node, node.geometry.toMap()));
  }

  void _updateSingleProperty(
      ARKitNode node, String propertyName, dynamic value, String keyProperty) {
    _channel.invokeMethod<void>(
        'updateSingleProperty',
        _getHandlerParams(node, <String, dynamic>{
          'propertyName': propertyName,
          'propertyValue': value,
          'keyProperty': keyProperty,
        }));
  }

  Map<String, dynamic> _getHandlerParams(
      ARKitNode node, Map<String, dynamic> params) {
    final Map<String, dynamic> values = <String, dynamic>{'name': node.name}
      ..addAll(params);
    return values;
  }

  ARKitAnchor _buildAnchor(Map arguments) {
    final type = arguments['anchorType'].toString();
    final map = arguments.cast<String, String>();
    switch (type) {
      case 'planeAnchor':
        return ARKitPlaneAnchor.fromMap(map);
      case 'imageAnchor':
        return ARKitImageAnchor.fromMap(map);
    }
    return ARKitAnchor.fromMap(map);
  }
}
