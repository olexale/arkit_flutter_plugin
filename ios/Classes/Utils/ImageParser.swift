import Foundation

func getImageByName(_ name: String) -> UIImage? {
    if let img = UIImage(named: name) {
        return img
    }
    if let path = Bundle.main.path(forResource: SwiftArkitPlugin.registrar!.lookupKey(forAsset: name), ofType: nil) {
        return UIImage(named: path)
    }
    if let url = URL.init(string: name) {
      do {
        let data = try Data.init(contentsOf: url)
        return UIImage(data: data)
      } catch {
          
      }
    }
    if let base64 = Data(base64Encoded: name, options: .ignoreUnknownCharacters) {
        return UIImage(data: base64)
    }
    return nil
}
