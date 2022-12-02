// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/home/get_service_man.dart';
import 'package:social_media_services/model/sub_services_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/sub_service.dart';
import 'package:social_media_services/utils/get_location.dart';
import 'package:social_media_services/utils/snack_bar.dart';

getSubService(BuildContext context, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse('$subServices?parent_service_id=$id'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (jsonResponse['result'] == false) {
        await Hive.box("token").clear();

        return;
      }

      final subServicesData = SubServicesModel.fromJson(jsonResponse);
      provider.subServicesModelData(subServicesData);
      selectServiceType(context, id);
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}

selectServiceType(context, id) {
  print(id);
  final provider = Provider.of<DataProvider>(context, listen: false);
  // print(provider.viewProfileModel?.userdetails?.latitude);
  if (provider.subServicesModel?.type == 'service') {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return const SubServicesPage();
    }));
  } else if (provider.viewProfileModel?.userdetails?.latitude == null) {
    requestLocationPermission(context);
  } else {
    getServiceMan(context, id);
  }
}
