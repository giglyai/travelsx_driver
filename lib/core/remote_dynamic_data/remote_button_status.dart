import 'package:travelx_driver/core/remote_config/default_remote_data.dart';

class RemoteButtonStatus {
  static bool? isInventoryTabAvailable;

  static List<String>? notificationTopics;

  RemoteButtonStatus._();

  static void init(Map<String, dynamic> buttonStatus) {
    isInventoryTabAvailable = buttonStatus["isInventoryTabAvailable"];
    final List<dynamic> tempNotificationsTopics =
        buttonStatus["notificationTopics"]?.isNotEmpty == true
            ? buttonStatus["notificationTopics"]
            : defaultNotificationTopics;
    notificationTopics = List<String>.from(tempNotificationsTopics);
  }
}
