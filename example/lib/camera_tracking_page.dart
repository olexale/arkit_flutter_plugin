import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CameraTrackingPage extends StatefulWidget {
  @override
  CameraTrackingPageState createState() => CameraTrackingPageState();
}

class CameraTrackingPageState extends State<CameraTrackingPage> {
  ARKitController arkitController;
  ARTrackingState trackingState;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  String stateText() {
    switch (trackingState) {
      case ARTrackingState.ARTrackingStateNotAvailable:
        return 'tracking not available';
        break;
      case ARTrackingState.ARTrackingStateLimited:
        return 'tracking limited';
        break;
      case ARTrackingState.ARTrackingStateNormal:
        return 'tracking normal';
        break;
      default:
        return 'no tracking state';
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Camera Tracking'),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              ARKitSceneView(
                onARKitViewCreated: onARKitViewCreated,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    color: Colors.black.withOpacity(0.4),
                    child: Text(stateText(),
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.onCameraDidChangeTrackingState = (trackingState) {
      setState(() {
        this.trackingState = trackingState;
      });
    };
  }
}
