import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class PlaneDetectionPage extends StatefulWidget {
  @override
  _PlaneDetectionPageState createState() => _PlaneDetectionPageState();
}

class _PlaneDetectionPageState extends State<PlaneDetectionPage> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Plane Detection Sample')),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            showWorldOrigin: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    //TODO: not finished yet
  }
}
