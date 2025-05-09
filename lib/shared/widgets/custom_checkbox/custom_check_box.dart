import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/imagePath/image_paths.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isSelected;
  final double? width;
  final Color? color;
  const CustomCheckBox(
      {Key? key, required this.isSelected, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isSelected ? ImagePath.selectedCheckBox : ImagePath.unSelectedCheckBox,
      width: width,
      height: width,
      color: (isSelected == true) ? color : null,
    );
  }
}
