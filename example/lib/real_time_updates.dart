import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class RealTimeUpdatesPage extends StatefulWidget {
  @override
  _RealTimeUpdatesPageState createState() => _RealTimeUpdatesPageState();
}

class _RealTimeUpdatesPageState extends State<RealTimeUpdatesPage> {
  ARKitController arkitController;
  ARKitNode movingNode;
  bool busy = false;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Time Updates Sample'),
      ),
      body: Container(
        child: ARKitSceneView(
          onARKitViewCreated: _onARKitViewCreated,
        ),
      ),
    );
  }

  void _onARKitViewCreated(ARKitController arkitController) {
    final ARKitMaterial material = ARKitMaterial(
      diffuse: ARKitMaterialProperty(color: Colors.white),
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.01,
    );

    movingNode = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.25),
    );

    this.arkitController = arkitController;
    this.arkitController.updateAtTime = (time) {
      if (busy == false) {
        busy = true;
        this.arkitController.performHitTest(x: 0.25, y: 0.75).then((results) {
          if (results.isNotEmpty) {
            final point = results.firstWhere(
                (o) => o.type == ARKitHitTestResultType.featurePoint,
                orElse: () => null);
            if (point == null) {
              return;
            }
            final position = vector.Vector3(
              point.worldTransform.getColumn(3).x,
              point.worldTransform.getColumn(3).y,
              point.worldTransform.getColumn(3).z,
            );
            final ARKitNode newNode = ARKitNode(
              geometry: sphere,
              position: position,
            );
            this.arkitController.remove(movingNode.name);
            movingNode = null;
            this.arkitController.add(newNode);
            movingNode = newNode;
          }
          busy = false;
        });
      }
    };

    this.arkitController.add(movingNode);
  }
}
