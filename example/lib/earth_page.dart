import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class EarthPage extends StatefulWidget {
  @override
  _EarthPageState createState() => _EarthPageState();
}

class _EarthPageState extends State<EarthPage> {
  ARKitController arkitController;
  Timer timer;

  @override
  void dispose() {
    timer?.cancel();
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
      rotation: const ARKitVector4(0, 0, 0, 0),
      materials: [material],
      radius: 0.1,
    );
    this.arkitController.addSphere(sphere);

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final old = sphere.rotation.value;
      final rotation = ARKitVector4(old.x, old.y + 1, old.z, old.w + 0.05);
      sphere.rotation.value = rotation;
    });
  }
}
