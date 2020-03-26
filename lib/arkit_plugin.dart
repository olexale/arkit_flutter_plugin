export 'package:arkit_plugin/arkit_node.dart';
export 'package:arkit_plugin/arkit_reference_node.dart';
export 'package:arkit_plugin/geometries/arkit_anchor.dart';
export 'package:arkit_plugin/geometries/arkit_box.dart';
export 'package:arkit_plugin/geometries/arkit_capsule.dart';
export 'package:arkit_plugin/geometries/arkit_cone.dart';
export 'package:arkit_plugin/geometries/arkit_cylinder.dart';
export 'package:arkit_plugin/geometries/arkit_face.dart';
export 'package:arkit_plugin/geometries/arkit_geometry.dart';
export 'package:arkit_plugin/geometries/arkit_line.dart';
export 'package:arkit_plugin/geometries/arkit_plane.dart';
export 'package:arkit_plugin/geometries/arkit_pyramid.dart';
export 'package:arkit_plugin/geometries/arkit_sphere.dart';
export 'package:arkit_plugin/geometries/arkit_text.dart';
export 'package:arkit_plugin/geometries/arkit_torus.dart';
export 'package:arkit_plugin/geometries/arkit_tube.dart';
export 'package:arkit_plugin/geometries/material/arkit_blend_mode.dart';
export 'package:arkit_plugin/geometries/material/arkit_color_mask.dart';
export 'package:arkit_plugin/geometries/material/arkit_cull_mode.dart';
export 'package:arkit_plugin/geometries/material/arkit_fill_mode.dart';
export 'package:arkit_plugin/geometries/material/arkit_lighting_model.dart';
export 'package:arkit_plugin/geometries/material/arkit_material.dart';
export 'package:arkit_plugin/geometries/material/arkit_material_property.dart';
export 'package:arkit_plugin/geometries/material/arkit_transparency_mode.dart';
export 'package:arkit_plugin/hit/arkit_hit_test_result.dart';
export 'package:arkit_plugin/hit/arkit_hit_test_result_type.dart';
export 'package:arkit_plugin/hit/arkit_node_pan_result.dart';
export 'package:arkit_plugin/hit/arkit_node_pinch_result.dart';
export 'package:arkit_plugin/hit/arkit_node_rotation_result.dart';
export 'package:arkit_plugin/light/arkit_light.dart';
export 'package:arkit_plugin/light/arkit_light_estimate.dart';
export 'package:arkit_plugin/light/arkit_light_type.dart';
export 'package:arkit_plugin/physics/arkit_physics_body.dart';
export 'package:arkit_plugin/physics/arkit_physics_body_type.dart';
export 'package:arkit_plugin/physics/arkit_physics_shape.dart';
export 'package:arkit_plugin/widget/arkit_arplane_detection.dart';
export 'package:arkit_plugin/widget/arkit_configuration.dart';
export 'package:arkit_plugin/widget/arkit_scene_view.dart';
export 'package:arkit_plugin/widget/arkit_reference_image.dart';
export 'package:arkit_plugin/widget/arkit_world_alignment.dart';

import 'package:arkit_plugin/widget/arkit_configuration.dart';
import 'package:flutter/services.dart';

class ARKitPlugin {
  static const MethodChannel _channel = MethodChannel('arkit_configuration');

  ARKitPlugin._();

  static Future<bool> checkConfiguration(ARKitConfiguration configuration) {
    return _channel.invokeMethod<bool>('checkConfiguration', {
      'configuration': configuration.index,
    });
  }
}
