import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/screens/how.dart';
import 'package:social_media_services/utils/get_location.dart';
import 'package:social_media_services/widgets/language_button.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  String selected = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      requestExplorerLocationPermission(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    //  else if (provider.viewProfileModel?.userdetails?.latitude == null &&
    //     provider.explorerLat == null)
    // {
    //   String? apiToken = Hive.box("token").get('api_token');
    //   if (apiToken == null) {
    //     requestExplorerLocationPermission(context);
    //   } else {
    //     requestLocationPermission(
    //       context,
    //     );
    //   }

    //   Navigator.pop(context);

    // AnimatedSnackBar.material(str.snack_get_location,
    //         type: AnimatedSnackBarType.info,
    //         borderRadius: BorderRadius.circular(6),
    //         duration: const Duration(seconds: 1))
    //     .show(
    //   context,
    // );
    // await Future.delayed(const Duration(seconds: 2));

    // AnimatedSnackBar.material(str.snack_done,
    //         type: AnimatedSnackBarType.success,
    //         borderRadius: BorderRadius.circular(6),
    //         duration: const Duration(seconds: 3))
    //     .show(
    //   context,
    // );
    // }
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
                SizedBox(
                  height: size.height * .15,
                ),
                SizedBox(
                    width: size.width * .6,
                    height: size.height * .3,
                    child: SvgPicture.asset('assets/logo/app_logo_shadow.svg')),
                SizedBox(
                  height: size.height * .05,
                ),
                SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        final lan = provider.languageModel?.languages?[index];
                        return InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, Routes.phoneNumber);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return const HowToWorkPage();
                            }));
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
