import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/animations/animtions.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/model/get_countries.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/Google%20Map/googleMapScreen.dart';
import 'package:social_media_services/screens/chat_screen.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/servicer_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/servicer_list_tile.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class ServicerPage extends StatefulWidget {
  const ServicerPage({super.key});

  @override
  State<ServicerPage> createState() => _ServicerPageState();
}

class _ServicerPageState extends State<ServicerPage> {
  String? selectedValue;
  final int _selectedIndex = 2;
  final List<Widget> _screens = [const ServiceHomePage(), const MessagePage()];
  String lang = '';

  bool isPickerSelected = false;
  bool isSerDrawerOpened = false;
  bool isAdvancedSearchEnabled = false;

  List<Countries> r2 = [];
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final provider = Provider.of<DataProvider>(context, listen: false);
    //   int? n = provider.countriesModel?.countries?.length;
    //   int i = 0;
    //   while (i < n!.toInt()) {
    //     r2.add(provider.countriesModel!.countries![i].countryName!);
    //     i++;
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      r2 = (provider.countriesModel!.countries)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    final serviceManData = provider.serviceManListModel?.serviceman;

    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    return GestureDetector(
      onTap: () {
        setState(() {
          isPickerSelected = false;
        });
      },
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        endDrawer: SizedBox(
          height: size.height * 0.825,
          width: isSerDrawerOpened ? size.width * 0.54 : size.width * 0.6,
          child: isSerDrawerOpened ? const SerDrawer() : const CustomDrawer(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  left: lang == 'ar' ? 5 : null,
                  right: lang != 'ar' ? 5 : null,
                  bottom: 0,
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        setState(() {
                          isSerDrawerOpened = false;
                        });
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
                child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: 48,
                                  width: size.width * .8,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 8, 10, 8),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      String.fromCharCode(Icons
                                                          .search.codePoint),
                                                      style: TextStyle(
                                                        inherit: false,
                                                        color: ColorManager
                                                            .primary,
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: Icons
                                                            .search.fontFamily,
                                                        package: Icons
                                                            .search.fontPackage,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hintText: str.s_servicer,
                                            hintStyle: getRegularStyle(
                                                color: const Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize:
                                                    Responsive.isMobile(context)
                                                        ? 15
                                                        : 10)),
                                      ),
                                    ),
                                  )),

                              // * Filter icon
                              SizedBox(
                                width: Responsive.isMobile(context) ? 10 : 5,
                              ),
                              Builder(
                                builder: (context) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSerDrawerOpened = true;
                                    });

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
                          // * Country & Region
                          isAdvancedSearchEnabled
                              ? FadeCustomAnimation(
                                  delay: .001,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: TitleWidget(
                                                    name: str.s_country),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 10.0,
                                                        color: Colors
                                                            .grey.shade300,
                                                        // offset: const Offset(5, 8.5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    width: size.width * .44,
                                                    height: mob ? 50 : 35,
                                                    decoration: BoxDecoration(
                                                        color: ColorManager
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: TextField(
                                                      // onTap: () {
                                                      //   setState(() {
                                                      //     isPickerSelected = true;
                                                      //   });
                                                      // },
                                                      onChanged: (value) async {
                                                        setState(() {
                                                          isPickerSelected =
                                                              true;
                                                        });
                                                        String capitalize(
                                                                String s) =>
                                                            s[0].toUpperCase() +
                                                            s.substring(1);

                                                        if (value.isEmpty) {
                                                          r2 = [];
                                                          setState(() {
                                                            r2 = (provider
                                                                .countriesModel!
                                                                .countries)!;
                                                          });
                                                        } else {
                                                          final lower =
                                                              capitalize(value);

                                                          onSearchChanged(
                                                              lower);
                                                        }

                                                        // print(r);
                                                      },
                                                      style: const TextStyle(),
                                                      controller:
                                                          EditProfileControllers
                                                              .countryController,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              str.e_country_h,
                                                          hintStyle: getRegularStyle(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  173,
                                                                  173,
                                                                  173),
                                                              fontSize: mob
                                                                  ? 15
                                                                  : 10)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: TitleWidget(
                                                    name: str.s_region),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Container(
                                                  width: size.width * .44,
                                                  height: mob ? 50 : 35,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 10.0,
                                                        color: Colors
                                                            .grey.shade300,
                                                        // offset: const Offset(5, 8.5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextField(
                                                    // style: const TextStyle(),
                                                    controller:
                                                        ServiceControllers
                                                            .regionController,
                                                    decoration: InputDecoration(
                                                        hintText: str.s_region,
                                                        hintStyle: getRegularStyle(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                173,
                                                                173,
                                                                173),
                                                            fontSize: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 15
                                                                : 10)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // * Google map
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: TitleWidget(
                                                    name: str.s_map),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Container(
                                                  width: size.width * .44,
                                                  height: mob ? 50 : 35,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 10.0,
                                                        color: Colors
                                                            .grey.shade300,
                                                        // offset: const Offset(5, 8.5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: TextField(
                                                    // style: const TextStyle(),
                                                    controller:
                                                        ServiceControllers
                                                            .mapController,
                                                    decoration: InputDecoration(
                                                        suffixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(6.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (ctx) {
                                                                return const GoogleMapScreen();
                                                              }));
                                                            },
                                                            child: Container(
                                                                width: mob
                                                                    ? 30
                                                                    : 20,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: ColorManager
                                                                      .primary,
                                                                ),
                                                                height: mob
                                                                    ? 30
                                                                    : 25,
                                                                child: Icon(
                                                                  Icons
                                                                      .add_location_alt_outlined,
                                                                  color: ColorManager
                                                                      .whiteColor,
                                                                  size: mob
                                                                      ? 20
                                                                      : 15,
                                                                )),
                                                          ),
                                                        ),
                                                        hintText: 'Map',
                                                        hintStyle: getRegularStyle(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                173,
                                                                173,
                                                                173),
                                                            fontSize: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 15
                                                                : 10)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Column(
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     MandatoryHeader(heading: str.s_state),
                                          //     Padding(
                                          //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          //       child: Container(
                                          //         decoration: BoxDecoration(
                                          //           boxShadow: [
                                          //             BoxShadow(
                                          //               blurRadius: 10.0,
                                          //               color: Colors.grey.shade300,
                                          //               // offset: const Offset(5, 8.5),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //         child: Container(
                                          //           width: size.width * .44,
                                          //           height: mob ? 50 : 35,
                                          //           decoration: BoxDecoration(
                                          //               color: ColorManager.whiteColor,
                                          //               borderRadius: BorderRadius.circular(4)),
                                          //           child: DropdownButtonHideUnderline(
                                          //             child: DropdownButton2(
                                          //               icon: const Icon(
                                          //                 Icons.keyboard_arrow_down,
                                          //                 size: 35,
                                          //                 color: ColorManager.black,
                                          //               ),
                                          //               hint: Text(str.s_state,
                                          //                   style: getRegularStyle(
                                          //                       color: const Color.fromARGB(
                                          //                           255, 173, 173, 173),
                                          //                       fontSize:
                                          //                           Responsive.isMobile(context)
                                          //                               ? 15
                                          //                               : 10)),
                                          //               items: items
                                          //                   .map((item) =>
                                          //                       DropdownMenuItem<String>(
                                          //                         value: item,
                                          //                         child: Text(item,
                                          //                             style: getRegularStyle(
                                          //                                 color: ColorManager
                                          //                                     .black,
                                          //                                 fontSize: 15)),
                                          //                       ))
                                          //                   .toList(),
                                          //               value: selectedValue,
                                          //               onChanged: (value) {
                                          //                 setState(() {
                                          //                   selectedValue = value as String;
                                          //                 });
                                          //               },
                                          //               buttonHeight: 40,
                                          //               // buttonWidth: 140,
                                          //               itemHeight: 40,
                                          //               buttonPadding:
                                          //                   const EdgeInsets.fromLTRB(
                                          //                       12, 0, 8, 0),
                                          //               // dropdownWidth: size.width,
                                          //               itemPadding: const EdgeInsets.fromLTRB(
                                          //                   12, 0, 12, 0),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                  child: TitleWidget(
                                                      name: str.s_state),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                  child: Container(
                                                    width: size.width * .44,
                                                    height: mob ? 50 : 35,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 10.0,
                                                          color: Colors
                                                              .grey.shade300,
                                                          // offset: const Offset(5, 8.5),
                                                        ),
                                                      ],
                                                    ),
                                                    child: TextField(
                                                      // style: const TextStyle(),
                                                      controller:
                                                          ServiceControllers
                                                              .stateController,
                                                      decoration: InputDecoration(
                                                          hintText: str.s_state,
                                                          hintStyle: getRegularStyle(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  173,
                                                                  173,
                                                                  173),
                                                              fontSize: Responsive
                                                                      .isMobile(
                                                                          context)
                                                                  ? 15
                                                                  : 10)),
                                                    ),
                                                  ),
                                                ),
                                              ])
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: size.width,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Search",
                                              style: getSemiBoldtStyle(
                                                  color:
                                                      ColorManager.whiteColor,
                                                  fontSize: 15),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isAdvancedSearchEnabled = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorManager.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          width: size.width,
                                          height: 30,
                                          child: const Icon(
                                              Icons.keyboard_arrow_up),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isAdvancedSearchEnabled = true;
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorManager.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      width: size.width,
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Advanced Search',
                                            style: getRegularStyle(
                                                color: ColorManager.black,
                                                fontSize: 12),
                                          ),
                                          const Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: InkWell(
                                    onTap: () {
                                      print(serviceManData?[index].toJson());
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return ChatScreen(
                                            serviceman: serviceManData![index]);
                                      }));
                                    },
                                    child: ServicerListTile(
                                      serviceman: serviceManData![index],
                                    )),
                              );
                            }),
                            itemCount: serviceManData?.length ?? 0,
                          ),
                          // Padding(
                          //   padding: mob
                          //       ? const EdgeInsets.fromLTRB(0, 5, 0, 10)
                          //       : const EdgeInsets.fromLTRB(0, 4, 0, 4),
                          //   child: mob
                          //       ? ElevatedButton(
                          //           onPressed: () {
                          //             // player.stop();
                          //           },
                          //           style: ElevatedButton.styleFrom(
                          //               padding: const EdgeInsets.fromLTRB(
                          //                   30, 0, 30, 0)),
                          //           child: Text(
                          //             str.s_continue,
                          //             style: getRegularStyle(
                          //                 color: ColorManager.whiteText,
                          //                 fontSize: 16),
                          //           ))
                          //       : Container(
                          //           width: 100,
                          //           height: 25,
                          //           decoration: BoxDecoration(
                          //               color: ColorManager.primary,
                          //               borderRadius: BorderRadius.circular(3)),
                          //           child: Center(
                          //             child: Text(
                          //               str.s_continue,
                          //               style: getRegularStyle(
                          //                   color: ColorManager.whiteText,
                          //                   fontSize: 12),
                          //             ),
                          //           ),
                          //         ),
                          // ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                  isPickerSelected
                      ? Positioned(
                          top: mob ? size.height * .19 : 140,
                          // top: size.height * .458,
                          right: lang == 'ar' ? size.width * .05 : null,
                          left: lang != 'ar' ? size.width * .05 : null,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey.shade300,
                                  offset: const Offset(3, 8.5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: ColorManager.primary2,
                                ),
                                height: 110,
                                width: 160,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          itemCount: r2.length,
                                          itemBuilder: (ctx, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // countryid =
                                                  //     r1[index].countryId;
                                                  // r1 = (provider
                                                  //     .countriesModel!
                                                  //     .countries)!;
                                                  isPickerSelected = false;
                                                });
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // countryid =
                                                    //     r1[index].countryId;
                                                    EditProfileControllers
                                                            .countryController
                                                            .text =
                                                        r2[index].countryName ??
                                                            '';
                                                    isPickerSelected = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 25,
                                                  color: ColorManager.primary2,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 5, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            r2[index]
                                                                    .countryName ??
                                                                '',
                                                            style: getSemiBoldtStyle(
                                                                color: ColorManager.background,
                                                                fontSize: r2[index].countryName!.length < 12
                                                                    ? 12
                                                                    : r2[index].countryName!.length < 20
                                                                        ? 10
                                                                        : r2[index].countryName!.length > 25
                                                                            ? 8
                                                                            : 10)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              )),
      ),
    );
  }

  onSearchChanged(String query) {
    setState(() {
      r2 = [];
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(microseconds: 200), () {
      s(query);
    });
  }

  s(filter) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    provider.countriesModel?.countries?.forEach((element) {
      final m = element.countryName?.contains(filter);

      if (m == true) {
        setState(() {
          // r = [];
          r2.add(element);
        });
      }

      final phoneCode = element.phonecode?.toString().contains(filter);

      if (phoneCode == true) {
        setState(() {
          // r = [];
          r2.add(element);
        });
      }
    });
  }
}
