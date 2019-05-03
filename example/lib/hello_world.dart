import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class HelloWorldPage extends StatefulWidget {
  @override
  _HelloWorldPagState createState() => _HelloWorldPagState();
}

class _HelloWorldPagState extends State<HelloWorldPage> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('ARKit in Flutter'),
      ),
      body: Container(
        child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    this.arkitController.add(_createSphere());
    this.arkitController.add(_createPlane());
    this.arkitController.add(_createText());
    this.arkitController.add(_createBox());
    this.arkitController.add(_createCylinder());
    this.arkitController.add(_createCone());
    this.arkitController.add(_createPyramid());
    this.arkitController.add(_createTube());
    this.arkitController.add(_createTorus());
    this.arkitController.add(_createCapsule());
  }

  ARKitNode _createSphere() => ARKitNode(
        geometry:
            ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.04),
        position: vector.Vector3(-0.1, -0.1, -0.5),
      );

  ARKitNode _createPlane() {
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
    return ARKitNode(
      geometry: plane,
      position: vector.Vector3(0, 0, -1.5),
    );
  }

  ARKitNode _createText() {
    final text = ARKitText(
      text: 'Flutter',
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty(color: Colors.blue),
        )
      ],
    );
    return ARKitNode(
      geometry: text,
      position: vector.Vector3(-0.3, 0.3, -1.4),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
  }

  ARKitNode _createBox() => ARKitNode(
        geometry: ARKitBox(
            width: 0.06,
            height: 0.06,
            length: 0.06,
            chamferRadius: 0.01,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(-0.1, 0, -0.5),
      );

  ARKitNode _createCylinder() => ARKitNode(
        geometry: ARKitCylinder(
            radius: 0.05,
            height: 0.09,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(-0.1, 0.1, -0.5),
      );

  ARKitNode _createCone() => ARKitNode(
        geometry: ARKitCone(
            topRadius: 0,
            bottomRadius: 0.05,
            height: 0.09,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(0, -0.1, -0.5),
      );

  ARKitNode _createPyramid() => ARKitNode(
        geometry: ARKitPyramid(
            width: 0.09,
            height: 0.09,
            length: 0.09,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(0, -0.05, -0.5),
      );

  ARKitNode _createTube() => ARKitNode(
        geometry: ARKitTube(
            innerRadius: 0.03,
            outerRadius: 0.05,
            height: 0.09,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(0.1, 0.1, -0.5),
      );

  ARKitNode _createTorus() => ARKitNode(
        geometry: ARKitTorus(
            ringRadius: 0.04,
            pipeRadius: 0.02,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(0.1, -0.1, -0.5),
      );

  ARKitNode _createCapsule() => ARKitNode(
        geometry: ARKitCapsule(
            capRadius: 0.02,
            height: 0.06,
            materials: _createRandomColorMaterial()),
        position: vector.Vector3(0.1, 0, -0.5),
      );

  List<ARKitMaterial> _createRandomColorMaterial() {
    return [
      ARKitMaterial(
        lightingModelName: ARKitLightingModel.physicallyBased,
        diffuse: ARKitMaterialProperty(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0),
        ),
      )
    ];
  }
}
