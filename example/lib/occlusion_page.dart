import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class OcclusionPage extends StatefulWidget {
  @override
  _OcclusionPageState createState() => _OcclusionPageState();
}

class _OcclusionPageState extends State<OcclusionPage> {
  ARKitController arkitController;
  ARKitPlane plane;
  ARKitNode node;
  String anchorId;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Occlusion Sample')),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            enableTapRecognizer: true,
            planeDetection: ARPlaneDetection.horizontalAndVertical,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhere(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
        orElse: () => null,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitPlaneAnchor)) {
      return;
    }
    _addPlane(arkitController, anchor);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId) {
      return;
    }
    final ARKitPlaneAnchor planeAnchor = anchor;
    node.position.value =
        vector.Vector3(planeAnchor.center.x, 0, planeAnchor.center.z);
    plane.width.value = planeAnchor.extent.x;
    plane.height.value = planeAnchor.extent.z;
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;
    plane = ARKitPlane(
      width: anchor.extent.x,
      height: anchor.extent.z,
      materials: [ARKitMaterial(colorBufferWriteMask: ARKitColorMask.none)],
    );

    node = ARKitNode(
      geometry: plane,
      renderingOrder: -1,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );
    final material =
        ARKitMaterial(diffuse: ARKitMaterialProperty(color: Colors.red));
    final sphere = ARKitSphere(
      radius: 0.006,
      materials: [material],
    );
    final node = ARKitNode(geometry: sphere, position: position);
    arkitController.add(node);
  }
}
