import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class CameraPropertiesPage extends StatefulWidget {
  const CameraPropertiesPage({super.key});

  @override
  State createState() => _CameraPropertiesPageState();
}

class _CameraPropertiesPageState extends State<CameraPropertiesPage> {
  late ARKitController arkitController;
  String properties = '';

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Camera Properties'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          late String updatedProperties;
          try {
            final position = await arkitController.cameraPosition();
            final intrinsic = await arkitController.getCameraIntrinsics();
            final resolution = await arkitController.getCameraImageResolution();

            updatedProperties = 'Camera position: $position\n'
                'Camera intrinsic: $intrinsic\n'
                'Camera resolution: $resolution';
          } catch (e) {
            updatedProperties = e.toString();
          }
          setState(() {
            properties = updatedProperties;
          });
        },
      ),
      body: Stack(
        children: [
          ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
          Text(properties),
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
  }
}
