import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MeasurePage extends StatefulWidget {
  @override
  _MeasurePageState createState() => _MeasurePageState();
}

class _MeasurePageState extends State<MeasurePage> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Measure Sample'),
      ),
      body: Container(
        child: ARKitSceneView(
          enableTapRecognizer: true,
          onARKitViewCreated: onARKitViewCreated,
        ),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) => _onARTapHandler(ar);
  }

  void _addSphere(ARKitController controller) {
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.physicallyBased,
      diffuse: ARKitMaterialProperty(
        color: Colors.red,
      ),
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ARKitNode(
      geometry: sphere,
      position: vector.Vector3(0, 0, -0.5),
    );
    controller.add(node);
  }

  void _onARTapHandler(List<ARKitTestResult> ar) {
    print(ar.toString());
  }
}
