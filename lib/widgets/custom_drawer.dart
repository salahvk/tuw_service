import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/screens/profile_service_page.dart';
import 'package:social_media_services/widgets/customized_drawer_list.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: const BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDrawerList(
                title: 'My Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.myProfile);
                }),
            CustomDrawerList(
              title: 'Address Book',
            ),
            CustomDrawerList(
              title: 'Become a Service man',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return const ProfileServicePage();
                }));
              },
            ),
            CustomDrawerList(
              title: 'Privacy Policy',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.privacyPolicy);
              },
            ),
            CustomDrawerList(
              title: 'Logout',
              onTap: () {},
            ),
            const SizedBox(
              height: 150,
            )
          ],
        ));
  }
}
