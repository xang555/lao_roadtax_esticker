import 'package:flutter/services.dart';

import 'const.dart';

/// calculate dx alight center point
double dXCenter({
  required double dx,
  required double maxLayoutWidth,
  required double paintWidth,
}) =>
    dx + (maxLayoutWidth - paintWidth) / 2;

/// calculate dy alight center point
double dYCenter({
  required double dy,
  required double maxLayoutHight,
  required double paintHight,
}) =>
    dy + (maxLayoutHight - paintHight) / 2;

/// calculate offset conner point of rect
Offset offsetConnerRect({
  required Offset center,
  required double width,
  required double hight,
}) {
  final dx = center.dx - width / 2;
  final dy = center.dy - hight / 2;
  return Offset(dx, dy);
}

/// cal refactor
double calRefactor({required double width, required double hight}) =>
    (width / hight);

/// cal scale x value
double calScaleX({required double x, required double refactor}) =>
    (refactor * x / baseTemplateRefactor);
