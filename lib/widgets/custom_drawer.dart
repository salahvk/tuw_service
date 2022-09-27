import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/profile_service_man.dart';
import 'package:social_media_services/widgets/customized_drawer_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return DrawerHeader(
        decoration: const BoxDecoration(
          color: ColorManager.primary2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDrawerList(
                title: str.d_my_profile,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.myProfile);
                }),
            CustomDrawerList(
              title: str.d_address,
            ),
            CustomDrawerList(
              title: str.d_become,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return const ProfileServicePage();
                }));
              },
            ),
            CustomDrawerList(
              title: str.d_privacy,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.privacyPolicy);
              },
            ),
            CustomDrawerList(
              title: str.d_logout,
              onTap: () {},
            ),
            const SizedBox(
              height: 150,
            )
          ],
        ));
  }
}
