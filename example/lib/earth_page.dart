import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class EarthPage extends StatefulWidget {
  @override
  _EarthPageState createState() => _EarthPageState();
}

class _EarthPageState extends State<EarthPage> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Earth Sample')),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty(image: 'earth.jpg'),
    );
    final sphere = ARKitSphere(
      position: const ARKitVector3(0, 0, -0.5),
      materials: [material],
      radius: 0.1,
    );
    this.arkitController.add(sphere);
  }
}
