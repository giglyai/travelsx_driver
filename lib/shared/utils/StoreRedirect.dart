import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../../flavors.dart';

class StoreRedirect {
  static void openStore() {
    if (F.appFlavor == Flavor.giglyaidriver) {
      launchUrl(
          Uri.parse(Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=" +
                  "com.byteplace.gigly.driver.ride"
              : 'https://apps.apple.com/in/app/giglyai-driver/id6502331194'),
          mode: LaunchMode.externalApplication);
    } else if (F.appFlavor == Flavor.oorugodriver) {
      launchUrl(
          Uri.parse(Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=" +
                  "com.byteplace.gigly.driver.ride.bmtravels"
              : 'https://apps.apple.com/in/app/giglyai-driver/id6502331194'),
          mode: LaunchMode.externalApplication);
    } else if (F.appFlavor == Flavor.bmdriver) {
      launchUrl(
          Uri.parse(Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=" +
                  "com.byteplace.gigly.driver.ride.bmtravels"
              : 'https://apps.apple.com/in/app/giglyai-driver/id6502331194'),
          mode: LaunchMode.externalApplication);
    }
  }
}
