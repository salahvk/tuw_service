import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/viewProfileModel.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/initPlatformState.dart';

viewProfile(BuildContext context) async {
  log("View profile");
  final apiToken = Hive.box("token").get('api_token');
  final provider = Provider.of<DataProvider>(context, listen: false);

  try {
    var response = await http.get(Uri.parse(viewUserProfileApi),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      bool isLogOut =
          jsonResponse["message"].toString().contains("Please login again");
      if (isLogOut) {
        showAnimatedSnackBar(context, "Please login again");

        initPlatformState(context);
      } else {
        var viewProfileData = ViewProfileModel.fromJson(jsonResponse);
        provider.viewProfileData(viewProfileData);
      }
    } else {
      // ignore: use_build_context_synchronously
      log("Something Went Wrong19");
      showAnimatedSnackBar(
        context,
        "Api Error Occured",
      );
    }
  } on Exception catch (e) {
    log("Something Went Wrong20");
    print(e);
  }
}
