import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

/// WIP!!!
class WidgetProjectionPage extends StatefulWidget {
  @override
  _WidgetProjectionPageState createState() => _WidgetProjectionPageState();
}

class _WidgetProjectionPageState extends State<WidgetProjectionPage> {
  ARKitController arkitController;
  vector.Vector3 lastPosition;
  String anchorId;
  String distance = '0';

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Widget Projection'),
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
            worldAlignment: ARWorldAlignment.camera,
          ),
          Text(distance, style: Theme.of(context).textTheme.display1),
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      anchorId = anchor.identifier;
      _updateDistance(anchor);
    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId) {
      return;
    }
    _updateDistance(anchor);
  }

  Future _updateDistance(ARKitAnchor anchor) async {
    final position = vector.Vector3(
      anchor.transform.getColumn(3).x,
      anchor.transform.getColumn(3).y,
      anchor.transform.getColumn(3).z,
    );
    final projected = await arkitController.projectPoint(position);
    print(projected);
    setState(() {
      distance = '${projected.x}\n${projected.y}\n${projected.z}';
    });
  }
}
