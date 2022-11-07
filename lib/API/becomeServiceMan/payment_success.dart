import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/payment_success.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/snack_bar.dart';

getPaymentSuccess(BuildContext context, status, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  print(status);
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse('$paymentSuccess?status=$status&order_id=$id'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      print(jsonResponse);

      final paymentData = PaymentSuccessModel.fromJson(jsonResponse);
      provider.getPaymentSuccessData(paymentData);
    } else {
      showSnackBar("Something Went Wrong2", context);
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
