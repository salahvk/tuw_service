import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/mandatory_widget.dart';
import 'package:social_media_services/widgets/ser_status_custom_drawer.dart';
import 'package:social_media_services/widgets/servicer_list_tile.dart';

class ServicerPage extends StatefulWidget {
  const ServicerPage({super.key});

  @override
  State<ServicerPage> createState() => _ServicerPageState();
}

class _ServicerPageState extends State<ServicerPage> {
  String? selectedValue;
  final int _selectedIndex = 2;
  final List<Widget> _screens = [ServiceHomePage(), const MessagePage()];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawer: SizedBox(
        height: size.height * 0.825,
        width: size.width * 0.54,
        child: const SerDrawer(),
      ),
      //   drawerEnableOpenDragGesture: false,
      // endDrawer: SizedBox(
      //   height: size.height * 0.825,
      //   width: size.width * 0.6,
      //   child: const CustomDrawer(),
      // ),
      // * Custom bottom Nav
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homePage, (route) => false);
        },
        child: Stack(
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
                      child: Image.asset(
                        ImageAssets.homeIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GButton(
                    icon: FontAwesomeIcons.message,
                    leading: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(ImageAssets.chatIcon,
                            fit: BoxFit.cover)),
                  ),
                ],
                haptic: true,
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.homePage, (route) => false);
                  }

                  // setState(() {
                  //   _selectedIndex = index;
                  // });
                },
              ),
            ),
            Positioned(
                right: 5,
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
      ),
      body: _selectedIndex != 2
          ? _screens[_selectedIndex]
          : SafeArea(
              child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 48,
                          width: size.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: TextField(
                                // focusNode: nfocus,
                                style: const TextStyle(),
                                // controller: nameController,
                                decoration: InputDecoration(
                                    suffixIcon: SizedBox(
                                      width: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: .5,
                                            height: 48,
                                            color: const Color.fromARGB(
                                                255, 206, 205, 205),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 8, 10, 8),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              String.fromCharCode(
                                                  Icons.search.codePoint),
                                              style: TextStyle(
                                                inherit: false,
                                                color: ColorManager.primary,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    Icons.search.fontFamily,
                                                package:
                                                    Icons.search.fontPackage,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Servicer',
                                    hintStyle: getRegularStyle(
                                        color: const Color.fromARGB(
                                            255, 173, 173, 173),
                                        fontSize: 15)),
                              ),
                            ),
                          )),

                      // * Filter icon
                      const SizedBox(
                        width: 10,
                      ),
                      Builder(
                        builder: (context) => InkWell(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey.shade300,
                                  // offset: const Offset(5, 8.5),
                                ),
                              ],
                            ),
                            width: size.width * .09,
                            height: 38,
                            child: const Icon(
                              Icons.filter_alt,
                              size: 25,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // * Region
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MandatoryHeader(heading: 'Country'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: size.width * .44,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 35,
                                        color: ColorManager.black,
                                      ),
                                      hint: Text('Country',
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      // buttonWidth: 140,
                                      itemHeight: 40,
                                      buttonPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 8, 0),
                                      // dropdownWidth: size.width,
                                      itemPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 12, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MandatoryHeader(heading: 'Region'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              width: size.width * .44,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: TextField(
                                // style: const TextStyle(),
                                controller: stateController,
                                decoration: InputDecoration(
                                    hintText: 'Region',
                                    hintStyle: getRegularStyle(
                                        color: const Color.fromARGB(
                                            255, 173, 173, 173),
                                        fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
// * Google map
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MandatoryHeader(heading: 'Map'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: size.width * .44,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: ColorManager.primary,
                                          ),
                                          height: 30,
                                          child: const Icon(
                                            Icons.add_location_alt_outlined,
                                            color: ColorManager.whiteColor,
                                          )),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MandatoryHeader(heading: 'Region'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Colors.grey.shade300,
                                    // offset: const Offset(5, 8.5),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: size.width * .44,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 35,
                                        color: ColorManager.black,
                                      ),
                                      hint: Text('State',
                                          style: getRegularStyle(
                                              color: const Color.fromARGB(
                                                  255, 173, 173, 173),
                                              fontSize: 15)),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: getRegularStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: 15)),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      // buttonWidth: 140,
                                      itemHeight: 40,
                                      buttonPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 8, 0),
                                      // dropdownWidth: size.width,
                                      itemPadding: const EdgeInsets.fromLTRB(
                                          12, 0, 12, 0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.chatScreen);
                              },
                              child: const ServicerListTile()),
                        );
                      }),
                      itemCount: 6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: ElevatedButton(
                        onPressed: () {
                          // player.stop();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0)),
                        child: Text(
                          "Continue",
                          style: getRegularStyle(
                              color: ColorManager.whiteText, fontSize: 16),
                        )),
                  ),
                ],
              ),
            )),
    );
  }
}
