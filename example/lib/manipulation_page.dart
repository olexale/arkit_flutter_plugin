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
  List<ARKitNode> nodes = [];

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
            showFeaturePoints: true,
            enableTapRecognizer: true,
            enablePinchRecognizer: true,
            enablePanRecognizer: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point =
          ar.firstWhere((o) => o.type == ARKitHitTestResultType.featurePoint);
      if (point != null) {
        _onTapHandler(point);
      }
    };
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
  }

  void _onTapHandler(ARKitTestResult point) {
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.physicallyBased,
      diffuse: ARKitMaterialProperty(
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      ),
    );
    final box =
        ARKitBox(materials: [material], width: 0.2, height: 0.2, length: 0.2);
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final node = ARKitNode(
      geometry: box,
      scale: vector.Vector3.all(1),
      eulerAngles: vector.Vector3.zero(),
      position: position,
    );
    arkitController.add(node);
    nodes.add(node);
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    for (var pinchNode in pinch) {
      final node = nodes.firstWhere((n) => n.name == pinchNode.nodeName);
      if (node != null) {
        final scale = vector.Vector3(
          node.scale.value.x * pinchNode.scale,
          node.scale.value.y * pinchNode.scale,
          node.scale.value.z * pinchNode.scale,
        );
        node.scale.value = scale;
      }
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    for (var panNode in pan) {
      final node = nodes.firstWhere((n) => n.name == panNode.nodeName);
      if (node != null) {
        final old = node.eulerAngles.value;
        final newAngleY = panNode.translation.x * math.pi / 180;
        node.eulerAngles.value = vector.Vector3(old.x, newAngleY, old.z);
      }
    }
  }
}
