import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/profile_page.dart';
import 'package:social_media_services/screens/profile_service_page.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/customized_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: size.width * 0.6,
        child: DrawerHeader(
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
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return const ProfilePage();
                    }));
                  },
                ),
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
                ),
                CustomDrawerList(
                  title: 'Logout',
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            )),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 72,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade400,
                offset: const Offset(6, 1),
              ),
            ]),
            child: GNav(
              // rippleColor: Colors.grey[300]!,
              // hoverColor: ColorManager.errorRed,
              tabMargin: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              gap: 0,
              backgroundColor: ColorManager.whiteColor,
              mainAxisAlignment: MainAxisAlignment.center,
              activeColor: ColorManager.grayDark,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ColorManager.primary.withOpacity(0.4),

              color: ColorManager.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  // text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  // text: 'Message',
                ),
                // GButton(
                //   icon: Icons.music_note_sharp,
                //   text: 'Music',
                // ),
                // GButton(
                //   icon: Icons.person,
                //   text: 'Profile',
                // ),
                // GButton(
                //   icon: Icons.home,
                //   text: 'Home',
                // ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Positioned(
              right: 15,
              bottom: 24,
              child: Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 25,
                    color: ColorManager.black,
                  ),
                ),
              ))
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
