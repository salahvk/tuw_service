import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/logout.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/screens/Address%20page/address_page.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/profile_service_man.dart';
import 'package:social_media_services/screens/profile_page.dart';
import 'package:social_media_services/utils/initPlatformState.dart';
import 'package:social_media_services/widgets/customized_drawer_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String lang = '';
  bool loading = false;
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);

    return Container(
        decoration: BoxDecoration(
          color: ColorManager.primary3,
          borderRadius: lang == 'ar'
              ? const BorderRadius.only(
                  topRight: Radius.circular(8), bottomRight: Radius.circular(8))
              : const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        // margin: const EdgeInsets.all(0.0),
        // padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDrawerList(
                title: str.d_my_profile,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return const ProfilePage();
                    },
                  ), (route) => false);
                }),
            CustomDrawerList(
              title: str.d_address,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return const AddressPage();
                }));
              },
            ),
            CustomDrawerList(
              title:
                  provider.viewProfileModel?.userdetails?.userType == 'customer'
                      ? str.d_become
                      : str.d_add_service,
              onTap: becomeService,
            ),
            CustomDrawerList(
              title: str.d_privacy,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.privacyPolicy);
              },
            ),
            loading
                ? Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(10),
                    child: const LinearProgressIndicator(
                        // value: 0.7,
                        ))
                : CustomDrawerList(
                    title: str.d_logout,
                    onTap: logOUtFunction,
                  ),
            // const SizedBox(
            //   height: 150,
            // )
          ],
        ));
  }

  logOUtFunction() async {
    allowfunction(context);
    // showDialog(
    //     context: context,
    //     builder: (context) => const DialogueBox(),
    //     barrierDismissible: false);
  }

  allowfunction(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await logoutFun(context);
    await Hive.box("token").clear();
    callInitFunction(context);
  }

  callInitFunction(context) async {
    await initPlatformState(context);
  }

  becomeService() {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return const ProfileServicePage();
      },
    ), (route) => false);
  }
}
