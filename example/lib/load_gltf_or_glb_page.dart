import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadGltfOrGlbFilePage extends StatefulWidget {
  @override
  State<LoadGltfOrGlbFilePage> createState() => _LoadGltfOrGlbFilePageState();
}

class _LoadGltfOrGlbFilePageState extends State<LoadGltfOrGlbFilePage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Load .gltf or .glb')),
        body: ARKitSceneView(
          showFeaturePoints: true,
          enableTapRecognizer: true,
          planeDetection: ARPlaneDetection.horizontalAndVertical,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final node = _getNodeFromFlutterAsset(position);
    // final node = _getNodeFromNetwork(position);
    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        // Box model from
        // https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb
        url: 'assets/gltf/Box.gltf',
        scale: vector.Vector3(0.05, 0.05, 0.05),
        position: position,
      );
}

// Future<ARKitGltfNode> _getNodeFromNetwork(vector.Vector3 position) async {
// And add dependencies to pubspec.yaml file
// path_provider: ^2.0.3
// dio: ^5.3.3
//
// Import to test file download
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
//
//  final file = await _downloadFile(
//          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Box/glTF-Binary/Box.glb");
//  if (file.existsSync()) {
//    //Load from app document folder
//    return ARKitGltfNode(
//      assetType: AssetType.documents,
//      url: file.path.split('/').last, //  filename.extension only!
//      scale: vector.Vector3(0.01, 0.01, 0.01),
//      position: position,
//    );
//  }
//  throw Exception('Failed to load $file');
// }
//
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
