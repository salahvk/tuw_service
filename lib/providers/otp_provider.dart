import 'package:flutter/cupertino.dart';

class OTPProvider with ChangeNotifier {
  String? countryCode;

  void getCountryCode(value) {
    countryCode = value;
    notifyListeners();
  }

  String? phoneNo;

  void getPhoneNo(value) {
    phoneNo = value;
    notifyListeners();
  }
}
