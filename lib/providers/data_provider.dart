import 'package:flutter/material.dart';
import 'package:social_media_services/model/chat_list.dart';
import 'package:social_media_services/model/coupenCode.dart';
import 'package:social_media_services/model/favorite_serviceMan.dart';
import 'package:social_media_services/model/get_child_service.dart';

import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/model/get_home.dart';
import 'package:social_media_services/model/get_language.dart';
import 'package:social_media_services/model/payment_success.dart';
import 'package:social_media_services/model/place_order.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/model/serviceman_profile_model.dart';
import 'package:social_media_services/model/sub_services_model.dart';
import 'package:social_media_services/model/user_address_show.dart';
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

  HomeModel? homeModel;

  void homeModelData(value) {
    homeModel = value;
    notifyListeners();
  }

  HomeModel? customerParentSer;

  void parentModelData(value) {
    customerParentSer = value;
    notifyListeners();
  }

  ChildServiceModel? customerChildSer;

  void childModelData(value) {
    customerChildSer = value;
    notifyListeners();
  }

  CoupenCode? coupenCodeModel;

  void coupenCodeData(value) {
    coupenCodeModel = value;
    notifyListeners();
  }

  SubServicesModel? subServicesModel;

  void subServicesModelData(value) {
    subServicesModel = value;
    notifyListeners();
  }

  PlaceOrder? placeOrder;

  void getPlaceOrderData(value) {
    placeOrder = value;
    notifyListeners();
  }

  PaymentSuccessModel? paymentSuccess;

  void getPaymentSuccessData(value) {
    paymentSuccess = value;
    notifyListeners();
  }

  UserAddressShow? userAddressShow;

  void getUserAddressData(value) {
    userAddressShow = value;
    notifyListeners();
  }

  ServiceManListModel? serviceManListModel;

  void getServiceManData(value) {
    serviceManListModel = value;
    notifyListeners();
  }

  FavoriteServiceManModel? serviceManListFavoriteModel;

  void getServiceManFavoriteData(value) {
    serviceManListFavoriteModel = value;
    notifyListeners();
  }

  ServiceManProfile? serviceManProfile;

  void getServiceManProfileData(value) {
    serviceManProfile = value;
    notifyListeners();
  }

  ServiceManProfile? serviceManDetails;

  void getServiceManDetails(value) {
    serviceManDetails = value;
    notifyListeners();
  }

  ChatListModel? chatListDetails;

  void getChatListDetails(value) {
    chatListDetails = value;
    notifyListeners();
  }

  bool isInternetConnected = false;
  bool isTwoWheelerSelected = false;
  bool isFourWheelerSelected = false;

  String? servicerSelectedCountry;

  String gender = 'male';
  int? serviceId;
  int? selectedCountryId;
  int? packageId;
  int? packageAmount;
  // String country
}
