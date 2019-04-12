import 'dart:async';
import 'package:arkit_plugin/geometries/arkit_sphere.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

typedef ARKitPluginCreatedCallback = void Function(ARKitController controller);
typedef StringResultHandler = void Function(String text);

class ARKitSceneView extends StatefulWidget {
  const ARKitSceneView({
    Key key,
    @required this.onARKitViewCreated,
    this.showStatistics = true,
  }) : super(key: key);

  final ARKitPluginCreatedCallback onARKitViewCreated;
  final bool showStatistics;

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
    widget.onARKitViewCreated(ARKitController._init(id, widget.showStatistics));
  }
}

class ARKitController {
  ARKitController._init(int id, bool showStatistics) {
    _channel = MethodChannel('arkit_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    _channel.invokeMethod<void>('init', {'showStatistics': showStatistics});
  }

  MethodChannel _channel;
  StringResultHandler onError;

  void dispose() {
    _channel?.invokeMethod<void>('dispose');
  }

  Future<void> addSphere(ARKitSphere sphere) async {
    assert(sphere != null);
    return _channel.invokeMethod('addSphere', sphere.toMap());
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
