import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:social_media_services/widgets/profile_tile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
              height: size.height * 0.36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: ProfileImage(
                    iconSize: 18,
                    profileSize: 60,
                    iconRadius: 17,
                  )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Text('Prithvina Raj',
                        style: getBoldtStyle(
                            color: ColorManager.black, fontSize: 20)),
                  ),
                  Text('#1845678',
                      style: getRegularStyle(
                          color: const Color(0xff6e6e6e), fontSize: 14)),
                ],
              )),
          const ProfileTitleWidget(
            name: 'My Profile',
            icon: Icons.person_outline,
          ),
          const ProfileTitleWidget(
            name: 'Message',
            icon: FontAwesomeIcons.message,
          ),
          const ProfileTitleWidget(
            name: 'Favourites',
            icon: Icons.favorite_border,
          ),
          const ProfileTitleWidget(
            name: 'Address Book',
            icon: Icons.pin_drop_outlined,
          ),
          const ProfileTitleWidget(
            name: 'Settings',
            icon: Icons.settings_outlined,
          )
        ],
      )),
    );
  }
}
