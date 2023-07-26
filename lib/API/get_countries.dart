import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_services/utils/animatedSnackBar.dart';

getCountriesData(BuildContext context) async {
  try {
    final provider = Provider.of<DataProvider>(context, listen: false);
    var response = await http.get(Uri.parse(countriesApi),
        headers: {"device-id": provider.deviceId ?? ''});
    // print(response.body);
    if (response.statusCode != 200) {

      // showAnimatedSnackBar(
      //   context,
      //   "Api Error Occured",
      // );
      return;
    }

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    var countriesModel = CountriesModel.fromJson(jsonResponse);
    provider.countriesModelData(countriesModel);
  } on Exception catch (e) {
    log("Something Went Wrong2");
    print(e);
  }
}
