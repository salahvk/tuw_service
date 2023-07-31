import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/loading%20screens/chat_loading_screen.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/responsive/responsive_width.dart';
import 'package:social_media_services/screens/serviceman%20settings%20profile/serviceman_profile_edit.dart';
import 'package:social_media_services/utils/animatedSnackBar.dart';
import 'package:social_media_services/utils/bottom_nav.dart';
import 'package:social_media_services/widgets/backbutton.dart';
import 'package:social_media_services/widgets/custom_drawer.dart';
import 'package:social_media_services/widgets/popup_image.dart';
import 'package:social_media_services/widgets/report_user_diologue.dart';

class ServiceManDetails extends StatefulWidget {
  GlobalKey<ScaffoldState>? scaffoldKey;
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
    final w = MediaQuery.of(context).size.width;
    final mobWth = ResponsiveWidth.isMobile(context);
    final smobWth = ResponsiveWidth.issMobile(context);
    String? transport;
    if (userData != null && userData.transport != null) {
      transport = userData.transport!.contains('four') ? str.s_four : str.s_two;
    }
    print(userData?.profilePic);
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
      bottomNavigationBar: BottomNavigationWidget(
        isInsidePage: true,
        selectedIndex: 3,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              BackButton2(),
              Padding(
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
                              InkWell(
                                onTap: () {
                                  userData!.profileImage!.isEmpty
                                      ? showAnimatedSnackBar(
                                          context, str.sv_no_images)
                                      : showDialog(
                                          context: context,
                                          builder: (context) => PopupImage(
                                              image:
                                                  '/${userData.profileImage}'),
                                          barrierDismissible: true);
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorManager.whiteColor.withOpacity(0.8),
                                  radius: 45,
                                  backgroundImage:
                                      userData?.profileImage == null
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
                    Text(
                        '${userData?.countryName ?? ''} | ${userData?.state ?? ''}',
                        style: getRegularStyle(
                            color: ColorManager.engineWorkerColor,
                            fontSize: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   width: 40,
                        //   height: 30,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         blurRadius: 9.5,
                        //         color: Colors.grey.shade400,
                        //         offset: const Offset(6, 6),
                        //       ),
                        //     ],
                        //     borderRadius: BorderRadius.circular(5),
                        //     color: ColorManager.primary,
                        //   ),
                        //   child: const Icon(
                        //     Icons.photo_library_outlined,
                        //     color: ColorManager.whiteColor,
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        itemCount: provider
                                .serviceManDetails!.galleryImages!.isEmpty
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
                                      context, str.sv_no_images)
                                  : showDialog(
                                      context: context,
                                      builder: (context) => PopupImage(
                                          image: galleryImages[index]
                                              .galleryImage),
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
                    userData?.about != null
                        ? Row(
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
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, userData?.about != null ? 15 : 0, 0, 10),
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
                        Text(transport ?? '',
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
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const ReportUserDiologue(),
                                  barrierDismissible: true);
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(
                                    size.width * .1, 0, size.width * .1, 0)),
                            child: Text(
                              str.wd_report,
                              style: getMediumtStyle(
                                  color: ColorManager.whiteText, fontSize: 14),
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: navToChatLoadingScreen,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(
                                  size.width * .1, 0, size.width * .1, 0)),
                          child: SvgPicture.asset(
                            height: 20,
                            ImageAssets.chatIconSvg,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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

  navToChatLoadingScreen() {
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    final provider = Provider.of<DataProvider>(context, listen: false);
    final serviceManId = provider.serviceManDetails?.userData?.id;

    servicerProvider.servicerId = serviceManId;
    print(serviceManId);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return ChatLoadingScreen(
        serviceManId: serviceManId.toString(),
      );
    }));
  }
}
