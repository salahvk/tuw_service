// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/model/other%20User/other_user_address_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';

getOtherUserAddress(BuildContext context, String id) async {
  log("Other User Address Api");
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');

  try {
    var response = await http.post(
        Uri.parse(
            'http://projects.techoriz.in/serviceapp/public/api/other/address/list?user_id=$id'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

      final otherUserAddressData = OtherUserAddress.fromJson(jsonResponse);
      provider.getOtherUserAddressData(otherUserAddressData);
    } else {
      showAnimatedSnackBar(
        context,
        "Api Error Occured",
      );

      return;
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (e) {
    // showAnimatedSnackBar(
    //   context,
    //   "Api Error Occured",
    // );
    log("Something Went Wrong51");
    print(e);
  }
}
