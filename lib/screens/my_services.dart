import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/becomeServiceMan/customerParent.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/choose_more_services_page.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCustomerParent(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DataProvider>(context, listen: false);
    final homeData = provider.homeModel?.services;
    final mob = Responsive.isMobile(context);
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    final str = AppLocalizations.of(context)!;
    print(mobWth);
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
            padding: lang == 'ar'
                ? const EdgeInsets.fromLTRB(0, 0, 18, 0)
                : const EdgeInsets.fromLTRB(18, 0, 0, 0),
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
                          str.ms_my,
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
                      str.ms_new,
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
                    itemCount: homeData?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print(homeData?[index].service);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return ChooseMoreServicePage(
                              services: homeData?[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: lang == 'ar'
                              ? const EdgeInsets.fromLTRB(18, 10, 0, 10)
                              : const EdgeInsets.fromLTRB(0, 10, 18, 10),
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
                                              width: mob ? 70.0 : 50,
                                              height: mob ? 70.0 : 50,
                                              child: SvgPicture.network(
                                                '$endPoint${homeData?[index].image}',
                                                color: ColorManager.primary2,
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
                                  child: Text(homeData![index].service ?? '',
                                      // maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: getMediumtStyle(
                                          color: ColorManager.black,
                                          fontSize:
                                              homeData[index].service!.length >
                                                      13
                                                  ? 13
                                                  : 15)),
                                ),
                              ],
                            ),
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
                      str.ms_ordered,
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
                  itemCount: provider.activeServices?.services?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: lang == 'ar'
                          ? const EdgeInsets.fromLTRB(18, 10, 0, 10)
                          : const EdgeInsets.fromLTRB(0, 10, 18, 10),
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
                                padding: mobWth
                                    ? const EdgeInsets.fromLTRB(25, 0, 35, 0)
                                    : smobWth
                                        ? const EdgeInsets.fromLTRB(
                                            20, 0, 20, 0)
                                        : const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    width: size.width * .23,
                                    height: size.height * .14,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: SvgPicture.network(
                                        height: size.height * .1,
                                        '$endPoint${provider.activeServices?.services?[index].serviceImage}',
                                        color: ColorManager.whiteColor,
                                      ),
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.activeServices?.services?[index]
                                            .serviceName ??
                                        '',
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
                                  Row(
                                    children: [
                                      Text(
                                        str.ms_Sub,
                                        style: getSemiBoldtStyle(
                                            color:
                                                ColorManager.paymentPageColor1,
                                            fontSize: mobWth
                                                ? 12
                                                : smobWth
                                                    ? 11
                                                    : 10),
                                      ),
                                      Text(
                                        " ${provider.activeServices?.services?[index].subscriptionDate}",
                                        style: getMediumtStyle(
                                            color:
                                                ColorManager.paymentPageColor1,
                                            fontSize: mobWth
                                                ? 12
                                                : smobWth
                                                    ? 11
                                                    : 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        str.ms_exp,
                                        style: getSemiBoldtStyle(
                                            color:
                                                ColorManager.paymentPageColor1,
                                            fontSize: mobWth
                                                ? 12
                                                : smobWth
                                                    ? 11
                                                    : 10),
                                      ),
                                      Text(
                                        " ${provider.activeServices?.services?[index].expiryDate}",
                                        style: getMediumtStyle(
                                            color:
                                                ColorManager.paymentPageColor1,
                                            fontSize: mobWth
                                                ? 12
                                                : smobWth
                                                    ? 11
                                                    : 10),
                                      ),
                                    ],
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
