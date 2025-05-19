// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/location_permission/location_permission.dart';
import 'package:travelx_driver/shared/constants/imagePath/jpdriver/jp_image_paths.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/user/serivce/firebase_notification.dart';

import '../shared/constants/app_colors/app_colors.dart';
import '../shared/constants/imagePath/image_paths.dart';
import '../shared/local_storage/auth_repository.dart';
import '../shared/local_storage/log_in_status.dart';
import '../shared/local_storage/user_repository.dart';
import '../shared/utils/image_loader/image_loader.dart';
import '../shared/widgets/size_config/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  StreamSubscription? subscription;

  startservice() async {}

  @override
  void initState() {
    LocationPermissionHandler().requestLocationPermission();

    FireBaseApi().initNotification();
    //PhonePayInit().phonePayInit();
    // getUserCurrentLocation();
    startservice();
    AuthRepository.instance.init();
    UserRepository.instance.init();
    Future.delayed(const Duration(seconds: 4, milliseconds: 500), () async {
      //Navigator.of(context).pushReplacementNamed(RouteName.onBoardingScreen);
      checkLogInStatus();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Center(
        child: Builder(
          builder: (context) {
            if (F.appFlavor == Flavor.kurinjidriver) {
              return ImageLoader.assetImage(
                imagePath: ImagePath.splashKurinjiIcon,
                height: 200 * SizeConfig.heightMultiplier!,
                width: 196 * SizeConfig.widthMultiplier!,
              );
            } else if (F.appFlavor == Flavor.travelsxdriver) {
              return ImageLoader.assetImage(
                imagePath: ImagePath.splashTravelsxIcon,
                height: 200 * SizeConfig.heightMultiplier!,
                width: 196 * SizeConfig.widthMultiplier!,
              );
            } else {
              return ImageLoader.assetImage(
                imagePath: JpImagePath.splashIcon,
                height: 110 * SizeConfig.heightMultiplier!,
                width: 196 * SizeConfig.widthMultiplier!,
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> checkLogInStatus() async {
    LogInStatus check = LogInStatus();
    bool isLoggedIn = await check.checkLoginStatus();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, RouteName.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.mobileLoginScreen);
    }
  }

  InternetConnectionStatus isDeviceConnected =
      InternetConnectionStatus.disconnected;

  getConnectivity() async {
    // isDeviceConnected = await InternetConnectionChecker().connectionStatus;
    // if (isDeviceConnected == InternetConnectionStatus.disconnected) {
    //   BuildContext context = navigatorKey.currentState!.context;
    //   Future.delayed(const Duration(seconds: 4), () async {
    //     Navigator.pushNamed(context, RouteName.noConnection);
    //   });
    // }
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) async {
    //   isDeviceConnected = await InternetConnectionChecker().connectionStatus;
    //   if (isDeviceConnected == InternetConnectionStatus.disconnected) {
    //     BuildContext context = navigatorKey.currentState!.context;
    //     Navigator.pushNamed(context, RouteName.noConnection);
    //   }
    // });
  }
}
