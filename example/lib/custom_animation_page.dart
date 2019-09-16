import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomAnimationPage extends StatefulWidget {
  @override
  _CustomAnimationPageState createState() => _CustomAnimationPageState();
}

class _CustomAnimationPageState extends State<CustomAnimationPage> {
  ARKitController arkitController;
  ARKitReferenceNode node;
  String anchorId;
  bool idle = true;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Custom Animation')),
        floatingActionButton: FloatingActionButton(
          child: Icon(idle ? Icons.play_arrow : Icons.stop),
          onPressed: () async {
            if (node != null) {
              if (idle) {
                await arkitController?.playAnimation(
                    key: 'dancing',
                    sceneName: 'models.scnassets/twist_danceFixed',
                    animationIdentifier: 'twist_danceFixed-1');
              } else {
                await arkitController?.stopAnimation(key: 'dancing');
              }
              setState(() => idle = !idle);
            }
          },
        ),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
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
      url: 'models.scnassets/idleFixed.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
    controller.add(node, parentNodeName: anchor.nodeName);
  }
}
