# arkit_flutter_plugin
[![Codemagic build status](https://api.codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/status_badge.svg)](https://codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/latest_build)

ARKit Flutter Plugin

**Note**: ARKit is only supported by mobile devices with A9 or later processors (iPhone 6s/7/SE/8/X, iPad 2017/Pro) on iOS 11 and newer.

## Usage
Add the following code to `Info.plist`:
```xml
    <key>io.flutter.embedded_views_preview</key>
    <string>YES</string>
```
Provide the `NSCameraUsageDescription`.

The simplest code example:

```dart
import 'package:arkit_plugin/arkit_position.dart';
import 'package:arkit_plugin/arkit_sphere.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ARKit in Flutter'),
            ),
            body: Container(
              child: ARKitSceneView(
                showStatistics: true,
                onARKitViewCreated: onARKitViewCreated,
              ),
            )),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.addSphere(ARKitSphere(
          position: ARKitPosition(0, 0, -0.5),
          radius: 0.1,
        ));
  }
}
```
Result:

![flutter](./demo.gif)

## Contributing

If you find a bug or would like to request a new feature, just [open an issue](https://github.com/olexale/arkit_flutter_plugin/issues/new). Your contributions are always welcome!
