

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/constants/app_styles/app_styles.dart';
import '../../shared/constants/imagePath/image_paths.dart';
import '../../shared/utils/image_loader/image_loader.dart';
import '../../shared/widgets/buttons/blue_button.dart';
import '../../shared/widgets/custom_sized_box/custom_sized_box.dart';
import '../../shared/widgets/ride_back_button/ride_back_button.dart';
import '../../shared/widgets/size_config/size_config.dart';

class ShareQrScreen extends StatelessWidget {
  const ShareQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RideBackButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20 * SizeConfig.heightMultiplier!,
                ),
                child: Center(
                  child: Text(
                    'QR code',
                    style: GoogleFonts.ubuntu(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              ImageLoader.assetImage(
                  imagePath: ImagePath.companyqr,
                  height: 451 * SizeConfig.heightMultiplier!,
                  width: 500 * SizeConfig.widthMultiplier!),
              CustomSizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  'UPI ID',
                  style: GoogleFonts.ubuntu(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              CustomSizedBox(
                height: 5,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Share.share('8946063573@okbizaxis',
                        subject: 'Gigly Sales App');
                  },
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "8946063573@okbizaxis",
                          style: AppTextStyle.text16black0000W500,
                        ),
                        CustomSizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.copy_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomSizedBox(
                height: 55,
              ),
              BlueButton(
                onTap: (){
                  Navigator.pop(context);
                },
                title: "Continue",
              )
            ],
          ),
        ],
      ),
    );
  }
}
