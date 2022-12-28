import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/messagePage.dart';

import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String lang = '';
  final List<Widget> _screens = [
    const ServiceHomePage(),
    const MessagePage(
      isHome: true,
    )
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: mobWth
            ? size.width * 0.6
            : smobWth
                ? w * .7
                : w * .75,
        child: const CustomDrawer(),
      ),
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
                      child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: InkWell(
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.chatIconSvg)),
                  ),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                // getChatList(
                //   context,
                // );
                setState(() {
                  _selectedIndex = index;
                });
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
      body: _screens[_selectedIndex],
    );
  }
}
