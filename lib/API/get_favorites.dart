import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/favorite_serviceMan.dart';
import 'package:social_media_services/providers/data_provider.dart';

getFavoritesListFun(BuildContext context) async {
  //  final otpProvider = Provider.of<OTPProvider>(context, listen: false);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final userDetails = provider.viewProfileModel?.userdetails;
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(Uri.parse(favoritesListApi),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

     

      final serviceManListData = FavoriteServiceManModel.fromJson(jsonResponse);
      provider.getServiceManFavoriteData(serviceManListData);
    } else {}
  } on Exception catch (e) {
    log("Something Went Wrong4");
    print(e);
  }
}

addFavoritesListFun(BuildContext context, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse("$addFavoritesListApi?favorite_user_id=$id"),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      log(response.body);
    } else {}
  } on Exception catch (e) {
    log("Something Went Wrong5");
    print(e);
  }
}

removeFavoritesListFun(BuildContext context, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse("$removeFavoritesListApi?favorite_user_id=$id"),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      log(response.body);
    } else {}
  } on Exception catch (e) {
    log("Something Went Wrong6");
    print(e);
  }
}
