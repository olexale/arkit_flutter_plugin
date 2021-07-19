import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

class CheckSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Check ARKit Support Sample'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              ARKitConfiguration.values.map((e) => showSupport(e)).toList(),
        ),
      );

  Widget showSupport(ARKitConfiguration configuration) {
    return Row(children: [
      Text(configuration.toString()),
      FutureBuilder<bool>(
          future: ARKitPlugin.checkConfiguration(configuration),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return Text(' loading');
            }
            return Text(data ? ' supported' : ' not supported');
          })
    ]);
  }
}
