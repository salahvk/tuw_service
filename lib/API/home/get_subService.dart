// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:animated_snack_bar/animated_snack_bar.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

getSubService(BuildContext context, id, bool changeLan) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  provider.subServicesModel = null;
  final apiToken = Hive.box("token").get('api_token');
  final String lanId = Hive.box("LocalLan").get('lang_id');
  print(lanId);

  if (apiToken == null) return;
  try {
    var response = await http.post(
        Uri.parse('$subServices?parent_service_id=$id&language_id=$lanId'),
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
      if (changeLan != true) {
        selectServiceType(context, id);
      }
    } else {
      // print(response.statusCode);
      // print(response.body);
      // print('Something went wrong');
    }
  } on Exception catch (_) {
  
  }
}

selectServiceType(context, id) async {
  print(id);
  final provider = Provider.of<DataProvider>(context, listen: false);
  final str = AppLocalizations.of(context)!;
  if (provider.subServicesModel?.type == 'service') {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return const SubServicesPage();
    }));
  } else if (provider.viewProfileModel?.userdetails?.latitude == null) {
    requestLocationPermission(
      context,
    );
    Navigator.pop(context);

    AnimatedSnackBar.material(str.snack_get_location,
            type: AnimatedSnackBarType.info,
            borderRadius: BorderRadius.circular(6),
            duration: const Duration(seconds: 1))
        .show(
      context,
    );
    await Future.delayed(const Duration(seconds: 2));

    AnimatedSnackBar.material(str.snack_done,
            type: AnimatedSnackBarType.success,
            borderRadius: BorderRadius.circular(6),
            duration: const Duration(seconds: 3))
        .show(
      context,
    );
  } else {
    getServiceMan(context, id);
  }
}
