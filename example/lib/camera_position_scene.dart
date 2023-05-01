import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class CameraPositionScenePage extends StatefulWidget {
  @override
  _CameraPositionScenePageState createState() => _CameraPositionScenePageState();
}

class _CameraPositionScenePageState extends State<CameraPositionScenePage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Camera Position'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            final position = await arkitController.cameraPosition();
            print('Camera position: $position');
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