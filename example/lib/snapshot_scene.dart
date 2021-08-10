import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin_example/util/ar_helper.dart';
import 'package:flutter/material.dart';

class SnapshotScenePage extends StatefulWidget {
  @override
  _SnapshotScenePageState createState() => _SnapshotScenePageState();
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
          try {
            final image = await arkitController.snapshot();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SnapshotPreview(
                  imageProvider: image,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
      body: Container(
        child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.add(createSphere());
  }
}

class SnapshotPreview extends StatelessWidget {
  const SnapshotPreview({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

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
      ),
    );
  }
}
