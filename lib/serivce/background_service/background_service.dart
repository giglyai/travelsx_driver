import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_background_service_ios/flutter_background_service_ios.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/flavors.dart';


Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
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

  Timer.periodic(const Duration(minutes: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("forground service running");
        await HomeCubit().postUserCurrentLocation(source: "bg_service");

        String title;

        if (F.appFlavor == Flavor.bmdriver) {
          title = "BM Driver";
        } else if (F.appFlavor == Flavor.oorugodriver) {
          title = "Oorugo Driver";
        } else if (F.appFlavor == Flavor.prithvidriver) {
          title = "Prithvi Driver";
        } else if (F.appFlavor == Flavor.jppdriver) {
          title = "JPP Driver";
        } else if (F.appFlavor == Flavor.giglyaidriver) {
          title = "Gigly Driver";
        } else {
          title = "Gigly Driver";
        }

        service.setForegroundNotificationInfo(title: title, content: "Running");
      } else {
        print("background service running");
        String title;
        if (F.appFlavor == Flavor.bmdriver) {
          title = "BM Driver";
        } else if (F.appFlavor == Flavor.oorugodriver) {
          title = "Oorugo Driver";
        } else if (F.appFlavor == Flavor.prithvidriver) {
          title = "Prithvi Driver";
        } else if (F.appFlavor == Flavor.jppdriver) {
          title = "JPP Driver";
        } else if (F.appFlavor == Flavor.giglyaidriver) {
          title = "Gigly Driver";
        } else {
          title = "Gigly Driver";
        }

        service.setForegroundNotificationInfo(title: title, content: "Running");
        await HomeCubit().postUserCurrentLocation(source: "bg_service");
        // service.setForegroundNotificationInfo(
        //     title: F.appFlavor == Flavor.bmdriver
        //         ? "BM Driver Service"
        //         : F.appFlavor == Flavor.oorugodriver
        //             ? "Oorugo Driver Service"
        //             : F.appFlavor == Flavor.prithvidriver
        //                 ? "Prithvi Driver"
        //                 : F.appFlavor == Flavor.jppdriver
        //                     ? "JPP Driver"
        //                     : "Gigly Driver",
        //     content: "Running");
        // await HomeCubit().postUserCurrentLocation(source: "bg_service");
      }
    } else if (service is IOSServiceInstance) {
      print("iOS background service is running");
      await HomeCubit().postUserCurrentLocation(source: "bg_service");
    }
    service.invoke('update');
  });
}
