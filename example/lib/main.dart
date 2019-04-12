import 'package:arkit_plugin/arkit_position.dart';
import 'package:arkit_plugin/arkit_sphere.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ARKitController arkitController;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ARKit in Flutter'),
            ),
            body: Container(
              child: ARKitSceneView(
                showStatistics: true,
                onARKitViewCreated: onARKitViewCreated,
              ),
            )),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.addSphere(ARKitSphere(
          position: ARKitPosition(0, 0, -0.5),
          radius: 0.1,
        ));
  }
}
