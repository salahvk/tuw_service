// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/model/otp/get_otp.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/otp_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/snack_bar.dart';

getOtp(BuildContext context, countryCode, phoneNo, resend) async {
  final String id = Hive.box("LocalLan").get('lang_id');
  try {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final otpProvider = Provider.of<OTPProvider>(context, listen: false);
    var response = await http.post(
        Uri.parse(
            "$apiUser/request_otp?countrycode=$countryCode&phone=$phoneNo&language_id=$id"),
        headers: {"device-id": provider.deviceId ?? ''});

    if (response.statusCode != 200) {
      showSnackBar("Something Went Wrong", context);
      return;
    }

    var jsonResponse = jsonDecode(response.body);
    final result = jsonResponse["result"];
    final action = jsonResponse["action"];
    log(action);

    if (result == false) {
      final errorMessage = jsonResponse["message"]["phone"][0];
      showAnimatedSnackBar(context, errorMessage);
      return;
    }

    var getOtpData = GetOtp.fromJson(jsonResponse);

    otpProvider.getOtpData(getOtpData);

    if (resend == true) {
      return;
    }
    navigateToOtp(context);
  } on Exception catch (e) {
    showSnackBar("Something Went Wrong", context);
    print(e);
  }
}

navigateToOtp(context) {
  Navigator.pushNamed(context, Routes.otpScreen);
}
