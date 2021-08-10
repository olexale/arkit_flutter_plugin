import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late ARKitController arkitController;
  late ARKitMaterialVideo _video;
  bool _isPlaying = true;

  @override
  void dispose() {
    _video.dispose();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Video Sample')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isPlaying) {
            await _video.pause();
          } else {
            await _video.play();
          }
          setState(() => _isPlaying = !_isPlaying);
        },
        child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    _video = ARKitMaterialProperty.video(
      width: 640,
      height: 320,
      filename: 'london.mp4',
    );
    final material = ARKitMaterial(
      diffuse: _video,
      doubleSided: true,
    );

    final sphere = ARKitSphere(materials: [material], radius: 1);

    final node = ARKitNode(geometry: sphere);
    node.eulerAngles = vector.Vector3(0, 0, math.pi); // rotate the node

    this.arkitController.add(node);
  }
}
