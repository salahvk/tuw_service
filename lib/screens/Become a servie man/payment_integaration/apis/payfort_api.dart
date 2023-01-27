import 'dart:convert';
import 'dart:developer';

import 'package:amazon_payfort/amazon_payfort.dart';

import 'package:http/http.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/constants/fort_constants.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/payment_integaration/models/sdk_token_response.dart';

class PayFortApi {
  PayFortApi._();

  static Future<SdkTokenResponse?> generateSdkToken(
      SdkTokenRequest request) async {
    var response = await post(
      Uri.parse(FortConstants.environment.paymentApi),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toRequest()),
    );
    print(jsonEncode(request.toRequest()));
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      log(response.body);
      return SdkTokenResponse.fromMap(decodedResponse);
    }
    return null;
  }
}
