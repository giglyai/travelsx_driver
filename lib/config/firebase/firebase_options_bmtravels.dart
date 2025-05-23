// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class FirebaseOptionsBMTravels {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMhukYV2dF6te8T8fLLNYQAwtI368uf9A',
    appId: '1:332682699816:web:5d4810d66f9022ea52411d',
    messagingSenderId: '332682699816',
    projectId: 'bm-travels-driver',
    authDomain: 'bm-travels-driver.firebaseapp.com',
    storageBucket: 'bm-travels-driver.appspot.com',
    measurementId: 'G-2T0R7QNH12',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAE1yVGcCSt6-f-pACa5B0ISzw-VQC1MSU',
    appId: '1:332682699816:android:786be3237b7bfde052411d',
    messagingSenderId: '332682699816',
    projectId: 'bm-travels-driver',
    storageBucket: 'bm-travels-driver.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-HWtQ5Q9vkrGQ1YV1cm6V_w3xh1tA-V0',
    appId: '1:332682699816:ios:3bd84b8c8de276a052411d',
    messagingSenderId: '332682699816',
    projectId: 'bm-travels-driver',
    storageBucket: 'bm-travels-driver.appspot.com',
    iosBundleId: 'com.byteplace.gigly.driver.ride',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-HWtQ5Q9vkrGQ1YV1cm6V_w3xh1tA-V0',
    appId: '1:332682699816:ios:6fef3fe934f17aa752411d',
    messagingSenderId: '332682699816',
    projectId: 'bm-travels-driver',
    storageBucket: 'bm-travels-driver.appspot.com',
    iosBundleId: 'com.example.silkrouteFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMhukYV2dF6te8T8fLLNYQAwtI368uf9A',
    appId: '1:332682699816:web:ea6f54e68fd3b19e52411d',
    messagingSenderId: '332682699816',
    projectId: 'bm-travels-driver',
    authDomain: 'bm-travels-driver.firebaseapp.com',
    storageBucket: 'bm-travels-driver.appspot.com',
    measurementId: 'G-QJC3ZB57DH',
  );
}
