// import 'dart:developer';

// import 'package:amazon_payfort/amazon_payfort.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:provider/provider.dart';
// import 'package:social_media_services/API/becomeServiceMan/payment_success.dart';
// import 'package:social_media_services/API/viewProfile.dart';
// import 'package:social_media_services/components/routes_manager.dart';
// import 'package:social_media_services/providers/data_provider.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/apis/payfort_api.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/constants/fort_constants.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/models/sdk_token_response.dart';
// import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/providers/default_change_notifier.dart';

// import 'package:uuid/uuid.dart';

// class PaymentProvider extends DefaultChangeNotifier {
//   final AmazonPayfort _payfort = AmazonPayfort.instance;

//   final NetworkInfo _info = NetworkInfo();
//   int call = 0;

//   Future<void> init() async {
//     // call == 5;
//     print("call");

//     /// Step 1:  Initialize Amazon Payfort
//     await AmazonPayfort.initialize(
//       const PayFortOptions(environment: FortConstants.environment),
//     );
//   }

//   Future<void> paymentWithCreditOrDebitCard({
//     required SucceededCallback onSucceeded,
//     required FailedCallback onFailed,
//     required CancelledCallback onCancelled,
//     required double grandTotal,
//     // required Packages packages,
//     // required String taxTotalAmount,
//     required BuildContext context,
//   }) async {
//     try {
//       var sdkTokenResponse = await _generateSdkToken();
//       final convertedAmount = grandTotal * 100;
//       call = 0;
//       // final localIP = await getIPAddress();
//       // print(localIP);

//       /// Step 4: Processing Payment [Amount multiply with 100] ex. 10 * 100 = 1000 (10 SAR)
//       FortRequest request = FortRequest(
//         amount: convertedAmount.toInt(),
//         customerName: 'Test Cus',
//         customerEmail: 'test@customer.com',
//         orderDescription: 'Test Order',
//         sdkToken: sdkTokenResponse?.sdkToken ?? '',
//         merchantReference: const Uuid().v4(),
//         currency: 'SAR',
//         customerIp: (await _info.getWifiIP() ?? ''),
//       );

//       _payfort.callPayFort(
//         request: request,
//         callBack: PayFortResultCallback(
//           onSucceeded: (result) {
//             if (call == 0) {
//               final resCode = result.responseCode;
//               final resMessage = result.responseMessage;
//               final authCode = result.authorizationCode;
//               final fortId = result.fortId;
//               log("success");
//               getOrderSuccessData(
//                   context, resCode, resMessage, authCode, fortId);
//               call = call + 1;
//               log(result.fortId!);
//             }
//           },
//           onFailed: (result) {
//             log("failed");

//             log(result);
//           },
//           onCancelled: onCancelled,
//         ),
//       );
//     } catch (e) {
//       onFailed(e.toString());
//       print(e);
//     }
//   }

//   Future<void> paymentWithApplePay({
//     required SucceededCallback onSucceeded,
//     required FailedCallback onFailed,
//   }) async {
//     try {
//       var sdkTokenResponse = await _generateSdkToken(isApplePay: true);

//       /// Step 4: Processing Payment [Don't multiply with 100]
//       FortRequest request = FortRequest(
//         amount: 1000,
//         customerName: 'Test Customer',
//         customerEmail: 'test@customer.com',
//         orderDescription: 'Test Order',
//         sdkToken: sdkTokenResponse?.sdkToken ?? '',
//         merchantReference: const Uuid().v4(),
//         currency: 'SAR',
//         customerIp: (await _info.getWifiIP() ?? ''),
//       );

//       _payfort.callPayFortForApplePay(
//         request: request,
//         countryIsoCode: 'SA',
//         applePayMerchantId: FortConstants.applePayMerchantId,
//         callback: ApplePayResultCallback(
//           onSucceeded: onSucceeded,
//           onFailed: onFailed,
//         ),
//       );
//     } catch (e) {
//       onFailed(e.toString());
//     }
//   }

//   Future<SdkTokenResponse?> _generateSdkToken({bool isApplePay = false}) async {
//     try {
//       loading = true;

//       var accessCode = isApplePay
//           ? FortConstants.applePayAccessCode
//           : FortConstants.accessCode;
//       var shaRequestPhrase = isApplePay
//           ? FortConstants.applePayShaRequestPhrase
//           : FortConstants.shaRequestPhrase;
//       String? deviceId = await _payfort.getDeviceId();

//       /// Step 2:  Generate the Signature
//       SdkTokenRequest tokenRequest = SdkTokenRequest(
//         accessCode: accessCode,
//         deviceId: deviceId ?? '',
//         merchantIdentifier: FortConstants.merchantIdentifier,
//       );

//       String? signature = await _payfort.generateSignature(
//         shaType: FortConstants.shaType,
//         concatenatedString: tokenRequest.toConcatenatedString(shaRequestPhrase),
//       );

//       tokenRequest = tokenRequest.copyWith(signature: signature);

//       /// Step 3: Generate the SDK Token
//       return await PayFortApi.generateSdkToken(tokenRequest);
//     } finally {
//       loading = false;
//     }
//   }

