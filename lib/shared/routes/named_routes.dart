import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelx_driver/documents/screens/document_sceen.dart';
import 'package:travelx_driver/documents/widgets/document_upload_screen.dart';
import 'package:travelx_driver/home/hire_driver_bloc/screen/hire_driver_direction_screen.dart';
import 'package:travelx_driver/home/revamp/screen/bottom_navigation_bar.dart';
import 'package:travelx_driver/home/screen/ride.dart';
import 'package:travelx_driver/login/screen/mobile_login_screen.dart';
import 'package:travelx_driver/login/screen/verify_otp_screen.dart';

import 'package:travelx_driver/search-rides/screens/booking_registration/bookings_screen.dart';
import 'package:travelx_driver/search-rides/screens/list-rides-screen.dart';
import 'package:travelx_driver/splash/splash_screen.dart';
import 'package:travelx_driver/user/account/screen/vehicle/vehicle_screen.dart';
import 'package:travelx_driver/user/earning/screens/term_and_condition.dart';
import 'package:travelx_driver/user/help_screen/help_screen.dart';
import 'package:travelx_driver/user/privacy_policy/privacy_and_policy_screen.dart';
import 'package:travelx_driver/user/subscription/screen/Subscription_screen.dart';
import 'package:travelx_driver/user/vehicle/screen/add_vehicle_screen.dart';
import 'package:travelx_driver/user/vehicle/screen/my_vehicle_screen.dart';
import 'package:travelx_driver/user/vehicle/screen/select_vehicle.dart';

import '../../home/screen/new_driver/new_user.dart';
import '../../user/account/screen/driver_account_details/driver_account_screen.dart';
import '../../user/account/screen/profile_screen/profile_screen.dart';
import '../../user/account/screen/vehicle/driver_onboarding_screen.dart';
import '../../user/choose_language/language_screen/language_screen.dart';
import '../../user/earning/screens/earning_screen.dart';
import '../../user/my_agency/agency_screen/agencies_screen.dart';
import '../../user/notifications/screens/notifications_screen.dart';
import '../../user/promotions/screen/promotion_screen.dart';
import '../../user/shareqr_screen/qr_screen.dart';
import '../../user/trip/screens/trip_screen.dart';
import '../../user/wallet/screen/wallet_screen.dart';
import '../no_connection/no_connection_screen.dart';
import '../widgets/app_bar/gigly_app_bar.dart';

abstract class RouteName {
  static const splashScreen = "/";
  static const mobileNumberLoginScreen = "/mobileNumberLoginScreen";

  static const homeScreen = "/homeScreen";
  static const rideScreen = "/rides";
  static const noConnection = "/noConnection";
  static const verifyOtpScreen = "/verifyOtpScreen";

  static const listRideScreen = "/listRideScreen";
  static const mobileLoginScreen = "/mobileLoginScreen";
  static const otpScreen = "/otpScreen";
  static const rideDirectionsScreen = "/rideDirectionsScreen";
  static const hireDriverRideDirectionsScreen =
      "/hireDriverRideDirectionsScreen";
  static const promotionScreen = "/promotionScreen";
  static const notificationsScreen = "/notificationsScreen";
  static const subscriptionScreen = "/subscriptionScreen";
  static const earningsScreen = "/tripsEarningsScreen";
  static const walletScreen = "/walletScreen";
  static const accountScreen = "/accountScreen";
  static const documentsScreen = "/documentsScreen";
  static const userTripScreen = "/userTripScreen";
  static const documentUploadScreen = "/documentUploadScreen";
  static const profileScreen = "/profileScreen";
  static const vehicleInfoScreen = "/vehicleInfoScreen";
  static const agencyListScreen = "/agencyListScreen";
  static const AccountsScreen = "/accountsScreen";
  static const driverOnBoardingVehicleInfoScreen =
      "/driverOnBoardingVehicleInfoScreen";
  static const homeDrawer = "/homeDrawer";
  static const driverAccountScreen = "/driverAccountScreen";
  static const newDriverScreen = "/newDriverScreen";
  static const shareQrScreen = "/shareQrScreen";
  static const privacyPolicy = "/privacyPolicy";
  static const chooseLanguageScreen = "/chooseLanguageScreen";
  static const helpScreen = "/helpScreen";
  static const privacyAndPolicyScreen = "/privacyAndPolicyScreen";
  static const bookingScreen = "/bookingScreen";
  static const addVehicleScreen = "/addVehicleScreen";
  static const driverVehicleMainScreen = "/driverAddVehicleMainScreen";
  static const selectVehicleScreen = "/selectVehicleScreen";
  static const travelBottomNavigationBar = "/travelBottomNavigationBar";
}

