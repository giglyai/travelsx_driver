import 'package:flutter/material.dart';

import 'custom_button_clipper.dart';
import 'size_config/size_config.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier!),
                    color: Colors.white,
                    height: 300 * SizeConfig.heightMultiplier!,
                  ),
                ),
                SizedBox(
                  height: 320 * SizeConfig.heightMultiplier!,
                  width: 150 * SizeConfig.widthMultiplier!,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 7 * SizeConfig.widthMultiplier!,
                            bottom: 10 * SizeConfig.heightMultiplier!),
                        height: 40 * SizeConfig.heightMultiplier!,
                        width: 133 * SizeConfig.widthMultiplier!,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(180 / 360),
                          child: ClipPath(
                            clipper: CustomButtonClipper(),
                            child: Container(
                              color: Colors.white,
                              height: 300 * SizeConfig.heightMultiplier!,
                              width: 170 * SizeConfig.widthMultiplier!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier!),
                    color: Colors.white,
                    height: 300 * SizeConfig.heightMultiplier!,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
