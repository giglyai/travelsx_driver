// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CustomBackButton extends StatelessWidget {
  BuildContext parentContext;
  CustomBackButton({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 22 * SizeConfig.heightMultiplier!,
          left: 26 * SizeConfig.widthMultiplier!),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 43 * SizeConfig.widthMultiplier!,
          height: 42 * SizeConfig.heightMultiplier!,
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.kBlackTextColor.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 0.5,
                      offset: const Offset(0, 2))
                ]),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shadowColor: MaterialStateProperty.all(
                    AppColors.kBlackTextColor.withOpacity(0.25)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.pop(parentContext);
              },
              child: Center(
                  child: Icon(
                CupertinoIcons.left_chevron,
                size: 20 * SizeConfig.imageSizeMultiplier!,
                color: AppColors.kBlue3D6,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
