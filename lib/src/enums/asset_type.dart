/// Describes the location of the asset.
enum AssetType {
  /// Flutter asset folder (e.g. ./assets/gltf)
  /// See https://docs.flutter.dev/ui/assets/assets-and-images#specifying-assets
  flutterAsset,

  /// Documents folder for the current app
  /// This might be useful for downloading files from the internet
  documents,
}
