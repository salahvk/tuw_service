// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_child_service.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/snack_bar.dart';

getCustomerParent(BuildContext context) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  final String lanId = Hive.box("LocalLan").get('lang_id');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse("$customerParentService?language_id=$lanId"),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      final parentData = HomeModel.fromJson(jsonResponse);
      provider.parentModelData(parentData);
    } else {

    }
  } on Exception catch (_) {
 
  }
}

getCustomerChild(BuildContext context, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  final String lanId = Hive.box("LocalLan").get('lang_id');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse(
            "$customerChildService?parent_service_id=$id&language_id=$lanId"),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

      final childData = ChildServiceModel.fromJson(jsonResponse);
      provider.childModelData(childData);
    } else {
     
    }
  } on Exception catch (_) {
    
  }
}