//   // placeOrder(BuildContext context, Packages packages, String grandTotal,
//   //     String taxTotalAmount) async {
//   //   // setState(() {
//   //   //   isPaymentLoading = true;
//   //   // });
//   //   final provider = Provider.of<DataProvider>(context, listen: false);
//   //   final apiToken = Hive.box("token").get('api_token');
//   //   if (apiToken == null) return;
//   //   final fieldData = provider.viewProfileModel?.userdetails;
//   //   // final url =
//   //   //     "${paymentSuccess}firstname=${ProfileServiceControllers.firstNameController}&lastname=${ProfileServiceControllers.lastNameController}&civil_card_no=${ProfileServiceControllers.civilCardController}&dob=${ProfileServiceControllers.dateController}&gender=female&country_id=101&state=kerala&region=sdf&address=dfsdf&package_id=40&service_id=12&coupon_code=ABC&total_amount=100.00&total_tax_amount=0.00&coupon_discount=0.00&grand_total=100.00";
//   //   final firstName = ProfileServiceControllers.firstNameController.text.isEmpty
//   //       ? fieldData?.firstname ?? ''
//   //       : ProfileServiceControllers.firstNameController.text;
//   //   final lastName = ProfileServiceControllers.lastNameController.text.isEmpty
//   //       ? fieldData?.lastname ?? ''
//   //       : ProfileServiceControllers.lastNameController.text;
//   //   final civilCardNo =
//   //       ProfileServiceControllers.civilCardController.text.isEmpty
//   //           ? fieldData?.civilCardNo ?? ''
//   //           : ProfileServiceControllers.civilCardController.text;
//   //   final dob = ProfileServiceControllers.dateController.text.isEmpty
//   //       ? fieldData?.dob ?? ''
//   //       : ProfileServiceControllers.dateController.text;
//   //   final gender =
//   //       provider.gender.isEmpty ? fieldData?.gender ?? '' : provider.gender;
//   //   final state = ProfileServiceControllers.stateController.text.isEmpty
//   //       ? fieldData?.state ?? ''
//   //       : ProfileServiceControllers.stateController.text;
//   //   final region = ProfileServiceControllers.regionController.text.isEmpty
//   //       ? fieldData?.region ?? ''
//   //       : ProfileServiceControllers.regionController.text;
//   //   final address = ProfileServiceControllers.addressController.text.isEmpty
//   //       ? fieldData?.about ?? ''
//   //       : ProfileServiceControllers.addressController.text;
//   //   final serviceId = provider.serviceId;
//   //   final coupenCode = PaymentServiceControllers.couponController.text;
//   //   final countryId = provider.selectedCountryId ??
//   //       provider.viewProfileModel?.userdetails?.countryId;
//   //   final packageId = packages.id;

//   //   final url =
//   //       '${placeOrderApi}firstname=$firstName&lastname=$lastName&civil_card_no=$civilCardNo&dob=$dob&gender=$gender&country_id=${countryId.toString()}&state=$state&region=$region&address=$address&package_id=$packageId&service_id=$serviceId&coupon_code=$coupenCode&total_amount=${packages.amount}&total_tax_amount=$taxTotalAmount&coupon_discount=0.00&grand_total=$grandTotal';
//   //   try {
//   //     print(packageId);
//   //     print(url);
//   //     // return;
//   //     var response = await http.post(Uri.parse(url), headers: {
//   //       "device-id": provider.deviceId ?? '',
//   //       "api-token": apiToken
//   //     });
//   //     if (response.statusCode == 200) {
//   //       var jsonResponse = jsonDecode(response.body);
//   //       log(response.body);
//   //       if (jsonResponse['result'] == true) {
//   //         showSnackBar(jsonResponse['message'], context);

//   //         // Navigator.push(context, MaterialPageRoute(builder: ((context) {
//   //         //   return const PaymentSelection();
//   //         // })));
//   //         // setState(() {
//   //         //   isPaymentLoading = false;
//   //         // });

//   //         final placeOrderData = PlaceOrder.fromJson(jsonResponse);
//   //         provider.getPlaceOrderData(placeOrderData);
//   //         getOrderSuccessData(context);
//   //       } else {
//   //         print(response.statusCode);
//   //         showAnimatedSnackBar(
//   //           context,
//   //           jsonResponse['errors'],
//   //         );

//   //         // setState(() {
//   //         //   isPaymentLoading = false;
//   //         // });
//   //       }
//   //       // final childData = ChildServiceModel.fromJson(jsonResponse);
//   //       // provider.childModelData(childData);
//   //     } else {
//   //       log("Something Went Wrong1");
//   //     }
//   //   } on Exception catch (e) {
//   //     log("Something Went Wrong1");
//   //     print(e);
//   //   }
//   // }

// //* Get order successData API

//   getOrderSuccessData(
//       BuildContext context, resCode, resMessage, authCode, fortId) async {
//     final provider = Provider.of<DataProvider>(context, listen: false);
//     // setState(() {
//     //   isLoading = true;
//     // });
//     await getPaymentSuccess(
//         context,
//         'success',
//         provider.placeOrder?.orderId.toString(),
//     );
//     await viewProfile(context);
//     log("Finished");
//     // setState(() {
//     //   isLoading = false;
//     // });
//     Navigator.pushNamed(context, Routes.paymentSuccessfull);
//   }
// }
