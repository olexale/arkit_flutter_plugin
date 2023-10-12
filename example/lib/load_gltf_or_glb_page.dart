import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadGltfOrGlbFilePage extends StatefulWidget {
  @override
  _LoadGltfOrGlbFilePageState createState() => _LoadGltfOrGlbFilePageState();
}

class _LoadGltfOrGlbFilePageState extends State<LoadGltfOrGlbFilePage> {
  late ARKitController arkitController;
  ARKitPlane? plane;
  ARKitNode? node;
  String? anchorId;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Load .gltf or .glb')),
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
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
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
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId || anchor is! ARKitPlaneAnchor) {
      return;
    }
    node?.position = vector.Vector3(anchor.center.x, 0, anchor.center.z);
    plane?.width.value = anchor.extent.x;
    plane?.height.value = anchor.extent.z;
  }

  void _onARTapHandler(ARKitTestResult point) async {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

   //  Test asset
   // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb"
   // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Embedded/Box.gltf
   //  (Place the downloaded .glTF or .glb file in assets folder (e.g. ./example/assets/gltf/Box.gltf).
    //Load from flutter asset
    node = ARKitReferenceNode(
      assetType: AssetType.flutterAsset,
      url: 'assets/gltf/Box.gltf',
      scale: vector.Vector3(0.05, 0.05, 0.05),
      position: position,
    );
    arkitController.add(node!);

   // Download test
   // Import to test file download
   // import 'package:dio/dio.dart';
   // import 'package:path_provider/path_provider.dart';
   // And add dependencies to pubspec.yaml file
   // path_provider: ^2.0.3
   // dio: ^5.3.3

   //  _downloadFile(
   //          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb")
   //      .then((file) => {
   //            if (file.existsSync())
   //              {
   //                //Load from app document folder
   //                node = ARKitReferenceNode(
   //                  assetType: AssetType.documents,
   //                  url: file.path.split('/').last, //  filename.extension only!
   //                  scale: vector.Vector3(0.01, 0.01, 0.01),
   //                  position: position,
   //                ),
   //                arkitController.add(node!)
   //              }
   //          });
  }

// Future<File> _downloadFile(String url) async {
//   try {
//     final dir = await getApplicationDocumentsDirectory();
//     final filePath = '${dir.path}/${url.split("/").last}';
//     await Dio().download(url, filePath);
//     final file = File(filePath);
//     print('Download completed!! path = $filePath');
//     return file;
//   } catch (e) {
//     print('Caught an exception: $e');
//     rethrow;
//   }
// }
}
