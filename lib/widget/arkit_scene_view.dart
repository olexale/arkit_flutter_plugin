import 'dart:async';
import 'package:arkit_plugin/geometries/arkit_plane.dart';
import 'package:arkit_plugin/geometries/arkit_sphere.dart';
import 'package:arkit_plugin/widget/arkit_arplane_detection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

typedef ARKitPluginCreatedCallback = void Function(ARKitController controller);
typedef StringResultHandler = void Function(String text);

/// A widget that wraps ARSCNView from ARKit.
class ARKitSceneView extends StatefulWidget {
  const ARKitSceneView({
    Key key,
    @required this.onARKitViewCreated,
    this.showStatistics = false,
    this.autoenablesDefaultLighting = true,
    this.planeDetection = ARPlaneDetection.horizontal,
  }) : super(key: key);

  /// This function will be fired when ARKit view is created.
  final ARKitPluginCreatedCallback onARKitViewCreated;

  /// Determines whether the receiver should display statistics info like FPS.
  /// Defaults to false.
  /// When set to true, statistics are displayed in a overlay on top of the rendered scene.
  final bool showStatistics;

  /// Specifies whether the receiver should automatically light up scenes that have no light source.
  /// The default is true.
  /// When enabled, a diffuse light is automatically added and placed while rendering scenes that have no light or only ambient lights.
  final bool autoenablesDefaultLighting;

  /// Indicating the type of planes to detect.
  /// The default is Horizontal.
  final ARPlaneDetection planeDetection;

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
      widget.planeDetection,
    ));
  }
}

class ARKitController {
  ARKitController._init(
    int id,
    bool showStatistics,
    bool autoenablesDefaultLighting,
    ARPlaneDetection planeDetection,
  ) {
    _channel = MethodChannel('arkit_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    _channel.invokeMethod<void>('init', {
      'showStatistics': showStatistics,
      'autoenablesDefaultLighting': autoenablesDefaultLighting,
      'planeDetection': planeDetection.index,
    });
  }

  MethodChannel _channel;
  StringResultHandler onError;

  void dispose() {
    _channel?.invokeMethod<void>('dispose');
  }

  Future<void> addSphere(ARKitSphere sphere) {
    assert(sphere != null);
    return _channel.invokeMethod('addSphere', sphere.toMap());
  }

  Future<void> addPlane(ARKitPlane plane) {
    assert(plane != null);
    return _channel.invokeMethod('addPlane', plane.toMap());
  }

  Future<void> _platformCallHandler(MethodCall call) {
    print('_platformCallHandler call ${call.method} ${call.arguments}');
    switch (call.method) {
      case 'onError':
        if (onError != null) {
          onError(call.arguments);
        }
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
    return Future.value();
  }
}
