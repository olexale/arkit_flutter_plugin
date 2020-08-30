import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

Matrix4 createTransformMatrix(Matrix4 origin, Vector3 position, Vector3 scale,
    Vector4 rotation, Vector3 eulerAngles) {
  final transform = origin ?? Matrix4.identity();

  if (position != null) {
    transform.setTranslation(position);
  }
  if (rotation != null) {
    transform.rotate(
        Vector3(rotation[0], rotation[1], rotation[2]), rotation[3]);
  }
  if (eulerAngles != null) {
    transform.matrixEulerAngles = eulerAngles;
  }
  if (scale != null) {
    transform.scale(scale);
  } else {
    transform.scale(1.0);
  }
  return transform;
}

extension Matrix4Extenstion on Matrix4 {
  Vector3 get matrixScale {
    final scale = Vector3.zero();
    decompose(Vector3.zero(), Quaternion(0, 0, 0, 0), scale);
    return scale;
  }

  Vector3 get matrixEulerAngles {
    final q = Quaternion(0, 0, 0, 0);
    decompose(Vector3.zero(), q, Vector3.zero());

    final t = q.x;
    q.x = q.y;
    q.y = t;

    final angles = Vector3.zero();

    // roll (x-axis rotation)
    final sinr_cosp = 2 * (q.w * q.x + q.y * q.z);
    final cosr_cosp = 1 - 2 * (q.x * q.x + q.y * q.y);
    angles[0] = math.atan2(sinr_cosp, cosr_cosp);

    // pitch (y-axis rotation)
    final sinp = 2 * (q.w * q.y - q.z * q.x);
    if (sinp.abs() >= 1) {
      angles[1] =
          _copySign(math.pi / 2, sinp); // use 90 degrees if out of range
    } else {
      angles[1] = math.asin(sinp);
    }
    // yaw (z-axis rotation)
    final siny_cosp = 2 * (q.w * q.z + q.x * q.y);
    final cosy_cosp = 1 - 2 * (q.y * q.y + q.z * q.z);
    angles[2] = math.atan2(siny_cosp, cosy_cosp);

    return angles;
  }

  set matrixEulerAngles(Vector3 angles) {
    final translation = Vector3.zero();
    final scale = Vector3.zero();
    decompose(translation, Quaternion(0, 0, 0, 0), scale);
    final r = Quaternion.euler(angles[0], angles[1], angles[2]);
    setFromTranslationRotationScale(translation, r, scale);
  }
}

// https://scidart.org/docs/scidart/numdart/copySign.html
double _copySign(double magnitude, double sign) {
  // The highest order bit is going to be zero if the
  // highest order bit of m and s is the same and one otherwise.
  // So (m^s) will be positive if both m and s have the same sign
  // and negative otherwise.
  /*final long m = Double.doubleToRawLongBits(magnitude); // don't care about NaN
  final long s = Double.doubleToRawLongBits(sign);
  if ((m^s) >= 0) {
      return magnitude;
  }
  return -magnitude; // flip sign*/
  if (sign == 0.0 || sign.isNaN || magnitude.sign == sign.sign) {
    return magnitude;
  }
  return -magnitude; // flip sign
}
