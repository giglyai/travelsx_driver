import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:travelx_driver/core/remote_config/default_remote_data.dart';
import 'package:travelx_driver/core/remote_config/dynamic_number_format.dart';
import 'package:travelx_driver/core/remote_dynamic_data/remote_button_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteConfigHelper {
  RemoteConfigHelper._(); // Private default constructor

  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await _remoteConfig.setDefaults(defaultValues);
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(
            minutes: kReleaseMode ? 30 : 1,
          ),
        ),
      );
      await _remoteConfig.fetch();
      await _remoteConfig.fetchAndActivate();
      //setRemoteData(jsonDecode(getString("button_status")));
      storeGoogleMapsApiKey(_remoteConfig.getString("google_maps_api_key"));
      // setRemoteNumberFormat(jsonDecode(getString("number_formats")));
    } on PlatformException catch (e, stackTrace) {
      await _remoteConfig.setDefaults(defaultValues);
      setRemoteData(defaultValues);
      setRemoteNumberFormat(defaultValues);
    } catch (e, stackTrace) {
      await _remoteConfig.setDefaults(defaultValues);
      setRemoteData(defaultValues);
      setRemoteNumberFormat(defaultValues);
    }
  }

  static String getString(String key) {
    return _remoteConfig.getString(key);
  }

  static void setRemoteData(Map<String, dynamic> buttonData) {
    RemoteButtonStatus.init(buttonData);
  }

  static void setRemoteNumberFormat(Map<String, dynamic> numberData) {
    DynamicNumberFormat.init(numberData);
  }

  static Future<void> storeGoogleMapsApiKey(apiKey) async {
    try {
      if (apiKey.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('google_maps_api_key', apiKey);
        const platform = MethodChannel('api_channel');
        await platform.invokeMethod('setApiKey', {"apiKey": apiKey});
        print("API Key saved: $apiKey");
      }
    } catch (e) {
      print("Failed to fetch API key: $e");
    }
  }
}
