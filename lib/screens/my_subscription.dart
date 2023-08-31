import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/Become%20a%20servie%20man/renew_service.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/widgets/backbutton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/widgets/top_logo.dart';

class MySubscriptionPage extends StatefulWidget {
  const MySubscriptionPage({super.key});

  @override
  State<MySubscriptionPage> createState() => _MySubscriptionPageState();
}

class _MySubscriptionPageState extends State<MySubscriptionPage> {
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
    final subscription = Provider.of<DataProvider>(context, listen: false)
        .activeSubscription
        ?.subscriptions;

    final size = MediaQuery.of(context).size;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    final str = AppLocalizations.of(context)!;
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
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const HomePage(
                              selectedIndex: 0,
                            ),
                          ));
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
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const HomePage(
                              selectedIndex: 1,
                            ),
                          ));
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
          child: Column(
            children: [
              Row(
                children: [
                  BackButton2(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TopLogo(),
                  )
                ],
              ),
              Stack(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(
                  //       width: 15,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child:
                  //           // Text(
                  //           //   textAlign: TextAlign.center,
                  //           //   String.fromCharCode(Icons.arrow_back.codePoint),
                  //           //   style: TextStyle(
                  //           //     inherit: false,
                  //           //     color: ColorManager.primary,
                  //           //     fontSize: 30.0,
                  //           //     fontWeight: FontWeight.w600,
                  //           //     fontFamily: Icons.search.fontFamily,
                  //           //     package: Icons.arrow_back.fontPackage,
                  //           //   ),
                  //           // )
                  //           const Icon(
                  //         Icons.arrow_back,
                  //         size: 30,
                  //         color: ColorManager.primary,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        str.pp_my_sub,
                        style: getSemiBoldtStyle(
                            color: ColorManager.black, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .03,
              ),
              subscription?.length == 0
                  ? Center(
                      child: Text(
                        "No Subscription Available",
                        style: getRegularStyle(
                            color: ColorManager.grayLight, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subscription?.length ?? 0,
                      itemBuilder: (context, index) {
                        print(subscription?[index].toJson());
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
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
                            height: size.height * .21,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 20, 20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        subscription?[index].packageName ?? '',
                                        style: getMediumtStyle(
                                            color: ColorManager.primary,
                                            fontSize: 16),
                                      ),
                                      // const SizedBox(height: 5),
                                      Text(
                                        "${subscription?[index].amount} ${str.paid} |${subscription?[index].validity}",
                                        style: getMediumtStyle(
                                            color:
                                                ColorManager.paymentPageColor1,
                                            fontSize: 12),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            str.msb_pur,
                                            style: getMediumtStyle(
                                                color: ColorManager
                                                    .paymentPageColor1,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            " ${subscription?[index].subscriptionDate}",
                                            style: getMediumtStyle(
                                                color: ColorManager
                                                    .paymentPageColor1,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            str.msb_exp,
                                            style: getMediumtStyle(
                                                color: ColorManager
                                                    .paymentPageColor1,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            " ${subscription?[index].expiryDate}",
                                            style: getMediumtStyle(
                                                color: ColorManager
                                                    .paymentPageColor1,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (ctx) {
                                            return RenewServicePage(
                                              serviceId: subscription?[index]
                                                  .serviceId,
                                            );
                                          }));
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: ColorManager.primary,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              str.msb_renew,
                                              style: getRegularStyle(
                                                  color:
                                                      ColorManager.whiteColor,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * .2,
                                    child: SvgPicture.network(
                                      height: size.height * .1,
                                      '$endPoint${subscription?[index].serviceImage}',
                                      color: ColorManager.primary,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // )
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
    );
  }
}
