import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/flavors.dart';

// Future<void> initializeBackgroundService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       isForegroundMode: true,
//       autoStart: true,
//     ),
//   );
// }

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'travelsx_driver_channel',
      //initialNotificationTitle: 'TravelsX Driver Running',
      initialNotificationContent: 'Tap to return to the app',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("forground service running");
        await HomeCubit().postUserCurrentLocation(source: "bg_service");

        String title;

        if (F.appFlavor == Flavor.kurinjidriver) {
          title = "Kurinji Driver";
        } else if (F.appFlavor == Flavor.travelsxdriver) {
          title = "TravelsX Driver";
        } else {
          title = "TravelsX Driver";
        }

        service.setForegroundNotificationInfo(title: title, content: "Running");
      } else {
        print("background service running");
        String title;
        if (F.appFlavor == Flavor.kurinjidriver) {
          title = "Kurinji Driver";
        } else if (F.appFlavor == Flavor.travelsxdriver) {
          title = "TravelsX Driver";
        } else {
          title = "TravelsX Driver";
        }

        service.setForegroundNotificationInfo(title: title, content: "Running");
        await HomeCubit().postUserCurrentLocation(source: "bg_service");
      }
    } else if (service is IOSServiceInstance) {
      print("iOS background service is running");
      await HomeCubit().postUserCurrentLocation(source: "bg_service");
    }
    service.invoke('update');
  });
}
