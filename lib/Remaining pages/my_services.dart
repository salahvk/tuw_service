import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';

class MyServicesPage extends StatefulWidget {
  const MyServicesPage({super.key});

  @override
  State<MyServicesPage> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  String lang = '';
  final int _selectedIndex = 2;

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
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return const HomePage(
                          selectedIndex: 0,
                        );
                      }));
                    },
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.homeIconSvg)),
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.message,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return const HomePage(
                          selectedIndex: 1,
                        );
                      }));
                    },
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(ImageAssets.chatIconSvg)),
                  ),
                ),
              ],
              haptic: true,
              selectedIndex: _selectedIndex,
              // onTabChange: (index) {
              //   setState(() {
              //     _selectedIndex = index;
              //   });
              // },
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 15,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My Services",
                          style: getSemiBoldtStyle(
                              color: ColorManager.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .06,
                ),
                Row(
                  children: [
                    Text(
                      "New Services",
                      style: getSemiBoldtStyle(
                          color: ColorManager.serviceHomeGrey, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .26,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 18, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Colors.grey.shade300,
                                offset: const Offset(5, 8.5),
                              ),
                            ],
                          ),
                          height: size.height * .24,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 30, 25, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            // width: size.width * .2,
                                            child: SvgPicture.asset(
                                          'assets/Asset 38.svg',
                                          color: ColorManager.primary,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  child: SizedBox(
                                      // width: size.width * .2,
                                      child: SvgPicture.asset(
                                'assets/Asset40.svg',
                                color: const Color(0xffe9f4e4),
                              ))),
                              Positioned(
                                bottom: 30,
                                child: Text(
                                  "Auto Car Oil\nService",
                                  style: getMediumtStyle(
                                      color: ColorManager.black, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Row(
                  children: [
                    Text(
                      "Ordered Services",
                      style: getSemiBoldtStyle(
                          color: ColorManager.serviceHomeGrey, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 18, 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.grey.shade300,
                              offset: const Offset(5, 8.5),
                            ),
                          ],
                        ),
                        height: size.height * .16,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 35, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    width: size.width * .23,
                                    height: size.height * .14,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.asset(
                                        height: size.height * .1,
                                        'assets/Asset 38.svg',
                                        color: ColorManager.whiteColor,
                                      ),
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Service 01",
                                    style: getMediumtStyle(
                                        color: ColorManager.primary,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  // Text(
                                  //   "1,999 Paid | 3 month",
                                  //   style: getMediumtStyle(
                                  //       color: ColorManager.paymentPageColor1,
                                  //       fontSize: 12),
                                  // ),
                                  Text(
                                    "Purachase Date : 01/02/2023",
                                    style: getMediumtStyle(
                                        color: ColorManager.paymentPageColor1,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Exp Date: 01/02/2023",
                                    style: getMediumtStyle(
                                        color: ColorManager.paymentPageColor1,
                                        fontSize: 12),
                                  ),
                                  // Container(
                                  //   width: 60,
                                  //   height: 20,
                                  //   decoration: BoxDecoration(
                                  //       color: ColorManager.primary,
                                  //       borderRadius: BorderRadius.circular(5)),
                                  //   child: Center(
                                  //     child: Text(
                                  //       "RENEW",
                                  //       style: getRegularStyle(
                                  //           color: ColorManager.whiteColor,
                                  //           fontSize: 10),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
