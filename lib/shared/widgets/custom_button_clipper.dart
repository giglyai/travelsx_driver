import 'package:flutter/material.dart';

import 'size_config/size_config.dart';

/// Clipper to Cut widget at the side
class CustomButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;

    double radius = 25;

    Path path = Path()
      ..lineTo(0, height)
      ..arcToPoint(Offset(25, height - 30 * SizeConfig.heightMultiplier!),
          radius: Radius.circular(radius))
      ..lineTo(width - 25, height - 30 * SizeConfig.heightMultiplier!)
      ..arcToPoint(Offset(width, height), radius: Radius.circular(radius))
      ..lineTo(width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
