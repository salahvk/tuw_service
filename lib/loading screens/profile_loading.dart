// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_services/API/get_serviceManProfileDetails.dart';

import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/model/serviceManLIst.dart';

import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/serviceman/serviceman_list_details.dart';

class ProfileLoading extends StatefulWidget {
  Serviceman? serviceman;
  String? serviceId;
  ProfileLoading({super.key, this.serviceman, this.serviceId});

  @override
  State<ProfileLoading> createState() => _ServiceManDetailsState();
}

class _ServiceManDetailsState extends State<ProfileLoading> {
  String lang = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getServiceManDetailsFun(
          context, widget.serviceId ?? widget.serviceman?.id.toString());
      Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ServiceManDetails(
              serviceman: widget.serviceman,
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mob = Responsive.isMobile(context);

    final size = MediaQuery.of(context).size;
    final str = AppLocalizations.of(context)!;

    return Scaffold(
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
                          Shimmer.fromColors(
                            baseColor: ColorManager.whiteColor,
                            highlightColor: Colors.green,
                            child: CircleAvatar(
                                backgroundColor:
                                    ColorManager.whiteColor.withOpacity(0.8),
                                radius: 45,
                                child: Image.asset(
                                  'assets/user.png',
                                )),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      height: 40,
                      // left: size.width * .0,
                      child: CircleAvatar(
                        radius: mob ? 8 : 6,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
                  child: Text(
                    '',
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: 16),
                  ),
                ),
                Text('',
                    style: getRegularStyle(
                        color: ColorManager.engineWorkerColor, fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: ColorManager.whiteColor,
                      highlightColor: Colors.green,
                      child: Container(
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
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: ColorManager.whiteColor,
                        highlightColor: Colors.green,
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
                                child: Image.asset(
                                  'assets/no_image.png',
                                  fit: BoxFit.cover,
                                )),
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
                        '',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '',
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 16),
                    ),
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: ColorManager.whiteColor,
                  highlightColor: Colors.green,
                  child: Padding(
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
                        Text("",
                            style: getRegularStyle(
                                color: ColorManager.engineWorkerColor,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: ColorManager.whiteColor,
                  highlightColor: Colors.green,
                  child: Row(
                    children: [
                      Text(
                        '${str.wd_tran}:',
                        style: getRegularStyle(
                            color: ColorManager.black, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(ImageAssets.scooter),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('',
                          style: getRegularStyle(
                              color: ColorManager.engineWorkerColor,
                              fontSize: 15)),
                    ],
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: ColorManager.whiteColor,
                  highlightColor: Colors.green,
                  child: Padding(
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
                ),
                Row(
                  children: [
                    // userData?.profile == null
                    //     ? Container()
                    //     :
                    Text(
                      '',
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Shimmer.fromColors(
                  baseColor: ColorManager.whiteColor,
                  highlightColor: Colors.green,
                  child: Row(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
