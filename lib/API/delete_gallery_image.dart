
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/snack_bar.dart';


deleteGalleryImage(BuildContext context, id) async {
  final provider = Provider.of<DataProvider>(context, listen: false);

  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse('$api/remove/gallery-image?image_id=$id'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
     viewProfile(context);
      log(response.body);
    } else {

    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}