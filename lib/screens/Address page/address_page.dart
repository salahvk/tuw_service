// ignore_for_file: use_build_context_synchronously

// import 'dart:math';

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/address/getUserAddress.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/viewProfile.dart';
import 'package:social_media_services/model/viewProfileModel.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive_width.dart';

import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/screens/Address%20page/address_add.dart';
import 'package:social_media_services/screens/Google%20Map/googleMapScreen.dart';
import 'package:social_media_services/screens/messagePage.dart';
import 'package:social_media_services/screens/serviceHome.dart';
import 'package:social_media_services/utils/get_location.dart';
import 'package:social_media_services/widgets/AddressBox/addressPage_box.dart';
import 'package:social_media_services/widgets/back_button.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/profile_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
  bool isLocFetching = false;

  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
    getUserAddress(context);
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
    final userAddress = provider.userAddressShow?.userAddress;
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);

    final firstName = toBeginningOfSentenceCase(
        provider.viewProfileModel?.userdetails?.firstname);
    final currentLocator = LatLng(
        double.parse(userDetails?.latitude ?? '41.612849'),
        double.parse(userDetails?.longitude ?? '13.046816'));
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
                    child: Stack(
                      children: [
                        BackButton2(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileImage(
                                isNavigationActive: false,
                                iconSize: 12,
                                profileSize: 40.5,
                                iconRadius: 12,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    firstName ?? '',
                                    style: getBoldtStyle(
                                        color: ColorManager.black, fontSize: 13),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    provider.viewProfileModel?.userdetails
                                            ?.lastname ??
                                        '',
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
                                provider.viewProfileModel?.userdetails?.phone ?? '',
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
                                                userDetails: userDetails),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: InkWell(
                                        onTap: () {
                                          selectImage();
                                        },
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
                                          child: const CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.edit,
                                              size: 14,
                                              color: ColorManager.primary,
                                            ),
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
                                          onTap: () async {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (ctx) {
                                            //   return CustomizeMarkerExample();
                                            // }));

                                            final s =
                                                await getCurrentLocationPermission(
                                                    context);
                                            print(s);

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (ctx) {
                                              return GoogleMapScreen(
                                                  lat: s[0].toString(),
                                                  lot: s[1].toString());
                                            }));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 2, 5, 5),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: ColorManager.whiteColor,
                                                ),
                                                Text(
                                                  str.a_home_locator,
                                                  style: getRegularStyle(
                                                      color:
                                                          ColorManager.whiteColor),
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
                                    child: GoogleMap(
                                      myLocationEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: currentLocator,
                                        zoom: 4.0,
                                      ),
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

                                // width: 30,
                                child: InkWell(
                                  onTap: () async {
                                    _openGoogleMaps(currentLocator.latitude,
                                        currentLocator.latitude);
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
                                          "Open Google Map",
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
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(5)),

                                    // width: 30,
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isLocFetching = true;
                                        });
                                        final s =
                                            await getCurrentLocationPermission(
                                                context);
                                        print(s);
                                        log("__________");
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (ctx) {
                                        //   return CustomizeMarkerExample();
                                        // }));
                                        // await Future.delayed(
                                        //     Duration(seconds: 500));
                                        setState(() {
                                          isLocFetching = false;
                                        });
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (ctx) {
                                        //   return AddressLocatorScreen(
                                        //       lat: s[0].toString(),
                                        //       lot: s[1].toString());
                                        // }));
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (ctx) {
                                          return UserAddressEdit(
                                              lat: s[0].toString(),
                                              lot: s[1].toString());
                                        }));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        child: isLocFetching
                                            ? Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: ColorManager.whiteColor,
                                                  ),
                                                  Text(
                                                    str.a_add,
                                                    style: getRegularStyle(
                                                        color: ColorManager
                                                            .whiteColor),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      str.a_home,
                                      style: getRegularStyle(
                                          color: ColorManager.grayLight),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AddressBox(
                                    userAddress: userAddress?[index],
                                  );
                                },
                                itemCount: userAddress?.length ?? 0,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  selectImage() async {
    print("Img picker");
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final imagePath = image?.path;
    final imageName = image?.name;
    print(image?.name);
    print(image?.path);
    // final XFile? photo =
    //     await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    // updateProfile(imageName);
    setState(() {
      isLoading = true;
    });
    await upload(image);
    setState(() {
      isLoading = false;
    });
  }

  upload(XFile imageFile) async {
    var stream = http.ByteStream(DelegatingStream(imageFile.openRead()));
    var length = await imageFile.length();
    final apiToken = Hive.box("token").get('api_token');
    final provider = Provider.of<DataProvider>(context, listen: false);
    var uri = Uri.parse(updateCoverPictureApi);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    // "content-type": "multipart/form-data"
    request.headers
        .addAll({"device-id": provider.deviceId ?? '', "api-token": apiToken});
    var multipartFile = http.MultipartFile(
      'cover_image',
      stream,
      length,
      filename: (imageFile.path),
    );
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    await viewProfile(context);
    setState(() {});
  }
}

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  final Userdetails? userDetails;

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return CachedNetworkImage(
      imageUrl: '$endPoint/assets/uploads/cover_image/${userDetails?.coverPic}',
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
