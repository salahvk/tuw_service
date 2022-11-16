// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/user_address_show.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/snack_bar.dart';

getUserAddress(BuildContext context) async {
  print('getting user address');
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    provider.userAddressShow = null;
    var response = await http.get(Uri.parse(getUserAddressApi),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      log(response.body);
      print('getting user address');
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['result'] == false) {
        await Hive.box("token").clear();

        return;
      }

      final userAddressData = UserAddressShow.fromJson(jsonResponse);
      provider.getUserAddressData(userAddressData);
      print(jsonResponse);
    } else {
      // print(response.statusCode);
      // print(response.body);
      print('Something went wrong');
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
