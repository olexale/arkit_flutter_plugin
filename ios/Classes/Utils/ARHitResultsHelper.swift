import ARKit

func getARHitResultsArray(_ sceneView: ARSCNView, atLocation location: CGPoint) -> Array<Dictionary<String, Any>>{
    let arHitResults = getARHitResults(sceneView, atLocation: location)
    let results = convertHitResultsToArray(arHitResults)
    return results
}

fileprivate func getARHitResults(_ sceneView: ARSCNView, atLocation location: CGPoint) -> Array<ARHitTestResult> {
    var types = ARHitTestResult.ResultType(
        [.featurePoint, .estimatedHorizontalPlane, .existingPlane, .existingPlaneUsingExtent])
    
    if #available(iOS 11.3, *) {
        types.insert(.estimatedVerticalPlane)
        types.insert(.existingPlaneUsingGeometry)
    }
    let results = sceneView.hitTest(location, types: types)
    return results
}

fileprivate func convertHitResultsToArray(_ array : Array<ARHitTestResult>)  -> Array<Dictionary<String, Any>> {
    return array.map {getDictFromHitResult($0) }
}

fileprivate func getDictFromHitResult(_ result: ARHitTestResult) -> Dictionary<String, Any> {
    
    var dict = Dictionary<String, Any>(minimumCapacity: 4)
    dict["type"] = result.type.rawValue
    dict["distance"] = result.distance
    dict["localTransform"] = serializeMatrix(result.localTransform)
    dict["worldTransform"] = serializeMatrix(result.worldTransform)
    
    if let anchor = result.anchor {
        dict["anchor"] = serializeAnchor(anchor)
    }
    
    return dict
}
