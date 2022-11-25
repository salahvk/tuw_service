import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/serviceman_profile_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/snack_bar.dart';

getServiceManProfileFun(BuildContext context) async {
  final apiToken = Hive.box("token").get('api_token');
  final provider = Provider.of<DataProvider>(context, listen: false);

  try {
    var response = await http.post(
        Uri.parse(
            '$serviceManProfileApi?user_id=${provider.viewProfileModel?.userdetails?.id}'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      var servicemanProfileData = ServiceManProfile.fromJson(jsonResponse);
      provider.getServiceManProfileData(servicemanProfileData);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Something Went Wrong1", context);
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
