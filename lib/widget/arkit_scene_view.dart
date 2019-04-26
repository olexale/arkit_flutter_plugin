import 'dart:async';
import 'package:arkit_plugin/arkit_node.dart';
import 'package:arkit_plugin/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/geometries/arkit_plane.dart';
import 'package:arkit_plugin/hit/arkit_node_pinch_result.dart';
import 'package:arkit_plugin/light/arkit_light_estimate.dart';
import 'package:arkit_plugin/widget/arkit_arplane_detection.dart';
import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:arkit_plugin/hit/arkit_hit_test_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

typedef ARKitPluginCreatedCallback = void Function(ARKitController controller);
typedef StringResultHandler = void Function(String text);
typedef AnchorEventHandler = void Function(ARKitAnchor anchor);
typedef ARKitHitResultHandler = void Function(List<ARKitTestResult> hits);
typedef ARKitPinchGestureHandler = void Function(
    List<ARKitNodePinchResult> pinch);

/// A widget that wraps ARSCNView from ARKit.
class ARKitSceneView extends StatefulWidget {
  const ARKitSceneView({
    Key key,
    @required this.onARKitViewCreated,
    this.showStatistics = false,
    this.autoenablesDefaultLighting = true,
    this.enableTapRecognizer = false,
    this.enablePinchRecognizer = false,
    this.showFeaturePoints = false,
    this.showWorldOrigin = false,
    this.planeDetection = ARPlaneDetection.none,
    this.detectionImagesGroupName,
    this.forceUserTapOnCenter = false,
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

  /// Determines whether the receiver should recognize pinch events.
  /// The default is false.
  final bool enablePinchRecognizer;

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

  /// When set every user tap will be processed like user tapped on the center of the screen.
  /// The default is false.
  final bool forceUserTapOnCenter;

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
      widget.enablePinchRecognizer,
      widget.planeDetection,
      widget.detectionImagesGroupName,
      widget.forceUserTapOnCenter,
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
    bool enablePinchRecognizer,
    ARPlaneDetection planeDetection,
    String detectionImagesGroupName,
    bool forceUserTapOnCenter,
  ) {
    _channel = MethodChannel('arkit_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    _channel.invokeMethod<void>('init', {
      'showStatistics': showStatistics,
      'autoenablesDefaultLighting': autoenablesDefaultLighting,
      'enableTapRecognizer': enableTapRecognizer,
      'enablePinchRecognizer': enablePinchRecognizer,
      'planeDetection': planeDetection.index,
      'showFeaturePoints': showFeaturePoints,
      'showWorldOrigin': showWorldOrigin,
      'detectionImagesGroupName': detectionImagesGroupName,
      'forceUserTapOnCenter': forceUserTapOnCenter,
    });
  }

  MethodChannel _channel;
  StringResultHandler onError;
  StringResultHandler onNodeTap;
  ARKitHitResultHandler onARTap;
  ARKitPinchGestureHandler onNodePinch;

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

  Future<void> removeNode({@required String nodeName}) {
    assert(nodeName != null);
    return _channel.invokeMethod('removeARKitNode', {'nodeName': nodeName});
  }

  /// Return list of 2 Vector3 elements, where first element - min value, last element - max value.
  Future<List<Vector3>> getNodeBoundingBox(ARKitNode node) async {
    final params = _addParentNodeNameToParams(node.toMap(), null);
    final List<String> result =
        await _channel.invokeListMethod<String>('getNodeBoundingBox', params);
    return result
        .map((String value) => createVector3FromString(value))
        .toList();
  }

  Future<ARKitLightEstimate> getLightEstimate() async {
    final estimate =
        await _channel.invokeMethod<Map<dynamic, dynamic>>('getLightEstimate');
    return estimate != null
        ? ARKitLightEstimate.fromMap(estimate.cast<String, double>())
        : null;
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
      case 'onNodeTap':
        if (onNodeTap != null) {
          onNodeTap(call.arguments);
        }
        break;
      case 'onARTap':
        if (onARTap != null) {
          final List<dynamic> input = call.arguments;
          final objects = input
              .cast<Map<dynamic, dynamic>>()
              .map<ARKitTestResult>(
                  (Map<dynamic, dynamic> r) => ARKitTestResult.fromMap(r))
              .toList();
          onARTap(objects);
        }
        break;
      case 'onNodePinch':
        if (onNodePinch != null) {
          final List<dynamic> input = call.arguments;
          final objects = input
              .cast<Map<dynamic, dynamic>>()
              .map<ARKitNodePinchResult>(
                  (Map<dynamic, dynamic> r) => ARKitNodePinchResult.fromMap(r))
              .toList();
          onNodePinch(objects);
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
    node.scale.addListener(() => _handleScaleChanged(node));

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

  void _handleScaleChanged(ARKitNode node) {
    _channel.invokeMethod<void>('scaleChanged',
        _getHandlerParams(node, convertVector3ToMap(node.scale.value)));
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
