# arkit_flutter_plugin
[![Codemagic build status](https://api.codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/status_badge.svg)](https://codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/latest_build) [![flutter awesome](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter)
[![pub package](https://img.shields.io/pub/v/arkit_plugin.svg)](https://pub.dartlang.org/packages/arkit_plugin)

**Note**: ARKit is only supported by mobile devices with A9 or later processors (iPhone 6s/7/SE/8/X, iPad 2017/Pro) on iOS 11 and newer.

## Usage

### Depend on it

Follow the [installation instructions](https://pub.dartlang.org/packages/arkit_plugin#-installing-tab-) from Dart Packages site.

### Update Info.plist

The plugin use native view from ARKit, which is not yet supported by default. To make it work add the following code to `Info.plist`:
```xml
    <key>io.flutter.embedded_views_preview</key>
    <string>YES</string>
```
ARKit uses the device camera, so do not forget to provide the `NSCameraUsageDescription`. You may specify it in `Info.plist` like that:
```xml
    <key>NSCameraUsageDescription</key>
    <string>Describe why your app needs AR here.</string>
```

### Write the app

The simplest code example:

```dart
import 'package:arkit_plugin/arkit_position.dart';
import 'package:arkit_plugin/arkit_sphere.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';


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
          position: Vector3(0, 0, -0.5),
          radius: 0.1,
        ));
  }
}
```
Result:

![flutter](./demo.gif)

## Examples

I would highly recommend to review the [sample](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/main.dart) from the `Example` folder. You may find a couple of samples in the `Example` folder of the plugin.

| Name        | Description                                          | Link                                                 |
|-------------|------------------------------------------------------|------------------------------------------------------|
| Hello World | The simplest scene with only 3 AR objects.           | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/hello_world.dart)|
| Earth       | Sphere with an image texture and rotation animation. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/earth_page.dart) |
| Tap         | Sphere which handles tap event.                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/tap_page.dart) |
| Plane Detection | Detects horizontal plane. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/plane_detection_page.dart) |
| Distance tracking | Detects horizontal plane and track distance on it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/distance_tracking_page.dart) |
| Measure | Measures distances | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/measure_page.dart) |
| Physics | A sphere and a plane with dynamic and static physics                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/physics_page.dart) |
| Image Detection | Detects an earth image and puts a 3D object near it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/image_detection_page.dart) |
| Custom Light | Hello World scene with a custom light spot. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_light_page.dart) |
| Light Estimation | Estimates and applies the light around you. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/light_estimate_page.dart) |
| Custom Object | Place custom object on plane. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_object_page.dart) |

## Contributing

If you find a bug or would like to request a new feature, just [open an issue](https://github.com/olexale/arkit_flutter_plugin/issues/new). Your contributions are always welcome!
