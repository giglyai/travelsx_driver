import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      isPortrait = true;
      if (_screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      isPortrait = false;
      isMobilePortrait = false;
    }

    textMultiplier = 1.sp;
    imageSizeMultiplier = 1;
    heightMultiplier = 1.h;
    widthMultiplier = 1.w;
  }
}
