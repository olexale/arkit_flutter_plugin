import 'package:arkit_plugin/src/widget/arkit_configuration.dart';
import 'package:flutter/services.dart';

class ARKitPlugin {
  static const MethodChannel _channel = MethodChannel('arkit_configuration');

  ARKitPlugin._();

  static Future<bool> checkConfiguration(ARKitConfiguration configuration) {
    return _channel.invokeMethod<bool>('checkConfiguration', {
      'configuration': configuration.index,
    }).then((value) => value!);
  }
}
