// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
// import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
// import 'package:travelx_driver/shared/api_client/api_client.dart';

// class PayUPaymentManager with PayUCheckoutProProtocol {
//   final BuildContext context;
//   late PayUCheckoutProFlutter _checkoutPro;

//   PayUPaymentManager(this.context) {
//     _checkoutPro = PayUCheckoutProFlutter(this);
//   }

//   Future<void> pay({required String amount}) async {
//     try {
//       final response = await ApiClient().post(
//         "https://prod.gigly.ai/api/v1/payment/payu/payment/url/create",
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: {
//           "amount": amount,
//           "name": "manik",
//           "phone": "8248198568",
//           "email": "travelsx.partner@gigly.ai",
//         },
//       );

//       final body = response['data'];

//       final params = <String, dynamic>{
//         PayUPaymentParamKey.key: body['key'],
//         PayUPaymentParamKey.transactionId: body['txnid'],
//         PayUPaymentParamKey.amount: body['amount'].toString(),
//         PayUPaymentParamKey.productInfo: jsonEncode({
//           "name": body['productinfo'],
//         }),
//         PayUPaymentParamKey.firstName: body['firstname'],
//         PayUPaymentParamKey.email: body['email'],
//         PayUPaymentParamKey.phone: body['phone'],
//         PayUPaymentParamKey.environment: "1",
//         PayUPaymentParamKey.android_surl: body['surl'],
//         PayUPaymentParamKey.android_furl: body['furl'],
//         PayUPaymentParamKey.additionalParam: {
//           "payment": body['hash'],
//           "payment_related_details_for_mobile_sdk": body['hash2'],
//           "vas_for_mobile_sdk": body['hash3'],
//         },
//       };

//       _checkoutPro.openCheckoutScreen(
//         payUPaymentParams: params,
//         payUCheckoutProConfig: {
//           PayUCheckoutProConfigKeys.merchantName: body['business_name'],
//           PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
//         },
//       );
//     } catch (e) {
//       _showMessage("❌ Payment Error: $e");
//     }
//   }

//   @override
//   void generateHash(Map response) {
//     // Not needed for static hash integration
//   }

//   @override
//   void onPaymentSuccess(dynamic response) {
//     _showMessage("✅ Payment Success!\n$response");
//   }

//   @override
//   void onPaymentFailure(dynamic response) {
//     _showMessage("❌ Payment Failed!\n$response");
//   }

//   @override
//   void onPaymentCancel(Map? response) {
//     _showMessage("⚠️ Payment Cancelled.");
//   }

//   @override
//   void onError(Map? response) {
//     _showMessage("⚠️ Error: $response");
//   }

//   void _showMessage(String msg) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Payment Status'),
//             content: Text(msg),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }
// }
