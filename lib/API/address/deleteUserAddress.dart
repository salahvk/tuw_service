import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;

deleteUserAddress(BuildContext context, String id) async {
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  print(id);
  try {
    var response = await http.post(Uri.parse('$deleteUserAddressApi$id'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      print(jsonResponse);
    } else {
      print(response.statusCode);
      print(response.body);
      log('Something went wrong22');
    }
  } on Exception catch (e) {
    log("Something Went Wrong21");
    print(e);
  }
}
