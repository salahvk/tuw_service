import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/controllers.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/otp_verification.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/otp_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/utils/pinTheme.dart';
import 'package:social_media_services/screens/edit_profile_screen.dart';
import 'package:social_media_services/utils/snack_bar.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class OTPscreen extends StatefulWidget {
  const OTPscreen({Key? key}) : super(key: key);

  @override
  State<OTPscreen> createState() => _OTPscreenState();
}

class _OTPscreenState extends State<OTPscreen> {
  // final defaultPinTheme = pintheme;

  @override
  Widget build(BuildContext context) {
    // final focusedPinTheme = focusedTheme;
    final h = MediaQuery.of(context).size.height;
    final OtpProvider = Provider.of<OTPProvider>(context, listen: false);
    final str = AppLocalizations.of(context)!;
    final mob = Responsive.isMobile(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: Responsive.isMini(context) ? h * 0.46 : h * .36,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const IntroductionLogo(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, h * .04, 0, 0),
                      child: Text(str.o_verification,
                          style: getBoldtStyle(
                              color: ColorManager.black, fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                          "${str.o_pls_type} \n+${OtpProvider.countryCode} ${OtpProvider.phoneNo}",
                          textAlign: TextAlign.center,
                          style: getRegularStyle(
                              color: const Color(0xff9f9f9f),
                              fontSize: mob ? 15 : 12)),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10, h * .03, 10, 0),
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                separator: const SizedBox(
                  width: 5,
                ),
                length: 6,
                controller: otpCon,
                focusedPinTheme: focusedPinTheme,
                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  print('object');
                  verifyNow();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, h * .05, 0, h * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(str.o_dont,
                      style: getRegularStyle(
                          color: const Color(0xff9f9f9f), fontSize: 15)),
                  Text(str.o_resend,
                      style: getRegularStyle(
                          color: ColorManager.primary, fontSize: 15)),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade400,
                      offset: const Offset(6, 6),
                    ),
                  ],
                ),
                width: 220,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: verifyNow,
                    child: Text(
                      str.o_verify,
                      style: getRegularStyle(
                          color: ColorManager.whiteText, fontSize: 18),
                    ))),
            // const TroubleSign(),
            // const Spacer(),
            SizedBox(
              height: Responsive.isMobile(context) ? h * .24 : h * .04,
            ),
            const TermsAndCondition()
          ],
        ),
      )),
    );
  }

  verifyNow() {
    FocusManager.instance.primaryFocus?.unfocus();
    final str = AppLocalizations.of(context)!;
    if (otpCon.text.length < 6 || otpCon.text != '123456') {
      AnimatedSnackBar.material(str.o_snack,
              type: AnimatedSnackBarType.error,
              borderRadius: BorderRadius.circular(6),
              // brightness: Brightness.dark,
              duration: const Duration(seconds: 1))
          .show(
        context,
      );
    } else {
      verifyOtpApi();
    }
  }

  verifyOtpApi() async {
    final otpProvider = Provider.of<OTPProvider>(context, listen: false);
    final provider = Provider.of<DataProvider>(context, listen: false);
    try {
      var response = await http.post(
          Uri.parse(
              "$apiUser/otp_verification?countrycode=${otpProvider.countryCode}&phone=${otpProvider.phoneNo}&otp=${otpProvider.getOtp?.oTP.toString()}"),
          headers: {"device-id": provider.deviceId ?? ''});
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("Otp Verified Response");
        print(jsonResponse);
        var otpVerifiedData = OtpVerification.fromJson(jsonResponse);
        otpProvider.getOtpVerifiedData(otpVerifiedData);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
          return const EditProfileScreen();
        }), (route) => false);
      } else {
        print('Something went wrong');
      }
    } on Exception catch (_) {
      showSnackBar("Something Went Wrong", context);
    }
  }
}
