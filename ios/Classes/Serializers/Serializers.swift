import ARKit

func serializeArray(_ array: simd_float2) -> [Float] {
  return [array[0], array[1]]
}

func serializeArray(_ array: simd_float3) -> [Float] {
  return [array[0], array[1], array[2]]
}

func serializeArray(_ array: simd_float4) -> [Float] {
  return [array[0], array[1], array[2], array[3]]
}

func serializeVector(_ vector: SCNVector3) -> [Float] {
  return [vector.x, vector.y, vector.z]
}

func serializeMatrix(_ matrix: simd_float4x4) -> [Float] {
  return [matrix.columns.0, matrix.columns.1, matrix.columns.2, matrix.columns.3].flatMap { serializeArray($0) }
}
