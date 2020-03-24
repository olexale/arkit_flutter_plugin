/// Constants for ARKit lightingModel
///  For every lighting model, the final color is computed as follows:
///    finalColor = (<emission> + color + <reflective>) * <multiply>
///  where
///    <emission> — The 'emission' property of the SCNMaterial instance
///    <reflective> — The 'reflective' property of the SCNMaterial instance
///    <multiply> — The 'multiply' property of the SCNMaterial instance
///  and
///    color - The 'color' term depends on the lighting models described below
enum ARKitLightingModel {
  /// Produces a specularly shaded surface where the specular reflection is shaded according the Phong BRDF approximation.
  ///    The reflected color is calculated as:
  ///      color = <ambient> * al + <diffuse> * max(N ⋅ L, 0) + <specular> * pow(max(R ⋅ E, 0), <shininess>)
  ///    where
  ///      al — Sum of all ambient lights currently active (visible) in the scene
  ///      N — Normal vector
  ///      L — Light vector
  ///      E — Eye vector
  ///      R — Perfect reflection vector (reflect (L around N))
  ///    and
  ///      <ambient> — The 'ambient' property of the SCNMaterial instance
  ///      <diffuse> — The 'diffuse' property of the SCNMaterial instance
  ///      <specular> — The 'specular' property of the SCNMaterial instance
  ///      <shininess> — The 'shininess' property of the SCNMaterial instance
  phong,

  /// Produces a specularly shaded surface with a Blinn BRDF approximation.
  ///    The reflected color is calculated as:
  ///      color = <ambient> * al + <diffuse> * max(N ⋅ L, 0) + <specular> * pow(max(H ⋅ N, 0), <shininess>)
  ///    where
  ///      al — Sum of all ambient lights currently active (visible) in the scene
  ///      N — Normal vector
  ///      L — Light vector
  ///      E — Eye vector
  ///      H — Half-angle vector, calculated as halfway between the unit Eye and Light vectors, using the equation H = normalize(E + L)
  ///    and
  ///      <ambient> — The 'ambient' property of the SCNMaterial instance
  ///      <diffuse> — The 'diffuse' property of the SCNMaterial instance
  ///      <specular> — The 'specular' property of the SCNMaterial instance
  ///      <shininess> — The 'shininess' property of the SCNMaterial instance
  blinn,

  /// Produces a diffuse shaded surface with no specular reflection.
  ///    The result is based on Lambert’s Law, which states that when light hits a rough surface, the light is reflected in all directions equally.
  ///    The reflected color is calculated as:
  ///      color = <ambient> * al + <diffuse> * max(N ⋅ L, 0)
  ///    where
  ///      al — Sum of all ambient lights currently active (visible) in the scene
  ///      N — Normal vector
  ///      L — Light vector
  ///    and
  ///      <ambient> — The 'ambient' property of the SCNMaterial instance
  ///      <diffuse> — The 'diffuse' property of the SCNMaterial instance
  lambert,

  /// Produces a constantly shaded surface that is independent of lighting.
  ///    The reflected color is calculated as:
  ///      color = <ambient> * al + <diffuse>
  ///    where
  ///      al — Sum of all ambient lights currently active (visible) in the scene
  ///    and
  ///      <ambient> — The 'ambient' property of the SCNMaterial instance
  ///      <diffuse> — The 'diffuse' property of the SCNMaterial instance
  constant,

  /// Shading based on a realistic abstraction of physical lights and materials.
  physicallyBased,

  /// iOS 13 only (switches to blinn on older OSes)
  shadowOnly,
}
