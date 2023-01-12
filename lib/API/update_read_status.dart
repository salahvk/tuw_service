// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/providers/data_provider.dart';

updateReadStatus(BuildContext context, id) async {
  log("Update Read status API");
  final provider = Provider.of<DataProvider>(context, listen: false);

  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  final url = '$updateReadStatusApi?sender_id=$id';
  try {
    var response = await http.post(Uri.parse(url),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

      // final subServicesData = SubServicesModel.fromJson(jsonResponse);
      // provider.subServicesModelData(subServicesData);
      // selectServiceType(context, id);
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {}
}
