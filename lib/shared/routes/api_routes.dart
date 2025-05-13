import 'package:travelx_driver/global_variables.dart';

abstract class ApiRoutes {
  // static  String mainUrl = 'https://qa2.gigly.ai/';
  static String mainUrl = parentApi;
  static String baseUrl = '${mainUrl}api/';
  static String baseUrlV1 = '${mainUrl}api/v1/';
  static String baseUrlV2 = '${mainUrl}api/v2/';
  static String updateUserLocation =
      '${baseUrlV1}location/ingest/current/location';
  static String getCountryCode = '${baseUrlV1}user/country/config';

  static String accountUpdate = '${baseUrlV1}user/account/update';
  static String toggleDriverStatus = '${baseUrlV1}user/driver/status';
  static String updateUserDetail = '${baseUrlV1}user/driver/profile/update';
  // static const String getTrips = '${baseUrlV1}trips';
  static String getTrips = '${baseUrlV1}deliveries/find';
  static String getRides = '${baseUrlV1}rides/find';
  static String getRide = '${baseUrlV1}rides/find/ride';
  // static const String getTripsFullRoute = '${baseUrlV1}trips/full/route';
  static String getTripsFullRoute = '${baseUrlV1}deliveries/full/route';
  static String getRidesFullRoute = '${baseUrlV1}rides/full/route';
  static String getTripsMetrics = '${baseUrlV1}user';
  static String mutateTrips = '${baseUrlV1}delivery/mutate';
  static String mutateRides = '${baseUrlV1}ride/mutate/by/driver';
  static String mutateTripsImage = '${baseUrlV1}delivery/mutate/image';
  static String getDirectionDistance = '${baseUrlV1}location/distance_time';
  static String getPromotion = '${baseUrlV1}promotions/find';
  static String activePromotion = '${baseUrlV1}promotions/active';
  static String activeRidePromotion = '${baseUrlV1}ride/promo/active';
  static String completedRidePromotion = '${baseUrlV1}ride/promo/completed';
  static String login = '${baseUrlV1}user/driver/login';
  static String otpLogin = '${baseUrlV1}otp/send';
  static String otpVerify = '${baseUrlV1}otp/verify';
  static String getRecentNotification = '${baseUrlV1}notif/recent';
  static String getAllNotification = '${baseUrlV1}notif/all';
  static String getEarning = '${baseUrlV1}earnings/q';
  static String getUserTrip = '${baseUrlV1}trips/q';
  static String getUserCancelledTrip = '${baseUrlV1}trips/q';
  static String getWalletData = '${baseUrlV1}wallet/transactions/q';
  static String postUserDoc = '${baseUrlV1}user/docs/upload';
  static String getDocStatus = '${baseUrlV1}user/docs/status';
  static String updateDriverRate = '${baseUrlV1}ride/driver/rate';
  static String getManualRides = '${baseUrlV1}rides/search/all';
  static String getActingRides = '${baseUrlV1}ride/book/driver/query';
  static String userProfileUpdate = '${baseUrlV1}user/account/update';
  static String getUserProfileData = '${baseUrlV1}user/profile';
  static String getUserVehicleData = '${baseUrlV1}user/ride/vehicle/details';
  static String uploadProfileImg = '${baseUrlV1}user/files/upload';
  static String appVersion = '${baseUrlV1}app/version';
  static String getSubscription = '${baseUrlV1}user/subscription';
  static String getMyAgency = '${baseUrlV1}user/driver/agency';
  static String userAccountDelete = '${baseUrlV1}user/account/delete';
  static String userHelp = '${baseUrlV1}user/help';
  // static String getHireDriverAcceptedData =
  //     '${baseUrlV1}ride/query/driver/home';
  static String getUpcomingOnTripRide =
      '${baseUrlV1}rides/query/driver/upcoming_ontrip';
  static String statusCreate = '${baseUrlV1}user/payment/status/create';

  static String getDriverRideHomeData = '${baseUrlV1}driver/ride/home';
  static String postVehicleData = '${baseUrlV1}user/driver/select/vehicle';
  static String getTravelCarList = '${baseUrlV1}user/travel/vehicles';
  static String travelVerifyVehicleOtp = '${baseUrlV1}otp/vehicle/verify';
  static String mutateRideDistMeter = '${baseUrlV1}ride/mutate/dist';
  static String getRideFinalDetails = '${baseUrlV1}ride/total/rate';
  static String getRidesMatrix = '${baseUrlV1}rides/driver/all/q';
  static String verifyRideOtp = '${baseUrlV1}rides/otp/verify';
  static String getDriverBusinessOverview =
      '${baseUrlV2}ride/business/overview/q';
}
