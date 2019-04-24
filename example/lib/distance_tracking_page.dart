import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class DistanceTrackingPage extends StatefulWidget {
  @override
  _DistanceTrackingPageState createState() => _DistanceTrackingPageState();
}

class _DistanceTrackingPageState extends State<DistanceTrackingPage> {
  ARKitController arkitController;
  ARKitPlane plane;
  ARKitNode node;
  String anchorId;
  vector.Vector3 lastPosition;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Distance Tracking Sample')),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
            enableTapRecognizer: true,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onARTap = (List<ARKitTestResult> ar) {
      final planeTap =
          ar.firstWhere((tap) => tap.type.existingPlaneUsingExtent);
      if (planeTap != null) {
        _onPlaneTapHandler(planeTap.worldTransform);
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
      materials: [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty(color: Colors.white),
        )
      ],
    );

    node = ARKitNode(
      geometry: plane,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
  }

  void _onPlaneTapHandler(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getColumn(3).x,
      transform.getColumn(3).y,
      transform.getColumn(3).z,
    );
    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.constant,
      diffuse:
          ARKitMaterialProperty(color: const Color.fromRGBO(255, 153, 83, 1)),
    );
    final sphere = ARKitSphere(
      radius: 0.003,
      materials: [material],
    );
    final node = ARKitNode(
      geometry: sphere,
      position: position,
    );
    arkitController.add(node);
    if (lastPosition != null) {
      final line = ARKitLine(
        fromVector: lastPosition,
        toVector: position,
      );
      final lineNode = ARKitNode(geometry: line);
      arkitController.add(lineNode);

      final distance = _calculateDistanceBetweenPoints(position, lastPosition);
      final point = _getMiddleVector(position, lastPosition);
      _drawText(distance, point);
    }
    lastPosition = position;
  }

  String _calculateDistanceBetweenPoints(vector.Vector3 A, vector.Vector3 B) {
    final length = math.sqrt(math.pow(A.x - B.x, 2) +
        math.pow(A.y - B.y, 2) +
        math.pow(A.z - B.z, 2));
    return '${(length * 100).toStringAsFixed(2)} cm';
  }

  vector.Vector3 _getMiddleVector(vector.Vector3 A, vector.Vector3 B) {
    return vector.Vector3((A.x + B.x) / 2, (A.y + B.y) / 2, (A.z + B.z) / 2);
  }

  void _drawText(String text, vector.Vector3 point) {
    final textGeometry = ARKitText(
      text: text,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty(color: Colors.red),
        )
      ],
    );
    const scale = 0.001;
    final vectorScale = vector.Vector3(scale, scale, scale);
    final node = ARKitNode(
      geometry: textGeometry,
      position: point,
      scale: vectorScale,
    );
    arkitController.add(node);
  }
}
