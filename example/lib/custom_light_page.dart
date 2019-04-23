import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomLightPage extends StatefulWidget {
  @override
  _CustomLightPageState createState() => _CustomLightPageState();
}

class _CustomLightPageState extends State<CustomLightPage> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Custom Light Sample'),
      ),
      body: Container(
        child: ARKitSceneView(
          autoenablesDefaultLighting: false,
          onARKitViewCreated: onARKitViewCreated,
        ),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    _addLight(this.arkitController);
    _addSphere(this.arkitController);
    _addPlane(this.arkitController);
    _addText(this.arkitController);
  }

  void _addLight(ARKitController controller) {
    final light = ARKitLight(
      type: ARKitLightType.spot,
      color: Colors.blueGrey,
    );
    final node =
        ARKitNode(light: light, position: vector.Vector3(0.1, 0.4, 0.5));
    controller.add(node);
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

  void _addPlane(ARKitController controller) {
    final plane = ARKitPlane(
      width: 1,
      height: 1,
      materials: [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty(color: Colors.white),
        )
      ],
    );
    final node = ARKitNode(
      geometry: plane,
      position: vector.Vector3(0.4, 0.4, -1.5),
    );
    controller.add(node);
  }

  void _addText(ARKitController controller) {
    final text = ARKitText(
      text: 'Flutter',
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty(color: Colors.blue),
        )
      ],
    );
    final node = ARKitNode(
      geometry: text,
      position: vector.Vector3(0, 0, -0.5),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
    controller.add(node);
  }
}
