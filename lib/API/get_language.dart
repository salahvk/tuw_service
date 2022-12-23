import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_language.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;

getLanguageData(BuildContext context) async {
  try {
    final provider = Provider.of<DataProvider>(context, listen: false);
    var response = await http.get(Uri.parse(languagesApi),
        headers: {"device-id": provider.deviceId ?? ''});
    // print(response.body);
    if (response.statusCode != 200) {
      log("Something Went Wrong8");
      return;
    }

    var jsonResponse = jsonDecode(response.body);
    var languageModel = LanguageModel.fromJson(jsonResponse);
    provider.languageModelData(languageModel);
  } on Exception catch (e) {
    log("Something Went Wrong7");
    print(e);
  }
}
