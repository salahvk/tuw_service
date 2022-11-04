import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/API/home/get_subService.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/utils/loading_page.dart';

class ServiceHomePage extends StatelessWidget {
  ServiceHomePage({Key? key}) : super(key: key);

  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Service $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    final mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    final w = MediaQuery.of(context).size.width;
    final provider = Provider.of<DataProvider>(context, listen: false);
    final homeData = provider.homeModel?.services;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(w * .02, mob ? 30 : 10, w * .02, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    str.se_services,
                    style:
                        getBoldtStyle(color: ColorManager.black, fontSize: 20),
                  ),
                ),
                // * carousel
                // CarouselSlider.builder(
                //   itemCount: 10,
                //   itemBuilder:
                //       (BuildContext context, int itemIndex, int pageViewIndex) {
                //     return Container(
                //       decoration: const BoxDecoration(
                //         color: ColorManager.whiteColor,
                //       ),
                //       // width: 250,
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(5),
                //         child: CachedNetworkImage(
                //           imageUrl: switzeland,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     );
                //   },
                //   options: CarouselOptions(
                //     autoPlay: false,
                //     height: mob ? 110 : 60,
                //     onPageChanged: (index, reason) {},
                //     enlargeCenterPage: true,
                //     viewportFraction: 0.3,
                //     aspectRatio: 2.0,
                //     initialPage: 0,
                //   ),
                // ),
                SizedBox(
                  height: mob ? 150 : 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl:
                                "$endPoint${provider.homeModel?.homebanner?[index].image}",
                            width: w * .95,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    itemCount: provider.homeModel?.homebanner?.length ?? 0,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                                MaterialPageRoute(builder: (ctx) {
                              return LoadingListPage();
                            }));
                            final id = homeData![index].id;
                            getSubService(context, id);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (ctx) {
                            //   return const ServicerPage();
                            // }));
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //     width: mob ? 70.0 : 50,
                                //     height: mob ? 70.0 : 50,
                                //     child: ScalableImageWidget.fromSISource(
                                //         onLoading: (p0) {
                                //           return Container(
                                //             child:
                                //                 const CircularProgressIndicator(
                                //               strokeWidth: 2,
                                //             ),
                                //           );
                                //         },
                                //         cache: ScalableImageCache(
                                //             size: homeData?.length ?? 0),
                                //         si: ScalableImageSource.fromSvgHttpUrl(
                                //             bigFloats: true,
                                //             Uri.parse(
                                //                 '$endPoint${homeData?[index].image}')))),
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
                                        color: ColorManager.serviceHomeGrey,
                                        fontSize:
                                            homeData[index].service!.length > 13
                                                ? mob
                                                    ? 12
                                                    : 10
                                                : mob
                                                    ? 16
                                                    : 12)),
                                // Text("100+ Profiles",
                                //     style: getRegularStyle(
                                //         color: const Color(0xffbababa),
                                //         fontSize: mob ? 14 : 10)),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // getSubServices() {
  //   getSubServices();
  // }
}
