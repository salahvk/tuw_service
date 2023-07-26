// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/getCoupenModel.dart';

import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> getCoupenCodeList(BuildContext context) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  final str = AppLocalizations.of(context)!;

  try {
    var response = await http.get(Uri.parse(customerCoupenList),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);

      final coupenCodeData = GetCoupenModel.fromJson(jsonResponse);
      provider.coupenCodeData(coupenCodeData);
      if (coupenCodeData.coupons!.isEmpty) {
        showAnimatedSnackBar(context, str.snack_coupen_av);
        return false;
      }
    } else {}
  } on Exception catch (_) {
    showSnackBar("Error Occured", context);
  }
  return true;
}

checkCoupenCode(BuildContext context, code) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  final apiToken = Hive.box("token").get('api_token');
  if (apiToken == null) return;
  try {
    var response = await http.post(Uri.parse('$checkCoupen$code'),
        headers: {"device-id": provider.deviceId ?? '', "api-token": apiToken});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (jsonResponse['result'] == false) {
        showAnimatedSnackBar(context, jsonResponse['toast']);
      }

      final coupenCodeData = GetCoupenModel.fromJson(jsonResponse);
      provider.coupenCodeData(coupenCodeData);
    } else {}
  } on Exception catch (_) {}
}
