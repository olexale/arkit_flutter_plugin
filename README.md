# arkit_flutter_plugin
ARKit Flutter Plugin

## Usage
Add the following code to `Info.plist`:
```xml
    <key>io.flutter.embedded_views_preview</key>
	<string>YES</string>
```
Provide the `NSCameraUsageDescription`.

The simplest code example:

```dart
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