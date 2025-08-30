import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin_example/util/ar_helper.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class SnapshotDepthScenePage extends StatefulWidget {
  const SnapshotDepthScenePage({super.key});

  @override
  State<SnapshotDepthScenePage> createState() => _SnapshotDepthScenePageState();
}

class _SnapshotDepthScenePageState extends State<SnapshotDepthScenePage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Snapshot'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            final navigator = Navigator.of(context);
            try {
              final data = await arkitController.snapshotWithDepthData();
              if (data == null) return;
              final image = data['image']! as MemoryImage;
              final depthData = (data..remove('image')).map<String, String>(
                (key, value) => MapEntry(key, value.toString()),
              );
              if (!mounted) return;
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => SnapshotPreview(
                    imageProvider: image,
                    depthData: depthData,
                  ),
                ),
              );
            } catch (e) {
              // Error handling - print replaced for production use
              debugPrint('Failed to create snapshot: $e');
            }
          },
        ),
        body: ARKitSceneView(
          configuration: ARKitConfiguration.depthTracking,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.add(createSphere());
  }
}

class SnapshotPreview extends StatelessWidget {
  const SnapshotPreview({
    super.key,
    required this.imageProvider,
    required this.depthData,
  });

  final ImageProvider imageProvider;
  final Map<String, String> depthData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepthDataPreview(
                  depthData: depthData,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: 90 * math.pi / 180,
            child: Image(image: imageProvider),
          ),
        ],
      ),
    );
  }
}

class DepthDataPreview extends StatelessWidget {
  const DepthDataPreview({
    super.key,
    required this.depthData,
  });

  final Map<String, String> depthData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Depth Data Preview'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Depth Width'),
              subtitle: Text(depthData['depthWidth']!),
            ),
            ListTile(
              title: Text('Depth Height'),
              subtitle: Text(depthData['depthHeight']!),
            ),
            ListTile(
              title: Text('Intrinsics'),
              subtitle: Text(depthData['intrinsics']!),
            ),
            ListTile(
              title: Text('Depth Map'),
              subtitle: Text(depthData['depthMap']!),
            ),
          ],
        ));
  }
}
