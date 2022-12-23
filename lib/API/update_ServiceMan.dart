import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/get_serviceManProfileDetails.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/serviceman%20settings%20profile/serviceman_profile_view.dart';

updateServiceManApiFun(BuildContext context, state, id, about, profile,
    transport, checkBoxValue) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  final url =
      '$updateServiceManApi?state=$state&country_id=$id&profile=$profile&about=$about&transport=$transport&online_status=$checkBoxValue';
  if (apiToken == null) return;
  try {
    var response = await http.post(Uri.parse(url),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      await getServiceManProfileFun(context);
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return ServiceManProfileViewPage();
      }));

      // if (jsonResponse['result'] == false) {
      //   await Hive.box("token").clear();

      //   return;
      // }
    } else {
      print('35r35');
    }
  } on Exception catch (e) {
    log("Something Went Wrong16");
    print(e);
  }
}
