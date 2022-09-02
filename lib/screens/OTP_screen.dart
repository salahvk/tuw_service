import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/utils/pinTheme.dart';
import 'package:social_media_services/screens/edit_profile_screen.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: size.height * 0.36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const IntroductionLogo(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Text('Verification Code',
                        style: getBoldtStyle(
                            color: ColorManager.black, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                        "Please type the verification code send to \n+976 1234 123 123",
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: const Color(0xff9f9f9f), fontSize: 15)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Pinput(
              defaultPinTheme: defaultPinTheme,
              separator: const SizedBox(
                width: 20,
              ),
              focusedPinTheme: focusedPinTheme,
              validator: (s) {
                return s == '2222' ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't get the code? ",
                    style: getRegularStyle(
                        color: const Color(0xff9f9f9f), fontSize: 15)),
                Text('Resend',
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return const EditProfileScreen();
                    }));
                  },
                  child: Text(
                    'Verify Now',
                    style: getRegularStyle(
                        color: ColorManager.whiteText, fontSize: 18),
                  ))),
          // const TroubleSign(),
          const Spacer(),
          const TermsAndCondition()
        ],
      )),
    );
  }
}
