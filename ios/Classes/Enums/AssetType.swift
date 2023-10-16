enum AssetType {
    case flutterAsset // Flutter asset folder (e.g. ./example/assets/gltf), path should be added to pubspec.yaml
    case documents // Documents folder for the current app
    
    static func from(index: Int) -> AssetType {
        if(index == 0){
            return .flutterAsset
        }else{
            return .documents
        }
    }
}
