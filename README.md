# arkit_flutter_plugin
[![Codemagic build status](https://api.codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/status_badge.svg)](https://codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/latest_build) [![flutter awesome](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter)
[![pub package](https://img.shields.io/pub/v/arkit_plugin.svg)](https://pub.dartlang.org/packages/arkit_plugin)

**Note**: ARKit is only supported by mobile devices with A9 or later processors (iPhone 6s/7/SE/8/X, iPad 2017/Pro) on iOS 11 and newer. For some features iOS 12 is required.

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
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MaterialApp(home: MyApp()));

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
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('ARKit in Flutter')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
    this.arkitController.add(node);
  }
}
```
Result:

![flutter](./demo.gif)

## Examples

I would highly recommend to review the [sample](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/main.dart) from the `Example` folder. You may find a couple of samples in the `Example` folder of the plugin. Some samples rely on [this Earth image](https://upload.wikimedia.org/wikipedia/commons/9/97/The_Earth_seen_from_Apollo_17.jpg)

| Name        | Description                                          | Link | Demo |
|-------------|------------------------------------------------------|------------------------------------------------------|----|
| Hello World | The simplest scene with different geometries.           | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/hello_world.dart)| [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Earth       | Sphere with an image texture and rotation animation. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/earth_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Tap         | Sphere which handles tap event.                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/tap_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Plane Detection | Detects horizontal plane. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/plane_detection_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118870195743883266) |
| Distance tracking | Detects horizontal plane and track distance on it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/distance_tracking_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121022506180149248) |
| Measure | Measures distances | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/measure_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121022506180149248) |
| Physics | A sphere and a plane with dynamic and static physics                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/physics_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1119233047851884547) |
| Image Detection | Detects Earth photo and puts a 3D object near it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/image_detection_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1120287361974378496) |
| Network Image Detection | Detects Mars photo and puts a 3D object near it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/network_image_detection_page.dart) | |
| Custom Light | Hello World scene with a custom light spot. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_light_page.dart) | |
| Light Estimation | Estimates and applies the light around you. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/light_estimate_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1120671744426221573) |
| Custom Object | Place custom object on plane. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_object_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121037162852569090) |
| Occlusion | Spheres which are not visible after horizontal and vertical planes. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/occlusion_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1121421315364274177) |
| Manipulation | Custom objects with pinch and rotation events. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/manipulation_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1123893412279791616) |
| Face Tracking | Face mask sample. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/face_detection_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1143483440278454277) |
| Panorama | 360 photo. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/panorama_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1154665277654781952) |
| Custom Animation | Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_animation_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1173587705206366209) |
| Widget Projection | Flutter widgets in AR | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/widget_projection.dart)|[twitter](https://twitter.com/OlexaLe/status/1174678765592567814) |

If you prefer video here is a playlist with "AR in Flutter" videos:
[![AR in Flutter videos](https://img.youtube.com/vi/gOgCdl5_E7k/0.jpg)](https://www.youtube.com/watch?v=MaH4L6R8ZfQ&list=PLjaSBcAZ8TqGoWj3FE96uQ2gGPDGaXbDp "AR in Flutter videos")

## UX advice
You might want to check the device capabilities before establishing an AR session. Review the [Check Support](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/check_support_page.dart) sample for the implementation details.

## Before you go to AppStore
The plugin supports TrueDepth API. In case you didn't use it, your app will be rejected by Apple. Hence you need to remove any TrueDepth functionality by modifying your `Podfile` file
```Ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      ... # Here are some configurations automatically generated by flutter

      config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDISABLE_TRUEDEPTH_API'
    end
  end
end
```

## Contributing

If you find a bug or would like to request a new feature, just [open an issue](https://github.com/olexale/arkit_flutter_plugin/issues/new). Your contributions are always welcome!
