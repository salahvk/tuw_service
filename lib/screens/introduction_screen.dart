import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/mobile_number_screen.dart';
import 'package:social_media_services/widgets/introduction_logo.dart';
import 'package:social_media_services/widgets/language_button.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text('Social Media Services',
                        style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                                color: Color(0xff16a64c),
                                fontSize: 25,
                                shadows: [
                              Shadow(
                                blurRadius: 18.0,
                                color: Color.fromARGB(255, 218, 214, 214),
                                offset: Offset(0, 6.5),
                              ),
                            ]))
                        // getRegularStyle(color: Color(0xff16a64c), fontSize: 25),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 33, 0, 15),
                    child: Text(
                      'Choose Any Language',
                      style: getRegularStyle(
                          // const Color(0xff707070)
                          color: ColorManager.grayLight,
                          fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LanguageButton(
                        language: 'English',
                      ),
                      LanguageButton(
                        language: 'Arabic',
                      ),
                      LanguageButton(
                        language: 'Hindi',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 33, 0, 20),
                    child: Text("Lorem Ipsum has industry's \nstandard dummy",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSlab(
                            textStyle: TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                shadows: [
                              Shadow(
                                blurRadius: 15.0,
                                color: Colors.grey.shade400,
                                offset: const Offset(0, 6.5),
                              ),
                            ]))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                    child: Text(
                        "Lorem Ipsum has been the industry's  \nstandard dummy",
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            color: ColorManager.grayLight, fontSize: 16)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey.shade400,
                          offset: const Offset(6, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return const PhoneNumberScreen();
                        }));
                      },
                      child: Text('Get Started',
                          style: getRegularStyle(
                              color: ColorManager.whiteColor, fontSize: 18)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