mixin GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? route = settings.name;
    final arguments = settings.arguments;
    switch (route) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => DriverBottomNavBar(),
          settings: settings,
        );
      case RouteName.mobileNumberLoginScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileNumberLoginScreen(),
          settings: settings,
        );
      case RouteName.verifyOtpScreen:
        final arguments = settings.arguments as VerifyOtpScreen?;

        return MaterialPageRoute(
          builder:
              (context) => VerifyOtpScreen(
                countryCode: arguments?.countryCode ?? "",
                mobileController: arguments?.mobileController ?? "",
                email: arguments?.email ?? "",
              ),
          settings: settings,
        );
      case RouteName.rideScreen:
        final arguments = settings.arguments as RidesScreen;

        return MaterialPageRoute(
          builder: (context) => RidesScreen(rides: arguments.rides),
          settings: settings,
        );

      case RouteName.listRideScreen:
        final arguments = settings.arguments as ListRideScreen;
        return MaterialPageRoute(
          builder:
              (context) => ListRideScreen(
                radiusManualRide: arguments.radiusManualRide,
                rideType: arguments.rideType,
                feature: arguments.feature,
              ),
          settings: settings,
        );
      case RouteName.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
          settings: settings,
        );
      case RouteName.vehicleInfoScreen:
        return MaterialPageRoute(
          builder: (context) => const VehicleInfoScreen(),
          settings: settings,
        );
      case RouteName.agencyListScreen:
        return MaterialPageRoute(
          builder: (context) => const AgencyListScreen(),
          settings: settings,
        );

      case RouteName.privacyAndPolicyScreen:
        return MaterialPageRoute(
          builder: (context) => PrivacyAndPolicyScreen(),
          settings: settings,
        );

      case RouteName.mobileLoginScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileNumberLoginScreen(),
          settings: settings,
        );
      case RouteName.newDriverScreen:
        return MaterialPageRoute(
          builder: (context) => const NewDriverScreen(),
          settings: settings,
        );

      case RouteName.addVehicleScreen:
        return MaterialPageRoute(
          builder: (context) => const AddVehicleScreen(),
          settings: settings,
        );
      case RouteName.driverVehicleMainScreen:
        final arguments = settings.arguments as DriverVehicleScreen;
        return MaterialPageRoute(
          builder:
              (context) => DriverVehicleScreen(fromHome: arguments.fromHome),
          settings: settings,
        );
      case RouteName.selectVehicleScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectVehicleScreen(),
          settings: settings,
        );

      case RouteName.homeDrawer:
        return PageTransition(
          child: HomeDrawer(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );

      case RouteName.promotionScreen:
        return MaterialPageRoute(
          builder: (context) => const PromotionScreen(),
          settings: settings,
        );
      case RouteName.noConnection:
        return MaterialPageRoute(
          builder: (context) => const NoConnection(),
          settings: settings,
        );
      case RouteName.walletScreen:
        return MaterialPageRoute(
          builder: (context) => const WalletScreen(),
          settings: settings,
        );
      case RouteName.driverOnBoardingVehicleInfoScreen:
        final arguments =
            settings.arguments as DriverOnBoardingVehicleInfoScreen;

        return MaterialPageRoute(
          builder:
              (context) => DriverOnBoardingVehicleInfoScreen(
                address: arguments.address,
                name: arguments.name,
                placeShortName: arguments.placeShortName,
                position: arguments.position,
              ),
          settings: settings,
        );

      case RouteName.driverAccountScreen:
        return MaterialPageRoute(
          builder: (context) => DriverAccountScreen(),
          settings: settings,
        );

      case RouteName.notificationsScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
          settings: settings,
        );
      case RouteName.shareQrScreen:
        return MaterialPageRoute(
          builder: (context) => ShareQrScreen(),
          settings: settings,
        );
      case RouteName.subscriptionScreen:
        return MaterialPageRoute(
          builder: (context) => const SubscriptionScreen(),
          settings: settings,
        );

      case RouteName.earningsScreen:
        final arguments = settings.arguments as Earnings;
        return MaterialPageRoute(
          builder:
              (context) => Earnings(wantBackButton: arguments.wantBackButton),
          settings: settings,
        );
      case RouteName.userTripScreen:
        return MaterialPageRoute(
          builder: (context) => const UserTripScreen(),
          settings: settings,
        );
      case RouteName.privacyPolicy:
        return MaterialPageRoute(
          builder: (context) => PrivacyPolicy(),
          settings: settings,
        );
      case RouteName.chooseLanguageScreen:
        return MaterialPageRoute(
          builder: (context) => const ChooseLanguageScreen(),
          settings: settings,
        );
      case RouteName.helpScreen:
        return MaterialPageRoute(
          builder: (context) => const HelpScreen(),
          settings: settings,
        );

      case RouteName.documentsScreen:
        return MaterialPageRoute(
          builder: (context) => const DocumentsScreen(),
          settings: settings,
        );
      case RouteName.documentUploadScreen:
        return MaterialPageRoute(
          builder: (context) => const DocumentUploadScreen(),
          settings: settings,
        );

      case RouteName.hireDriverRideDirectionsScreen:
        return MaterialPageRoute(
          builder:
              (context) => HireDriverRideDirectionsScreen(
                params: arguments as HireDriverRideDirectionsScreenParams,
              ),
          settings: settings,
        );

      case RouteName.otpScreen:
        final arguments = settings.arguments as VerifyOtpScreen?;

        return MaterialPageRoute(
          builder:
              (context) => VerifyOtpScreen(
                countryCode: arguments?.countryCode ?? "",
                mobileController: arguments?.mobileController ?? "",
                email: arguments?.email ?? "",
              ),
          settings: settings,
        );
      case RouteName.travelBottomNavigationBar:
        return MaterialPageRoute(
          builder: (context) => const DriverBottomNavBar(),
          settings: settings,
        );

      case RouteName.bookingScreen:
        return MaterialPageRoute(
          builder:
              (context) =>
                  BookingsScreen(params: arguments as BookingsScreenParam),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
