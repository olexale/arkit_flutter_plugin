import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

ARKitNode createSphere() => ARKitNode(
      geometry:
          ARKitSphere(materials: createRandomColorMaterial(), radius: 0.04),
      position: vector.Vector3(-0.1, -0.1, -0.5),
    );

List<ARKitMaterial> createRandomColorMaterial() {
  return [
    ARKitMaterial(
      lightingModelName: ARKitLightingModel.physicallyBased,
      diffuse: ARKitMaterialProperty.color(
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      ),
    )
  ];
}
