import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class CameraIntrinsicScenePage extends StatefulWidget {
  @override
  _CameraIntrinsicScenePageState createState() =>
      _CameraIntrinsicScenePageState();
}

class _CameraIntrinsicScenePageState extends State<CameraIntrinsicScenePage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Camera Intrinsic'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            var intrinsic = await arkitController.getCameraIntrinsics();
            print('\nCamera intrinsic:\n$intrinsic');
          } catch (e) {
            print(e);
          }
        },
      ),
      body: Container(
        child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
  }
}
