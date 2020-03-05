import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class NetworkImageDetectionPage extends StatefulWidget {
  @override
  _NetworkImageDetectionPageState createState() =>
      _NetworkImageDetectionPageState();
}

class _NetworkImageDetectionPageState extends State<NetworkImageDetectionPage> {
  ARKitController arkitController;
  Timer timer;
  bool anchorWasFound = false;

  @override
  void dispose() {
    timer?.cancel();
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Image Detection Sample')),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ARKitSceneView(
                detectionImages: const [
                  ARKitReferenceImage(
                    name:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg',
                    physicalWidth: 0.2,
                  ),
                ],
                onARKitViewCreated: onARKitViewCreated,
              ),
              anchorWasFound
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Point the camera at Mars photo from the article about Mars on Wikipedia.',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      setState(() => anchorWasFound = true);

      final material = ARKitMaterial(
        lightingModelName: ARKitLightingModel.lambert,
        diffuse: ARKitMaterialProperty(
            image: 'https://www.classe.cornell.edu/~seb/celestia/marsc-1k.jpg'),
      );
      final sphere = ARKitSphere(
        materials: [material],
        radius: 0.1,
      );

      final earthPosition = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: sphere,
        position:
            vector.Vector3(earthPosition.x, earthPosition.y, earthPosition.z),
        eulerAngles: vector.Vector3.zero(),
      );
      arkitController.add(node);

      timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        final old = node.eulerAngles.value;
        final eulerAngles = vector.Vector3(old.x, old.y + 0.1, old.z);
        node.eulerAngles.value = eulerAngles;
      });
    }
  }
}
