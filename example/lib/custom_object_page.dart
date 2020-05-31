import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomObjectPage extends StatefulWidget {
  @override
  _CustomObjectPageState createState() => _CustomObjectPageState();
}

class _CustomObjectPageState extends State<CustomObjectPage> {
  ARKitController arkitController;
  ARKitReferenceNode node;
  String anchorId;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Custom object on plane Sample')),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
            enablePanRecognizer: true,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onNodePan = (results) async {
      ARKitNodePanResult panResult = results.first;
      double hitTestLocationX =
          panResult.touchLocation.x / MediaQuery.of(context).size.width;
      double hitTestLocationY = panResult.touchLocation.y /
          (MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      List<ARKitTestResult> hitResults = await arkitController.performHitTest(
        x: hitTestLocationX,
        y: hitTestLocationY,
      );

      ARKitTestResult hitResult = hitResults.firstWhere(
          (result) => result.type == ARKitHitTestResultType.existingPlane);

      node.position.value = vector.Vector3(
        hitResult.worldTransform.getColumn(3).x,
        hitResult.worldTransform.getColumn(3).y,
        hitResult.worldTransform.getColumn(3).z,
      );
    };
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }
    _addPlane(arkitController, anchor);
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;
    if (node != null) {
      controller.remove(node.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/eevee.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.002, 0.002, 0.002),
    );
    final transform = anchor.transform.getColumn(3);
    node.position.value = vector.Vector3(
      transform.x,
      transform.y,
      transform.z,
    );
    controller.add(node);
  }
}
