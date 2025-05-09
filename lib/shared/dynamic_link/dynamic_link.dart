import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../routes/named_routes.dart';


class DynamicLinkHandler {
  static final DynamicLinkHandler _singleton = DynamicLinkHandler._internal();

  factory DynamicLinkHandler() => _singleton;

  StreamSubscription? subscription;

  DynamicLinkHandler._internal() {
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    await Firebase.initializeApp();

    // Listen for the initial link when the app is opened.
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      handleDynamicLink(initialLink);
    }

    // Listen for dynamic links when the app is in the background or foreground.
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData);
    });
  }

  void handleDynamicLink(PendingDynamicLinkData dynamicLinkData) {
    final Uri deepLink = dynamicLinkData.link;
    final queryParams = deepLink.queryParameters;
    if (queryParams.isNotEmpty == true) {
      String? orderProviderId = queryParams["driver"];
      Navigator.pushReplacementNamed(
        navigatorKey.currentState!.context,
        RouteName.homeScreen
      );
    }
  }

  static DynamicLinkHandler get instance => _singleton;
}
