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
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/utils/getLocalLanguage.dart';
import 'package:social_media_services/widgets/back_button.dart';

import 'package:social_media_services/widgets/language_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            BackButton2(),
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(str.sl_select,
                    style:
                        getBoldtStyle(color: ColorManager.black, fontSize: 20)),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // itemBuilder: (ctx, index) {
                    //   return Padding(
                    //     padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                    //     child: Text("name",
                    //         style: getRegularStyle(
                    //             color: ColorManager.serviceHomeGrey,
                    //             fontSize: 17)),
                    //   );
                    // }
                    itemBuilder: (ctx, index) {
                      final lan = provider.languageModel?.languages?[index];
                      final servicerProvider =
                          Provider.of<ServicerProvider>(context, listen: false);
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
                          await Hive.box("LocalLan").put('lang_id', id ?? '');

                          getlocalLanguage(context);
                          print(servicerProvider.serviceId);
                          await getSubService(
                              context, servicerProvider.serviceId, true);
                          await getCustomerParent(context);
                          await getServiceManDetailsFun(
                              context, servicerProvider.navServiceId);
                          await getActiveServices(context);
                          Navigator.pop(context);
                          // await getHome(context, id: id, changeLan: true);
                          await getHome(
                            context,
                          );
                          setState(() {
                            isLanguageChanging = false;
                          });

                          // setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SizedBox(
                            height: 35,
                            child: LanguageButton(
                              language: lan?.language ?? '',
                              color: selected == lan?.language
                                  ? ColorManager.selectedGreen
                                  : ColorManager.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                isLanguageChanging ? CircularProgressIndicator() : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
