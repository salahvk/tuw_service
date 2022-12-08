import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/home_page.dart';
import 'package:social_media_services/screens/serviceman%20settings%20profile/serviceman_profile_edit.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/popup_image.dart';

class ServiceManDetails extends StatefulWidget {
  Serviceman? serviceman;
  ServiceManDetails({super.key, this.serviceman});

  @override
  State<ServiceManDetails> createState() => _ServiceManDetailsState();
}

class _ServiceManDetailsState extends State<ServiceManDetails> {
  final int _selectedIndex = 2;
  String lang = '';
  @override
  void initState() {
    super.initState();

    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: true);
    final mob = Responsive.isMobile(context);
    final userData = provider.serviceManDetails?.userData;
    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;
    print(userData?.profilePic);
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
                      child: SvgPicture.asset(ImageAssets.homeIconSvg),
                    ),
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
                      child: SvgPicture.asset(ImageAssets.chatIconSvg),
                    ),
                  ),
                ),
              ],
              haptic: true,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homePage, (route) => false);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(4, 4.5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                ColorManager.whiteColor.withOpacity(0.8),
                            radius: 45,
                            backgroundImage: userData?.profileImage == null
                                ? null
                                : CachedNetworkImageProvider(
                                    "$endPoint/${userData?.profileImage}",
                                  ),
                            child: userData?.profileImage == null
                                ? Image.asset(
                                    'assets/user.png',
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      height: 40,
                      // left: size.width * .0,
                      child: CircleAvatar(
                        radius: mob ? 8 : 6,
                        backgroundColor: userData?.onlineStatus == 'online'
                            ? ColorManager.primary
                            : userData?.onlineStatus == 'offline'
                                ? ColorManager.grayLight
                                : ColorManager.errorRed,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                  child: Text(
                    '${userData?.firstname ?? ''} ${userData?.lastname ?? ''}',
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: 16),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(ImageAssets.tools),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Text(widget.serviceman?.about ?? '',
                //         style: getRegularStyle(
                //             color: ColorManager.engineWorkerColor,
                //             fontSize: 15)),
                //   ],
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                Text(
                    '${userData?.countryName ?? ''} | ${userData?.state ?? ''}',
                    style: getRegularStyle(
                        color: ColorManager.engineWorkerColor, fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 9.5,
                            color: Colors.grey.shade400,
                            offset: const Offset(6, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.primary,
                      ),
                      child: const Icon(
                        Icons.photo_library_outlined,
                        color: ColorManager.whiteColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount:
                        provider.serviceManDetails!.galleryImages!.isEmpty
                            ? 4
                            : provider.serviceManDetails?.galleryImages?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final galleryImages =
                          provider.serviceManDetails?.galleryImages;
                      return InkWell(
                        onTap: () {
                          galleryImages!.isEmpty
                              ? showAnimatedSnackBar(
                                  context, "No images to display")
                              : showDialog(
                                  context: context,
                                  builder: (context) => PopupImage(
                                      image: galleryImages[index].galleryImage),
                                  barrierDismissible: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorManager.grayLight,
                              ),
                              height: 80,
                              width: size.width * .3,
                              child: galleryImages!.isEmpty
                                  ? Image.asset(
                                      'assets/no_image.png',
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          height: 80,
                                          width: size.width * .3,
                                          color: ColorManager.grayLight,
                                        );
                                      },
                                      imageUrl:
                                          "$endPoint${galleryImages[index].galleryImage ?? ''}",
                                      fit: BoxFit.cover,
                                      // cacheManager: customCacheManager,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        '${str.wd_desc}:',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        userData?.about ?? '',
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        '${str.wd_ser}:',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: Image.asset(
                          ImageAssets.tools,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(userData?.serviceName ?? '',
                          style: getRegularStyle(
                              color: ColorManager.engineWorkerColor,
                              fontSize: 15)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${str.wd_tran}:',
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    userData?.transport == 'two wheeler'
                        ? Image.asset(ImageAssets.scooter)
                        : Image.asset(ImageAssets.car),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(userData?.transport ?? '',
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 15)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
                  child: Row(
                    children: [
                      Text(
                        '${str.wd_more}:',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // userData?.profile == null
                    //     ? Container()
                    //     :
                    Expanded(
                      child: Text(
                        userData?.profile ?? '',
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                size.width * .1, 0, size.width * .1, 0)),
                        child: Text(
                          'Report',
                          style: getMediumtStyle(
                              color: ColorManager.whiteText, fontSize: 14),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                size.width * .1, 0, size.width * .1, 0)),
                        child: Text(
                          'Block',
                          style: getMediumtStyle(
                              color: ColorManager.whiteText, fontSize: 14),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToServiceEditManProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return const ServiceManProfileEditPage();
    }));
  }
}
