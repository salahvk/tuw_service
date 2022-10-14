import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/viewProfileModel.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/snack_bar.dart';

viewProfile(BuildContext context) async {
  final apiToken = Hive.box("token").get('api_token');
  final provider = Provider.of<DataProvider>(context, listen: false);

  try {
    var response = await http.get(Uri.parse(viewUserProfileApi),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var viewProfileData = ViewProfileModel.fromJson(jsonResponse);
      print('finished');
      provider.viewProfileData(viewProfileData);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Something Went Wrong1", context);
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
