import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LightEstimatePage extends StatefulWidget {
  @override
  _LightEstimatePageState createState() => _LightEstimatePageState();
}

class _LightEstimatePageState extends State<LightEstimatePage> {
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
        appBar: AppBar(title: const Text('Light Estimation Sample')),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty(image: 'earth.jpg'),
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
      eulerAngles: vector.Vector3.zero(),
    );
    this.arkitController.add(node);

    final light = ARKitLight();
    final lightNode =
        ARKitNode(light: light, position: vector.Vector3(0.1, 0.4, 0.5));
    this.arkitController.add(lightNode);

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final old = node.eulerAngles.value;
      final eulerAngles = vector.Vector3(old.x, old.y + 0.1, old.z);
      node.eulerAngles.value = eulerAngles;

      this.arkitController.getLightEstimate().then((e) {
        if (e != null) {
          light.intensity.value = e.ambientIntensity;
        }
      });
    });
  }
}
