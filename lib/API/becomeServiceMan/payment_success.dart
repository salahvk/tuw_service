// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/payment_success.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;

getPaymentSuccess(BuildContext context, status, id, resCode, resMessage,
    authCode, fortId) async {
  log("Payment Success API calling");
  print(id);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  print(status);
 
  try {
    var response = await http.post(
        Uri.parse(
            '$paymentSuccess?status=$status&order_id=$id&response_code=$resCode&response_message=$resMessage&authorization_code=$authCode&fort_id=$fortId'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      print(jsonResponse);

      final paymentData = PaymentSuccessModel.fromJson(jsonResponse);
      provider.getPaymentSuccessData(paymentData);
    } else {
      log(
        "// Went Wrong2",
      );
    }
  } on Exception catch (_) {
    log(
      "// Went Wrong1",
    );
  }
}
