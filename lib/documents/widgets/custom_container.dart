import 'package:flutter/material.dart';

import '../../shared/constants/app_colors/app_colors.dart';
import '../../shared/widgets/size_config/size_config.dart';

class DocumentCard extends StatelessWidget {
  String? title;
  String? imagePath;
  String? subTitle;
  double? height;
  double? width;
  bool wantFontSize;
  bool? wantIcon;
  DocumentCard({
    Key? key,
    this.title,
    this.imagePath,
    this.wantFontSize = false,
    this.width,
    this.height,
    this.subTitle,
    this.wantIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 21 * SizeConfig.widthMultiplier!,
          right: 11 * SizeConfig.widthMultiplier!),
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.kGreyE2ED.withOpacity(0.60),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
          )
        ],
      ),
    );
  }
}
