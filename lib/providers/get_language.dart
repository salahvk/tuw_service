import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_language.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/snack_bar.dart';

getLanguageData(BuildContext context) async {
  try {
    final provider = Provider.of<DataProvider>(context, listen: false);
    var response =
        await http.get(Uri.parse(languagesApi), headers: {"device-id": "1952"});
    // print(response.body);
    if (response.statusCode != 200) {
      showSnackBar("Something Went Wrong", context);
      return;
    }
    print('object');
    var jsonResponse = jsonDecode(response.body);
    var languageModel = LanguageModel.fromJson(jsonResponse);
    provider.languageModelData(languageModel);
  } on Exception catch (_) {
    showSnackBar("Something Went Wrong", context);
  }
}
