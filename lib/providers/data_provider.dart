import 'package:flutter/cupertino.dart';

import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/model/get_language.dart';
import 'package:social_media_services/model/viewProfileModel.dart';

class DataProvider with ChangeNotifier {
  LanguageModel? languageModel;

  void languageModelData(value) {
    languageModel = value;
    notifyListeners();
  }

  CountriesModel? countriesModel;

  void countriesModelData(value) {
    countriesModel = value;
    notifyListeners();
  }

  String? deviceId;

  ViewProfileModel? viewProfileModel;

  void viewProfileData(value) {
    viewProfileModel = value;
    notifyListeners();
  }
}
