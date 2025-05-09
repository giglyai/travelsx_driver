// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

import '../size_config/size_config.dart';

class CustomSizedBox extends StatelessWidget {
  CustomSizedBox({super.key, this.height, this.width});

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (height ?? 0.0) * SizeConfig.heightMultiplier!,
      width: (width ?? 0.0) * SizeConfig.widthMultiplier!,
    );
  }
}
