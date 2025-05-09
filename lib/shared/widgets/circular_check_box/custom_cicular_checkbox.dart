// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/imagePath/image_paths.dart';

class CustomCircularCheckBox extends StatelessWidget {
  /// this will return true false
  /// true for selectedImageIcon
  /// false for unSelectedIcon
  final bool isSelected;

  ///This will give image width and height equally
  double? width;

  ///this will give image color
  final Color? color;

  ///added gestureDetector so that we can make on tap call if it is button
  GestureTapCallback? onTap;

  CustomCircularCheckBox(
      {Key? key, required this.isSelected, this.width, this.color, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.scale(
        scale: 1.2,
        child: SvgPicture.asset(
          isSelected
              ? ImagePath.selectedCircleBox
              : ImagePath.unSelectedCircleBox,
          width: width,
          height: width,
          color: (isSelected == true) ? color : null,
        ),
      ),
    );
  }
}
