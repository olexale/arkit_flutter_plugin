import Foundation

func getImageByName(_ name: String) -> UIImage? {
    if let img = UIImage(named: name) {
        return img
    }
    if let path = Bundle.main.path(forResource: SwiftArkitPlugin.registrar!.lookupKey(forAsset: name), ofType: nil) {
        return UIImage(named: path)
    }
    do {
        let data = try Data.init(contentsOf: URL.init(string: name)!)
        return UIImage(data: data)
    } catch {
        
    }
    return nil
}
