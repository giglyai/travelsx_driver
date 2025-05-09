// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:http/http.dart' as http;

// import '../../global_variables.dart';
// import '../../shared/local_storage/user_repository.dart';
// import '../entity/payment_response.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';


// class UpiPayment {
//   UpiPayment({required this.totalAmount});
//   int totalAmount;
//   String merchantTransactionId =
//       DateTime.now().millisecondsSinceEpoch.toString();
//   bool enableLogging = true;
//   String checkSum = "";
//   String body = "";
//   Object? result;

//   PaymentResposne? paymentResposne;

//   getCheckSum() {
//     final requestData = {
//       "merchantId": merchantId,
//       "merchantTransactionId": merchantTransactionId,
//       "merchantUserId": UserRepository.getUserID,
//       "amount": (totalAmount * 100),
//       "callbackUrl": calkBackUrl,
//       "mobileNumber": UserRepository.getPhoneNumber,
//       "paymentInstrument": {
//         "type": "PAY_PAGE",
//       }
//     };
//     String base64Body = base64.encode(utf8.encode(jsonEncode(requestData)));
//     checkSum =
//         '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
//     return base64Body;
//   }

//   Future<PaymentResposne?> startPgTransaction() async {
//     body = getCheckSum().toString();

//     Map<dynamic, dynamic>? response = await PhonePePaymentSdk.startTransaction(
//         body, calkBackUrl, checkSum, "");
//     if (response != null) {
//       String status = response['status'].toString();
//       String error = response['error'].toString();
//       if (status == 'SUCCESS') {
//         result = "Flow Completed - Status: Success!";
//         paymentResposne = await checkStatus();
//         return paymentResposne;
//       } else {
//         result = "Flow Completed - Status: $status and Error: $error";
//         return paymentResposne;
//       }
//     } else {
//       // "Flow Incomplete";
//     }

//     return paymentResposne;
//   }

//   Future<PaymentResposne?> checkStatus() async {
//     String url =
//         "https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$merchantTransactionId";
//     String concat = "/pg/v1/status/$merchantId/$merchantTransactionId$saltKey";
//     var bytes = utf8.encode(concat);
//     var digest = sha256.convert(bytes).toString();
//     String xVerify = "$digest###$saltIndex";
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "X-VERIFY": xVerify,
//       "X-MERCHANT-ID": merchantId,
//     };
//     await http.get(Uri.parse(url), headers: headers).then((value) {
//       Map<String, dynamic> res = jsonDecode(value.body);
//       paymentResposne = PaymentResposne.fromJson(res);
//     });
//     return paymentResposne;
//   }
// }

// class PhonePayInit {
//   static final PhonePayInit _singleton = PhonePayInit._internal();
//   factory PhonePayInit() => _singleton;
//   PhonePayInit._internal() {
//     phonePayInit();
//   }
//   Future<void> phonePayInit() async {
//     PhonePePaymentSdk.init(environment, appId, merchantId, false)
//         .then((val) => {})
//         .catchError((error) {
//       return <dynamic>{};
//     });
//   }

//   static PhonePayInit get instance => _singleton;
// }
