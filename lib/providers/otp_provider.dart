import 'package:flutter/cupertino.dart';
import 'package:social_media_services/model/otp/get_otp.dart';
import 'package:social_media_services/model/otp/otp_verification.dart';

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

  GetOtp? getOtp;

  void getOtpData(value) {
    getOtp = value;
    notifyListeners();
  }

  OtpVerification? otpVerification;

  void getOtpVerifiedData(value) {
    otpVerification = value;
    notifyListeners();
  }

  String? userCountryName;
}
