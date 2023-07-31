import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';

ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

class BottomNavigationWidget extends StatefulWidget {
  bool isInsidePage;
  int? currendIndex;
  final int selectedIndex;
  BottomNavigationWidget(
      {Key? key,
      this.isInsidePage = false,
      this.currendIndex,
      this.selectedIndex = 0})
      : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 2;
  String lang = '';
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    print("did");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndexNotifier,
      builder: (BuildContext context, int newIndex, _) {
        return Stack(
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
                    // text: ' Home',
                    icon: FontAwesomeIcons.message,
                    leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                  ),
                  GButton(
                    icon: FontAwesomeIcons.message,
                    // text: ' Chat',
                    leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.chatIconSvg)),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  // getChatList(
                  //   context,
                  // );
                  // print(index);
                  // setState(() {
                  //   _selectedIndex = index;
                  // });
                  print(index);

                  widget.isInsidePage
                      ? Navigator.of(context).popUntil((route) => route.isFirst)
                      : null;
                  currentIndexNotifier.value = index;
                  // if (index == 1) {
                  //   setState(() {
                  //     _selectedIndex = 1;
                  //   });
                  // }
                  print(_selectedIndex);
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
        );
      },
    );
  }
}
