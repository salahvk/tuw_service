import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/OTP_screen.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/terms_and_condition.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.36,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: IntroductionLogo(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.grey.shade300,
                    offset: const Offset(5, 8.5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: ColorManager.whiteText,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    height: 64,
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, top: 10, bottom: 10),
                    width: 92,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 12),
                          child: Text(
                            '+976',
                            style: getRegularStyle(
                                color: Colors.black54, fontSize: 17),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: .6,
                          color: ColorManager.grayLight,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 64,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 0, right: 10, top: 20, bottom: 20),
                                hintText: 'Enter Mobile Number',
                                hintStyle: getRegularStyle(
                                    color: ColorManager.grayLight,
                                    fontSize: 15))
                            .copyWith(
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: ColorManager.whiteColor,
                                        width: .5)),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: ColorManager.whiteColor,
                                        width: .5))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
            child: Text(
                "We will send you an OTP for verify your mobile number.",
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.grayLight, fontSize: 15)),
          ),
          Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.5,
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
                      return const OTPscreen();
                    }));
                  },
                  child: Text(
                    'Continue',
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
