import 'dart:collection';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin_example/util/ar_helper.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late ARKitController arkitController;
  vector.Vector3? lastPosition;
  ARKitLineNode? lineNode;
  HashMap<int, ARKitLineNode> map = HashMap<int, ARKitLineNode>();

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Draw a line')),
    body: Container(
        child: Listener(
            onPointerDown: (opm) async {
              createLineNode(opm);
            },
            onPointerMove: (opm) async {
              drawLine(opm);
            },
            onPointerCancel: (opc) {},
            onPointerUp: (opc) {},
            child: ARKitSceneView(
              onARKitViewCreated: onARKitViewCreated,
            ))),
  );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
  }

  void createLineNode(PointerDownEvent pde) {
    double randomRadius = 0.001 + Random().nextDouble() * (0.01 - 0.001);
    final lineNode = ARKitLineNode(
        radius: randomRadius,
        materials: createRandomColorMaterial());
    arkitController.add(lineNode);
    map[pde.pointer] = lineNode;
  }

  void drawLine(PointerMoveEvent pme) {
    if (map.containsKey(pme.pointer)) {
      final lineNode = map[pme.pointer];
      if (lineNode != null) {
        arkitController.updateLine(lineNode.name,
            pme.position.dx, pme.position.dy - kToolbarHeight - MediaQuery.of(context).padding.top);
      }
    }
  }
}