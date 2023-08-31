// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/address/getUserAddress.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/model/other%20User/other_user_profile_model.dart';
import 'package:social_media_services/model/viewProfileModel.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/Google%20Map/view_location.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/widgets/AddressBox/user_address_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAddressCard extends StatefulWidget {
  const UserAddressCard({super.key});

  @override
  State<UserAddressCard> createState() => _UserAddressCardState();
}

class _UserAddressCardState extends State<UserAddressCard> {
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
      await getUserAddress(context);
      setState(() {});
    });
  }

  void _openGoogleMaps(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // if (await launchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    // } else {
    // throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: true);
    final userDetails = provider.viewProfileModel?.userdetails;
    // final userAddress = provider.pUserAddressShow?.userAddress;
    final userprofile = provider.otherUserProfile?.userdetails;
    final userAddressData = provider.pUserAddressShow?.userAddress;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    final homeLocation =
        "${userAddressData?.country} | ${userAddressData?.state}";
    final currentLocator = LatLng(
        provider.addressLatitude ?? double.parse('41.612849'),
        provider.addressLongitude ?? double.parse('13.046816'));
    //  LatLng(
    // double.parse(userAddressData?.latitude ??  '41.612849'),
    // double.parse(userAddressData?.longitude ?? '13.046816'));
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        endDrawer: SizedBox(
          height: size.height * 0.825,
          width: mobWth
              ? w * 0.6
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
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: ColorManager.whiteColor,
                            child: CircleAvatar(
                              radius: 40,
                              // backgroundColor: ColorManager.grayDark,
                              backgroundImage: userprofile?.profilePic == null
                                  ? const AssetImage('assets/user.png')
                                      as ImageProvider
                                  : CachedNetworkImageProvider(
                                      '$endPoint${userprofile?.profileImage}'),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userprofile?.firstname ?? '',
                                style: getBoldtStyle(
                                    color: ColorManager.black, fontSize: 13),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                userprofile?.lastname ?? '',
                                style: getBoldtStyle(
                                    color: ColorManager.black, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          // Text(
                          //   "mail@gmail.com",
                          //   style: getRegularStyle(
                          //       color: ColorManager.grayLight, fontSize: 13),
                          // ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            userprofile?.phone ?? '',
                            style: getRegularStyle(
                                color: ColorManager.grayLight, fontSize: 13),
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
                                    child: isLoading
                                        ? Container(
                                            height: 20,
                                            color: ColorManager.whiteColor,
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()))
                                        : CoverImageWidget(
                                            userDetail: userprofile),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  userAddressData?.country != null
                                      ? Text(
                                          homeLocation,
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
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 14),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox(
                                height: 150,
                                width: size.width,
                                child: GoogleMap(
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: currentLocator,
                                    zoom: 4.0,
                                  ),
                                  onTap: (argument) {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ViewLocationScreen(
                                                latitude:
                                                    userAddressData?.latitude ??
                                                        '',
                                                longitude: userAddressData
                                                        ?.longitude ??
                                                    '')));
                                  },
                                  markers: <Marker>{
                                    Marker(
                                      markerId:
                                          const MarkerId('test_marker_id'),
                                      position: currentLocator,
                                      infoWindow: InfoWindow(
                                        title: str.a_home_locator,
                                        snippet: '*',
                                      ),
                                    ),
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(5)),
                            width: 190,
                            height: 25,
                            child: InkWell(
                              onTap: () async {
                                _openGoogleMaps(
                                    double.parse(
                                        userAddressData?.latitude ?? ''),
                                    double.parse(
                                        userAddressData?.longitude ?? ''));
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: ColorManager.whiteColor,
                                    ),
                                    Text(
                                      str.open_google_map,
                                      style: getRegularStyle(
                                          color: ColorManager.whiteColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                str.a_address,
                                style: getBoldtStyle(
                                    color: ColorManager.black, fontSize: 14),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         str.a_home,
                          //         style: getRegularStyle(
                          //             color: ColorManager.grayLight),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   itemBuilder: (context, index) {
                          //     return
                          //   },
                          //   itemCount:  0,
                          // )
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: ViewLocationScreen(
                                          latitude:
                                              userAddressData?.latitude ?? '',
                                          longitude:
                                              userAddressData?.longitude ??
                                                  '')));
                            },
                            child: UserAddressBox(
                              userAddress: userAddressData,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    Key? key,
    this.userDetails,
    this.userDetail,
  }) : super(key: key);

  final Userdetails? userDetails;
  final Userdetail? userDetail;

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return CachedNetworkImage(
      imageUrl: userDetail == null
          ? '$endPoint${userDetails?.coverImage}'
          : '$endPoint${userDetail?.coverImage}',
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Container(
        height: 20,
        color: ColorManager.whiteColor,
        child: Center(
          child: Text(
            str.a_cover,
            style: getRegularStyle(color: ColorManager.black, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
