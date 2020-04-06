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
  ARTrackingStateReason trackingStateReason;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  String trackingStateText() {
    switch (trackingState) {
      case ARTrackingState.notAvailable:
        return 'tracking not available';
        break;
      case ARTrackingState.limited:
        return 'tracking limited';
        break;
      case ARTrackingState.normal:
        return 'tracking normal';
        break;
      default:
        return 'no tracking state';
        break;
    }
  }

  String reasonText() {
    switch (trackingStateReason) {
      case ARTrackingStateReason.excessiveMotion:
        return 'excessive motion';
        break;
      case ARTrackingStateReason.insufficientFeatures:
        return 'insufficient features';
        break;
      case ARTrackingStateReason.initializing:
        return 'initializing';
        break;
      case ARTrackingStateReason.relocalizing:
        return 'relocalizing';
        break;
      default:
        return '';
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          trackingStateText(),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          reasonText(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.onCameraDidChangeTrackingState = (trackingState, reason) {
      setState(() {
        this.trackingState = trackingState;
        if (trackingState == ARTrackingState.limited) {
          this.trackingStateReason = reason;
        } else {
          this.trackingStateReason = null;
        }
      });
    };
  }
}
