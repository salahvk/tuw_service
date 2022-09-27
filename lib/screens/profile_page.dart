import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/screens/wishlist.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:social_media_services/widgets/profile_tile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: size.width * 0.6,
        child: const CustomDrawer(),
      ),
      // * Custom bottom Nav
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade400,
                offset: const Offset(6, 1),
              ),
            ]),
          ),
          SizedBox(
            height: 44,
            child: GNav(
              tabMargin: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              gap: 0,
              backgroundColor: ColorManager.whiteColor,
              mainAxisAlignment: MainAxisAlignment.center,
              activeColor: ColorManager.grayDark,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ColorManager.primary.withOpacity(0.4),
              color: ColorManager.black,
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(ImageAssets.homeIconSvg),
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(ImageAssets.chatIconSvg),
                  ),
                ),
              ],
              haptic: true,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homePage, (route) => false);
                // setState(() {
                //   _selectedIndex = index;
                // });
              },
            ),
          ),
          Positioned(
              left: lang == 'ar' ? 5 : null,
              right: lang != 'ar' ? 5 : null,
              bottom: 0,
              child: Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.menu,
                      size: 25,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ))
        ],
      ),
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
                    isNavigationActive: false,
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
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) {
                return const MessagePage();
              }));
            },
            child: const ProfileTitleWidget(
              name: 'Message',
              icon: FontAwesomeIcons.message,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) {
                return const WishList();
              }));
            },
            child: const ProfileTitleWidget(
              name: 'Favourites',
              icon: Icons.favorite_border,
            ),
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
