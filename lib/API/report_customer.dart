// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/model/sub_services_model.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/snack_bar.dart';

reportCustomerFun(BuildContext context) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  final reason = ReportCustomerControllers.reasonController.text;
  final comment = ReportCustomerControllers.commentController.text;
  final userid = provider.serviceManDetails?.userData?.id;

  try {
    final url =
        '$reportCustomerApi?customer_id=$userid&reason=$reason&comment=$comment';
    print(url);
    var response = await http.post(Uri.parse(url),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      AnimatedSnackBar.material("Reported Customer Successfully",
              type: AnimatedSnackBarType.success,
              borderRadius: BorderRadius.circular(6),
              duration: const Duration(seconds: 1))
          .show(
        context,
      );
      log(response.body);

      // if (jsonResponse['result'] == false) {
      //   await Hive.box("token").clear();

      //   return;
      // }

      final subServicesData = SubServicesModel.fromJson(jsonResponse);
      provider.subServicesModelData(subServicesData);
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong1", context);
  }
}
