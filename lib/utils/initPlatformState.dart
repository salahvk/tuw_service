import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/get_countries.dart';
import 'package:social_media_services/API/get_language.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';
import 'package:social_media_services/utils/viewProfile.dart';

Future<void> initPlatformState(BuildContext context) async {
  final provider = Provider.of<DataProvider>(context, listen: false);
  String? deviceId;

  try {
    deviceId = await PlatformDeviceId.getDeviceId;
    provider.deviceId = deviceId;
  } on PlatformException {
    deviceId = 'Failed to get deviceId.';
  }
  final apiToken = Hive.box("token").get('api_token');
  print(apiToken);
  if (apiToken == null) {
    gotoNextPage(context);
  } else {
    await viewProfile(context);
    await getCountriesData(context);
    gotoHomePage(context);
  }
  print(provider.deviceId);
}

gotoNextPage(BuildContext context) async {
  getlocalLanguage(context);
  await getLanguageData(context);
  await getCountriesData(context);

  Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context, Routes.introductionScreen);
  });
}

gotoHomePage(BuildContext context) async {
  Timer(const Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context, Routes.homePage);
  });
}