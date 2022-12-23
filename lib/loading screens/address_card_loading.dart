// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/API/address/getUserAddress.dart';
import 'package:social_media_services/API/other%20User/other_user_profie.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/Address%20page/address_card.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';

import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAddressCardLoading extends StatefulWidget {
  String id;
  String? addressId;
  UserAddressCardLoading({super.key, required this.id, this.addressId});

  @override
  State<UserAddressCardLoading> createState() => _UserAddressCardLoadingState();
}

class _UserAddressCardLoadingState extends State<UserAddressCardLoading> {
  int _selectedIndex = 2;
  final List<Widget> _screens = [
    const ServiceHomePage(),
    const MessagePage(
      isHome: true,
    )
  ];
  String lang = '';
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getOtherUserProfile(context, widget.id);
      await showUserAddress(context, widget.addressId ?? '');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
        return const UserAddressCard();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: true);
    final userDetails = provider.viewProfileModel?.userdetails;
    final userAddress = provider.userAddressShow?.userAddress;
    final currentLocator = LatLng(
        double.parse(userDetails?.latitude ?? '41.612849'),
        double.parse(userDetails?.longitude ?? '13.046816'));
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
        body: _selectedIndex != 2
            ? _screens[_selectedIndex]
            : SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: ColorManager.whiteColor,
                            highlightColor: Colors.green,
                            child: const CircleAvatar(
                              maxRadius: 40.5,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: ColorManager.whiteColor,
                                highlightColor: Colors.green,
                                child: Text(
                                  provider.viewProfileModel?.userdetails
                                          ?.firstname ??
                                      '',
                                  style: getBoldtStyle(
                                      color: ColorManager.black, fontSize: 13),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Shimmer.fromColors(
                                baseColor: ColorManager.whiteColor,
                                highlightColor: Colors.green,
                                child: Text(
                                  provider.viewProfileModel?.userdetails
                                          ?.lastname ??
                                      '',
                                  style: getBoldtStyle(
                                      color: ColorManager.black, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Shimmer.fromColors(
                            baseColor: ColorManager.whiteColor,
                            highlightColor: Colors.green,
                            child: Text(
                              "mail@gmail.com",
                              style: getRegularStyle(
                                  color: ColorManager.grayLight, fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Shimmer.fromColors(
                            baseColor: ColorManager.whiteColor,
                            highlightColor: Colors.green,
                            child: Text(
                              provider.viewProfileModel?.userdetails?.phone ??
                                  '',
                              style: getRegularStyle(
                                  color: ColorManager.grayLight, fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: SizedBox(
                                    height: 100,
                                    width: size.width,
                                    child: Shimmer.fromColors(
                                      baseColor: ColorManager.whiteColor,
                                      highlightColor: Colors.green,
                                      child: Container(
                                          height: 20,
                                          color: ColorManager.whiteColor,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator())),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            // offset: const Offset(2, 2.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: size.width,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  userDetails?.homeLocation != null
                                      ? Text(
                                          userDetails?.homeLocation ?? '',
                                          style: getRegularStyle(
                                              color: ColorManager.black,
                                              fontSize: userDetails!
                                                          .homeLocation!
                                                          .length >
                                                      20
                                                  ? 10
                                                  : 12),
                                        )
                                      : Container(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(5)),

                                    // width: 30,
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 2, 5, 5),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: ColorManager.whiteColor,
                                            ),
                                            Shimmer.fromColors(
                                              baseColor:
                                                  ColorManager.whiteColor,
                                              highlightColor: Colors.green,
                                              child: Text(
                                                str.a_home_locator,
                                                style: getRegularStyle(
                                                    color: ColorManager
                                                        .whiteColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox(
                                height: 100,
                                width: size.width,
                                child: Shimmer.fromColors(
                                  baseColor: ColorManager.whiteColor,
                                  highlightColor: Colors.green,
                                  child: Container(
                                      height: 20,
                                      color: ColorManager.whiteColor,
                                      child: const Center(
                                          child: CircularProgressIndicator())),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: ColorManager.whiteColor,
                                highlightColor: Colors.green,
                                child: Text(
                                  str.a_address,
                                  style: getBoldtStyle(
                                      color: ColorManager.black, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorManager.whiteColor,
                                  highlightColor: Colors.green,
                                  child: Text(
                                    str.a_home,
                                    style: getRegularStyle(
                                        color: ColorManager.grayLight),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
