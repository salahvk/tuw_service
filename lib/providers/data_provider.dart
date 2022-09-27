import 'package:flutter/cupertino.dart';

import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/model/get_language.dart';

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

  // ScalableImage? SIimage;

  // void siImageData(value) {
  //   SIimage = value;
  //   notifyListeners();
  // }
}
