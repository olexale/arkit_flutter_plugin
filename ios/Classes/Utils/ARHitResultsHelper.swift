import ARKit

func getARHitResultsArray(_ sceneView: ARSCNView, atLocation location: CGPoint) -> [[String: Any]] {
  let arHitResults = getARHitResults(sceneView, atLocation: location)
  let results = convertHitResultsToArray(arHitResults)
  return results
}

private func getARHitResults(_ sceneView: ARSCNView, atLocation location: CGPoint) -> [ARHitTestResult] {
  var types = ARHitTestResult.ResultType(
    [.featurePoint, .estimatedHorizontalPlane, .existingPlane, .existingPlaneUsingExtent])
  
  if #available(iOS 11.3, *) {
    types.insert(.estimatedVerticalPlane)
    types.insert(.existingPlaneUsingGeometry)
  }
  let results = sceneView.hitTest(location, types: types)
  return results
}

private func convertHitResultsToArray(_ array: [ARHitTestResult]) -> [[String: Any]] {
  return array.map { getDictFromHitResult($0) }
}

private func getDictFromHitResult(_ result: ARHitTestResult) -> [String: Any] {
  var dict = [String: Any](minimumCapacity: 4)
  dict["type"] = result.type.rawValue
  dict["distance"] = result.distance
  dict["localTransform"] = serializeMatrix(result.localTransform)
  dict["worldTransform"] = serializeMatrix(result.worldTransform)
  
  if let anchor = result.anchor {
    dict["anchor"] = serializeAnchor(anchor)
  }
  
  return dict
}
