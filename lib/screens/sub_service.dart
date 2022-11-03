import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/endpoint.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:social_media_services/screens/servicer.dart';

class SubServicesPage extends StatelessWidget {
  const SubServicesPage({Key? key}) : super(key: key);

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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        color: ColorManager.serviceHomeGrey,
                                        fontSize:
                                            homeData[index].service!.length > 13
                                                ? mob
                                                    ? 12
                                                    : 10
                                                : mob
                                                    ? 16
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
        ),
      ),
    );
  }
}
