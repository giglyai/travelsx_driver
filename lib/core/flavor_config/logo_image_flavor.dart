import 'package:flutter/widgets.dart';
import 'package:travelx_driver/shared/constants/imagePath/image_paths.dart';
import 'package:travelx_driver/shared/utils/image_loader/image_loader.dart';
import 'package:travelx_driver/shared/widgets/size_config/size_config.dart';

import '../../flavors.dart';

class LogoImageProvider {
  static Widget getSplashImage(Flavor flavor) {
    final double commonHeight = 200 * SizeConfig.heightMultiplier!;
    final double commonWidth = 196 * SizeConfig.widthMultiplier!;

    final Map<Flavor, Widget> splashImages = {
      Flavor.travelsxdriver: ImageLoader.assetImage(
        imagePath: ImagePath.logoTravelsx,
        height: commonHeight,
        width: commonWidth,
      ),
      Flavor.sreedroptaxidriver: ImageLoader.assetImage(
        imagePath: ImagePath.logoSreeDropTaxi,
        height: commonHeight,
        width: commonWidth,
      ),
      // Flavor.oorvandidriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.logoOorvandiDriver,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),
      // Flavor.kurinjidriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.splashKurinjiIcon,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),
      // Flavor.goguldriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.logoGogulDriver,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),
      // Flavor.uzhavandriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.logoUzhavanDriver,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),
      // Flavor.mayiltrackdriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.logoMayiltrackDriver,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),

      // Flavor.googultaxidriver: ImageLoader.assetImage(
      //   imagePath: ImagePath.logoGoogulTaxi,
      //   height: commonHeight,
      //   width: commonWidth,
      // ),
    };

    // Return matched image or fallback
    return splashImages[flavor] ??
        ImageLoader.svgPictureAssetImage(
          imagePath: ImagePath.giglyDriverSplashLogoFinal,
          height: 110 * SizeConfig.heightMultiplier!,
          width: commonWidth,
        );
  }
}
