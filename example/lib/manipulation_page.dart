import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ManipulationPage extends StatefulWidget {
  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}

class _ManipulationPageState extends State<ManipulationPage> {
  ARKitController arkitController;
  ARKitNode boxNode;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Manipulation Sample')),
        body: Container(
          child: ARKitSceneView(
            enablePinchRecognizer: true,
            enablePanRecognizer: true,
            enableRotationRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);
    addNode();
  }

  void addNode() {
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.physicallyBased,
      diffuse: ARKitMaterialProperty(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      ),
    );
    final box =
        ARKitBox(materials: [material], width: 0.1, height: 0.1, length: 0.1);

    final node = ARKitNode(
      geometry: box,
      position: vector.Vector3(0, 0, -0.5),
    );
    arkitController.add(node);
    boxNode = node;
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    final pinchNode = pinch.firstWhere(
      (e) => e.nodeName == boxNode.name,
      orElse: () => null,
    );
    if (pinchNode != null) {
      final scale = vector.Vector3.all(pinchNode.scale);
      boxNode.scale.value = scale;
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    final panNode =
        pan.firstWhere((e) => e.nodeName == boxNode.name, orElse: null);
    if (panNode != null) {
      final old = boxNode.eulerAngles.value;
      final newAngleY = panNode.translation.x * math.pi / 180;
      boxNode.eulerAngles.value = vector.Vector3(old.x, newAngleY, old.z);
    }
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    final rotationNode = rotation.firstWhere(
      (e) => e.nodeName == boxNode.name,
      orElse: () => null,
    );
    if (rotationNode != null) {
      final rotation =
          boxNode.rotation.value + vector.Vector4.all(rotationNode.rotation);
      boxNode.rotation.value = rotation;
    }
  }
}
