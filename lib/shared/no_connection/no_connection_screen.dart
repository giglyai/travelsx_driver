import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:travelx_driver/shared/constants/app_styles/app_styles.dart';

import '../constants/imagePath/image_paths.dart';
import '../utils/image_loader/image_loader.dart';
import '../widgets/buttons/button_with_icon.dart';
import '../widgets/size_config/size_config.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isDeviceConnected =
            await InternetConnectionChecker.instance.hasConnection;
        return isDeviceConnected == InternetConnectionStatus.connected;
      },
      child: Scaffold(resizeToAvoidBottomInset: false, body: NoConnections()),
    );
  }
}

class NoConnections extends StatefulWidget {
  const NoConnections({Key? key}) : super(key: key);

  @override
  State<NoConnections> createState() => _NoConnectionsState();
}

class _NoConnectionsState extends State<NoConnections> {
  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  late StreamSubscription subscription;
  InternetConnectionStatus isDeviceConnected =
      InternetConnectionStatus.disconnected;

  getConnectivity() async {
    // isDeviceConnected = await InternetConnectionChecker().connectionStatus;
    // if (isDeviceConnected == InternetConnectionStatus.connected) {
    //   Navigator.pop(context);
    // }
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) async {
    //   isDeviceConnected = await InternetConnectionChecker().connectionStatus;
    //   if (isDeviceConnected == InternetConnectionStatus.connected) {
    //     Navigator.pop(context);
    //   }
    // });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 196 * SizeConfig.heightMultiplier!),
          ImageLoader.svgPictureAssetImage(
            width: 160 * SizeConfig.widthMultiplier!,
            height: 160 * SizeConfig.heightMultiplier!,
            imagePath: ImagePath.noConnectionImage,
          ),
          SizedBox(height: 30 * SizeConfig.heightMultiplier!),
          Text(
            'Ooops!',
            textAlign: TextAlign.center,
            style: AppTextStyle.text18black0000W600,
          ),
          SizedBox(height: 20 * SizeConfig.heightMultiplier!),
          Text(
            'No internet connection found check your \nconnection',
            textAlign: TextAlign.center,
            style: AppTextStyle.text14FullBlack0000W400?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 60 * SizeConfig.heightMultiplier!),
          BLueButtonWithIcon(
            borderRadius: 4 * SizeConfig.widthMultiplier!,
            height: 60 * SizeConfig.heightMultiplier!,
            imagePath: ImagePath.settingIcon,
            title: "Open Setting",
            onTap: () {
              //AppSettings.openWirelessSettings();
            },
          ),
        ],
      ),
    );
  }
}
