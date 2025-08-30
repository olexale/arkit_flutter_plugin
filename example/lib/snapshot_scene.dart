import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin_example/util/ar_helper.dart';
import 'package:flutter/material.dart';

class SnapshotScenePage extends StatefulWidget {
  const SnapshotScenePage({super.key});

  @override
  State<SnapshotScenePage> createState() => _SnapshotScenePageState();
}

class _SnapshotScenePageState extends State<SnapshotScenePage> {
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
              final image = await arkitController.snapshot();
              if (!mounted) return;
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => SnapshotPreview(
                    imageProvider: image,
                  ),
                ),
              );
            } catch (e) {
              // Error handling - print replaced for production use
              debugPrint('Failed to create snapshot: $e');
            }
          },
        ),
        body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
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
  });

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Preview'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image(image: imageProvider),
          ],
        ));
  }
}
