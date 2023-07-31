import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/home/get_subService.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/routes_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/loading%20screens/loading_page.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/providers/servicer_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/utils/back_handler.dart';

class ServiceHomePage extends StatefulWidget {
  const ServiceHomePage({Key? key}) : super(key: key);

  @override
  State<ServiceHomePage> createState() => _ServiceHomePageState();
}

class _ServiceHomePageState extends State<ServiceHomePage> {
  int _backButtonPressCount = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<DataProvider>(context, listen: false);
      // provider.viewProfileModel?.userdetails?.latitude == null
      //     ? await requestLocationPermission(context)
      //     : null;
    });
  }

  Future<bool> _onWillPop() async {
    print(_backButtonPressCount);
    if (_backButtonPressCount == 1) {
      // First back press
      _showTooltip("Press back again to exit");
      _backButtonPressCount++;
      Timer(Duration(seconds: 3), () {
        _backButtonPressCount = 0; // Reset the back press count after 2 seconds
      });
      return true; // Prevent the app from closing
    } else if (_backButtonPressCount == 0) {
      // Initial back press
      _showTooltip("Press back again to exit");
      _backButtonPressCount++;
      Timer(Duration(seconds: 3), () {
        _backButtonPressCount = 0; // Reset the back press count after 2 seconds
      });
      return false; // Prevent the app from closing
    } else {
      // Second back press within 2 seconds, allow the app to exit
      return true;
    }
  }

  void _showTooltip(String message) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + renderBox.size.height,
        left: position.dx + (renderBox.size.width - 200.0) / 2,
        child: Material(
          color: Colors.transparent,
          child: Tooltip(
            message: message,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Timer(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;
    final provider = Provider.of<DataProvider>(context, listen: true);
    final servicerProvider =
        Provider.of<ServicerProvider>(context, listen: false);
    final homeData = provider.homeModel?.services;

    return BackButtonHandler(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Icon(
                //         Icons.arrow_back_ios_new,
                //         size: 25,
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(w * .02, mob ? 30 : 10, w * .02, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          str.se_services,
                          style: getBoldtStyle(
                              color: ColorManager.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: mob ? 150 : 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  width: w * .92,
                                  color: ColorManager.whiteColor,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "$endPoint${provider.homeModel?.homebanner?[index].image}",
                                    width: w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount:
                              provider.homeModel?.homebanner?.length ?? 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: mob ? 130 : 100,
                                    childAspectRatio: 3 / 3,
                                    crossAxisSpacing: 14,
                                    mainAxisExtent: mob ? 123 : 100,
                                    mainAxisSpacing: 20),
                            itemCount: homeData?.length ?? 0,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      FadePageRoute(page: LoadingListPage()));
                                  final id = homeData![index].id;
                                  servicerProvider.serviceId = id;
                                  getSubService(context, id, false);
                                  print("$endPoint${homeData[index].image}");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10.0,
                                          color: Colors.grey.shade300,
                                          offset: const Offset(2, 2.5),
                                        ),
                                      ],
                                      color: ColorManager.whiteColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: mob ? 70.0 : 50,
                                          height: mob ? 70.0 : 50,
                                          child: SvgPicture.network(
                                            '$endPoint${homeData?[index].image}',
                                            color: ColorManager.primary2,
                                          )),
                                      Text(homeData![index].service ?? '',
                                          textAlign: TextAlign.center,
                                          style: getRegularStyle(
                                              color:
                                                  ColorManager.serviceHomeGrey,
                                              fontSize: homeData[index]
                                                          .service!
                                                          .length >
                                                      13
                                                  ? 10
                                                  : 12)),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
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
