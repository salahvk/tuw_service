import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/links.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/screens/servicer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(w * .02, mob ? 40 : 20, w * .02, 0),
          // implement GridView.builder
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  str.se_services,
                  style: getBoldtStyle(color: ColorManager.black, fontSize: 20),
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
                height: mob ? 120 : 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: switzeland,
                          width: w * .95,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: mob ? 130 : 100,
                          childAspectRatio: 3 / 3,
                          crossAxisSpacing: 14,
                          mainAxisExtent: mob ? 123 : 100,
                          mainAxisSpacing: 20),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return const ServicerPage();
                            }));
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
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Image.asset(ImageAssets.profileIcon),
                                Text(myProducts[index + 1]["name"],
                                    style: getRegularStyle(
                                        color: ColorManager.serviceHomeGrey,
                                        fontSize: mob ? 16 : 12)),
                                Text("100+ Profiles",
                                    style: getRegularStyle(
                                        color: const Color(0xffbababa),
                                        fontSize: mob ? 14 : 10)),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
