import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/customerParent.dart';
import 'package:social_media_services/API/get_active_services.dart';
import 'package:social_media_services/API/get_serviceManProfileDetails.dart';
import 'package:social_media_services/API/home/get_home.dart';
import 'package:social_media_services/API/home/get_subService.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/model/active_services.dart';

import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';
import 'package:social_media_services/widgets/backbutton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/language_button.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String selected = '';
  bool isLanguageChanging = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final str = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BackButton2(),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Color(0xff08dc2c),
                          child: Image.asset(
                            'assets/logo/app-logo-T.jpg',
                            height: 30,
                            width: 30,
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(str.sl_select,
                      style: getBoldtStyle(
                          color: ColorManager.black, fontSize: 20)),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 300,
                //   child: ListView.builder(
                //     itemCount: 3,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     // itemBuilder: (ctx, index) {
                //     //   return Padding(
                //     //     padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                //     //     child: Text("name",
                //     //         style: getRegularStyle(
                //     //             color: ColorManager.serviceHomeGrey,
                //     //             fontSize: 17)),
                //     //   );
                //     // }
                //     itemBuilder: (ctx, index) {
                //       final lan = provider.languageModel?.languages?[index];
                //       final servicerProvider =
                //           Provider.of<ServicerProvider>(context, listen: false);
                //       final serviceManData =
                //           provider.serviceManListModel?.serviceman;
                //       return InkWell(
                // onTap: () async {

                // setState(() {});
                // },
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 5, bottom: 5),
                //           child: SizedBox(
                //             height: 35,
                //             child: LanguageButton(
                //               language: lan?.language ?? '',
                //               color: selected == lan?.language
                //                   ? ColorManager.selectedGreen
                //                   : ColorManager.primary,
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                Center(
                  child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          // final lan = provider.languageModel?.languages?[index];
                          final lan = provider.languageModel?.languages?[index];
                          final servicerProvider =
                              Provider.of<ServicerProvider>(context,
                                  listen: false);
                          final serviceManData =
                              provider.serviceManListModel?.serviceman;
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                isLanguageChanging = true;
                                selected = lan?.language ?? '';
                              });
                              print(selected);
                              await Hive.box("LocalLan")
                                  .put('lang', lan?.shortcode ?? '');

                              String? id = provider
                                  .languageModel?.languages?[index].id
                                  .toString();
                              await Hive.box("LocalLan")
                                  .put('lang_id', id ?? '');

                              getlocalLanguage(context);
                              print(servicerProvider.serviceId);
                              await getSubService(context,
                                  servicerProvider.serviceId, true, Services());
                              await getCustomerParent(context);
                              await getServiceManDetailsFun(
                                  context, servicerProvider.navServiceId);
                              await getActiveServices(context);
                              // Navigator.pushAndRemoveUntil(context, newRouteName, (route) => false);
                              navigateToHome(context);
                              // await getHome(context, id: id, changeLan: true);
                              await getHome(
                                context,
                              );
                              setState(() {
                                isLanguageChanging = false;
                              });
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
                ),
                isLanguageChanging ? CircularProgressIndicator() : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
      return const HomePage();
    }), (route) => false);
  }
}
