import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:travelx_driver/config/firebase/firebase_options_kurinjidriver.dart';
import 'package:travelx_driver/config/firebase/firebase_options_travelsxdriver.dart';
import 'package:travelx_driver/core/remote_config/remote_config.dart';
import 'package:travelx_driver/documents/bloc/document_cubit.dart';
import 'package:travelx_driver/flavors.dart';
import 'package:travelx_driver/global_bloc.dart';
import 'package:travelx_driver/home/bloc/home_cubit.dart';
import 'package:travelx_driver/home/hire_driver_bloc/cubit/hire_driver_cubit.dart';
import 'package:travelx_driver/home/revamp/bloc/main_home_cubit.dart';
import 'package:travelx_driver/search-rides/screens/booking_registration/cubit/booking_registration_cubit.dart';
import 'package:travelx_driver/serivce/background_service/background_service.dart';
import 'package:travelx_driver/serivce/firebase_notification.dart';
import 'package:travelx_driver/shared/localization_part/local_string.dart';
import 'package:travelx_driver/shared/routes/named_routes.dart';
import 'package:travelx_driver/splash/splash_screen.dart';
import 'package:travelx_driver/user/account/bloc/account_cubit.dart';
import 'package:travelx_driver/user/account/screen/driver_account_details/bloc/driver_accounts_bloc.dart';
import 'package:travelx_driver/user/help_screen/domain/help_cubit.dart';
import 'package:travelx_driver/user/my_agency/bloc/my_agency_cubit.dart';
import 'package:travelx_driver/user/subscription/cubit/subscription_cubit.dart';
import 'package:travelx_driver/user/trip/equatable/trip_equatable.dart';
import 'package:travelx_driver/user/vehicle/bloc/add_vehicle_cubit.dart';

import 'login/bloc/login_cubit.dart';
import 'shared/widgets/size_config/size_config.dart';
import 'user/earning/bloc/earning_cubit.dart';
import 'user/notifications/bloc/notification_cubit.dart';
import 'user/promotions/bloc/promotion_cubit.dart';
import 'user/trip/bloc/trip_cubit.dart';
import 'user/wallet/bloc/wallet_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

Future<void> main({Flavor? flavor}) async {
  if (_initializedRendererCompleter?.isCompleted == false) {
    await initializeMapRenderer();
  }

  WidgetsFlutterBinding.ensureInitialized();

  if (flavor == Flavor.kurinjidriver) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: KurinjiDriverFirebaseOptions.currentPlatform,
      );
    }
  }
  if (flavor == Flavor.travelsxdriver) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: TravelsXDriverFirebaseOptions.currentPlatform,
      );
    }
  }

  await RemoteConfigHelper.init();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // optional
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // optional
    ),
  );

  _initializeMapsApiFromRemote();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Bloc.observer = GlobalBlocObserver();

  // DynamicLinkHandler.instance.initDynamicLinks();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  //await dotenv.load(fileName: "env/.env");

  // await GoogleMapsFlutterAndroid().initializeWithRenderer(AndroidMapRenderer.latest);
  // final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   mapsImplementation.useAndroidViewSurface = true;
  // }

  // Register the background message handler BEFORE runApp

  await FireBaseApi().initNotification();
  // await NotificationService().init(); // <- Must be before runApp

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  initializeBackgroundService();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // Required if background isolates run independently
  print("Handling a background message: ${message.messageId}");
}

/// Initializes Firebase and sets up error handling
Future<void> _initializeMapsApiFromRemote() async {
  await RemoteConfigHelper.init();
}

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(
      mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest)
          .then(
            (AndroidMapRenderer initializedRenderer) =>
                completer.complete(initializedRenderer),
          ),
    );
  } else {
    completer.complete(null);
  }

  return completer.future;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ServiceLoginCubit()),
        BlocProvider(create: (BuildContext context) => HomeCubit()),
        BlocProvider(create: (BuildContext context) => PromotionCubit()),
        BlocProvider(create: (BuildContext context) => NotificationCubit()),
        BlocProvider(create: (BuildContext context) => EarningCubit()),
        BlocProvider(create: (BuildContext context) => WalletCubit()),
        BlocProvider(create: (BuildContext context) => TripCubit()),
        BlocProvider(create: (BuildContext context) => AccountCubit()),
        BlocProvider(create: (BuildContext context) => DocumentCubit()),
        BlocProvider(create: (BuildContext context) => SubscriptionCubit()),
        BlocProvider(create: (BuildContext context) => MyAgencyCubit()),
        BlocProvider(create: (BuildContext context) => HireDriverCubit()),
        BlocProvider(create: (BuildContext context) => HelpCubit()),
        BlocProvider(
          create: (BuildContext context) => BookingRegistrationCubit(),
        ),
        BlocProvider(create: (BuildContext context) => DriverAccountCubit()),
        BlocProvider(create: (BuildContext context) => MainHomeCubit()),
        BlocProvider(create: (BuildContext context) => AddVehicleCubit()),
        BlocProvider(create: (BuildContext context) => TripEquatableCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 814),
        minTextAdapt: true,
        builder: (a, b) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  SizeConfig().init(constraints, orientation);
                  return GetMaterialApp(
                    useInheritedMediaQuery: true,
                    builder: DevicePreview.appBuilder,
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: 'TravelsX Driver',
                    translations: LocaleString(),
                    locale: const Locale('en', 'US'),
                    fallbackLocale: const Locale('hi', 'IN'),
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                      fontFamily: 'Urbanist',
                      scaffoldBackgroundColor: Colors.white,
                    ),
                    onGenerateRoute: (settings) {
                      return GenerateRoute.generateRoute(settings);
                    },
                    home: const SplashScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
