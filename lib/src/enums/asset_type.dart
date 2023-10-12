enum AssetType {
  flutterAsset, // Flutter asset folder (e.g. ./example/assets/gltf), path should be added to pubspec.yaml
  documents, // Documents folder for the current app
  scnassets, // Default (./example/ios/Runner/models.scnassets), files must be added before building in Xcode.
}
