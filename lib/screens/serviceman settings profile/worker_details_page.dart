import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/model/serviceManLIst.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/widgets/profile_image.dart';

class WorkerDetailed extends StatefulWidget {
  Serviceman? serviceman;
  WorkerDetailed({super.key, this.serviceman});

  @override
  State<WorkerDetailed> createState() => _WorkerDetailedState();
}

class _WorkerDetailedState extends State<WorkerDetailed> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: true);

    final userData = provider.serviceManProfile?.userData;
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
                CircleAvatar(
                  radius: 45,
                  backgroundColor: ColorManager.background,
                  child: ProfileImage(
                    isNavigationActive: false,
                    iconSize: 0,
                    profileSize: 60,
                    iconRadius: 0,
                  ),
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
                Text('${userData?.state ?? ''} | ${userData?.region ?? ''}',
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
                        provider.serviceManProfile!.galleryImages!.isEmpty
                            ? 4
                            : provider.serviceManProfile?.galleryImages?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final galleryImages =
                          provider.serviceManProfile?.galleryImages;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: Container(
                          height: 80,
                          width: size.width * .3,
                          color: ColorManager.grayLight,
                          child: galleryImages!.isEmpty
                              ? Center(
                                  child: Text(
                                  "Add an Image",
                                  style: getRegularStyle(
                                      color: ColorManager.black),
                                ))
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
                    Text(
                      userData?.about ?? '',
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 16),
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
                      Text("Engine Mechanic",
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
                    Text(
                      userData?.profile ?? '',
                      style: getRegularStyle(
                          color: ColorManager.engineWorkerColor, fontSize: 16),
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
                          // player.stop();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(33, 0, 33, 0)),
                        child: Text(
                          'Edit Profile',
                          style: getMediumtStyle(
                              color: ColorManager.whiteText, fontSize: 14),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
