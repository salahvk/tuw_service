import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/language_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  String selected = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              // height: size.height * 0.36,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.04),
                  // child: const IntroductionLogo(),
                  // child: SvgPicture.asset('assets/logo/app_logo_green.svg'),
                ),
              ),
            ),
            Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                //   child: Text('Tuw Services',
                //       // str.l_heading
                //       style: GoogleFonts.robotoSlab(
                //           textStyle: const TextStyle(
                //               color: Color(0xff16a64c),
                //               fontSize: 25,
                //               shadows: [
                //             Shadow(
                //               blurRadius: 18.0,
                //               color: Color.fromARGB(255, 218, 214, 214),
                //               offset: Offset(0, 6.5),
                //             ),
                //           ]))),
                // ),
                SizedBox(
                  height: size.height * .15,
                ),
                SizedBox(
                    width: size.width * .6,
                    height: size.height * .3,
                    child: SvgPicture.asset('assets/logo/app_logo_green.svg')),
                Padding(
                  // padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),

                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(str.l_description,
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(str.l_description2,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: ColorManager.grayLight, fontSize: 16)),
                ),
                SizedBox(
                    height: 32,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final lan = provider.languageModel?.languages?[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.phoneNumber);
                            setState(() {
                              selected = lan?.language ?? '';
                            });
                            Hive.box("LocalLan")
                                .put('lang', lan?.shortcode ?? '');
                            String? id = provider
                                .languageModel?.languages?[index].id
                                .toString();
                            Hive.box("LocalLan").put('lang_id', id ?? '');
                          },
                          child: LanguageButton(
                            language: lan?.language ?? '',
                            color: selected == lan?.language
                                ? ColorManager.selectedGreen
                                : ColorManager.primary,
                          ),
                        );
                      },
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
