import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class WidgetProjectionPage extends StatefulWidget {
  @override
  _WidgetProjectionPageState createState() => _WidgetProjectionPageState();
}

class _WidgetProjectionPageState extends State<WidgetProjectionPage> {
  ARKitController arkitController;
  String anchorId;
  double x, y;
  double width = 1, height = 1;
  Matrix4 transform = Matrix4.identity();

  @override
  void dispose() {
    arkitController?.onAddNodeForAnchor = null;
    arkitController?.onUpdateNodeForAnchor = null;
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Widget Projection'),
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            trackingImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
            worldAlignment: ARWorldAlignment.camera,
            configuration: ARKitConfiguration.imageTracking,
          ),
          Positioned(
            left: x,
            top: y,
            child: Container(
              transform: transform,
              width: width,
              height: height,
              child: const MyHomePage(
                title: 'Widgets in AR',
              ),
            ),
          ),
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      anchorId = anchor.identifier;
      _updatePosition(anchor);
      _updateRotation(anchor);
    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier == anchorId) {
      _updatePosition(anchor);
      _updateRotation(anchor);
    }
  }

  Future _updateRotation(ARKitAnchor anchor) async {
    final t = anchor.transform.clone();
    t.invertRotation();
    t.rotateZ(math.pi / 2);
    t.rotateX(math.pi / 2);
    setState(() {
      transform = t;
    });
  }

  Future _updatePosition(ARKitImageAnchor anchor) async {
    final transform = anchor.transform;
    final width = anchor.referenceImagePhysicalSize.x / 2;
    final height = anchor.referenceImagePhysicalSize.y / 2;

    final vector.Vector4 topRight = vector.Vector4(width, 0, -height, 1)
      ..applyMatrix4(transform);
    final vector.Vector4 bottomRight = vector.Vector4(width, 0, height, 1)
      ..applyMatrix4(transform);
    final vector.Vector4 bottomLeft = vector.Vector4(-width, 0, -height, 1)
      ..applyMatrix4(transform);
    final vector.Vector4 topLeft = vector.Vector4(-width, 0, height, 1)
      ..applyMatrix4(transform);

    final pointsWorldSpace = [topRight, bottomRight, bottomLeft, topLeft];

    final pointsViewportSpace = pointsWorldSpace.map(
        (p) => arkitController.projectPoint(vector.Vector3(p.x, p.y, p.z)));
    final pointsViewportSpaceResults = await Future.wait(pointsViewportSpace);

    setState(() {
      x = pointsViewportSpaceResults[2].x;
      y = pointsViewportSpaceResults[2].y;
      this.width = pointsViewportSpaceResults[0]
          .distanceTo(pointsViewportSpaceResults[3]);
      this.height = pointsViewportSpaceResults[1]
          .distanceTo(pointsViewportSpaceResults[2]);
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
