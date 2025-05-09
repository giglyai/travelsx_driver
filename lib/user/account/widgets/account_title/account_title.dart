import 'package:flutter/material.dart';

import '../../../../shared/constants/app_colors/app_colors.dart';
import '../../../../shared/widgets/size_config/size_config.dart';

class AccountTitle extends StatelessWidget {
  AccountTitle({Key? key, this.title, this.onTap}) : super(key: key);

  VoidCallback? onTap;
  String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 40 * SizeConfig.heightMultiplier!),
            child: Text(
              title ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20 * SizeConfig.textMultiplier!,
                color: AppColors.kBlackTextColor.withOpacity(0.70),
              ),
            ),
          ),
        ));
  }
}
