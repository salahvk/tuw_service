import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/messagePage.dart';

import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/utils/bottom_nav.dart';
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
        // isHome: true,
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    print("did");
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
      bottomNavigationBar: BottomNavigationWidget(),
      body: ValueListenableBuilder<int>(
        valueListenable: currentIndexNotifier,
        builder: (context, index, _) {
          print("object");
          return _screens[index];
        },
      ),
    );
  }
}
