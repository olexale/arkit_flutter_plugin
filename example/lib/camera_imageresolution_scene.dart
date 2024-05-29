import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class CameraImageresolutionScenePage extends StatefulWidget {
  @override
  _CameraImageresolutionScenePageState createState() =>
      _CameraImageresolutionScenePageState();
}

class _CameraImageresolutionScenePageState
    extends State<CameraImageresolutionScenePage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Camera Image Resolution'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            var intrinsic = await arkitController.getCameraImageResolution();
            print('\nCamera Image Resolution:\n$intrinsic');
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
