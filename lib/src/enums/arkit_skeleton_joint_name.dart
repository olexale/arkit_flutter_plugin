enum ARKitSkeletonJointName {
  root,
  head,
  leftHand,
  rightHand,
  leftFoot,
  rightFoot,
  leftShoulder,
  rightShoulder,
}

extension ARKitSkeletonJointNameX on ARKitSkeletonJointName {
  String toJointNameString() => toString().split('.').last;
}
