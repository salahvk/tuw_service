import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:social_media_services/API/home/get_service_man.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/controllers/controllers.dart';
import 'package:social_media_services/providers/data_provider.dart';
import 'package:social_media_services/responsive/responsive.dart';
import 'package:social_media_services/widgets/Ser_button.dart';
import 'package:social_media_services/widgets/ser_drawer_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SerDrawer extends StatefulWidget {
  int? id;
  SerDrawer({
    this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<SerDrawer> createState() => _SerDrawerState();
}

class _SerDrawerState extends State<SerDrawer> {
  String lang = '';
  bool isResetSelected = false;
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mob = Responsive.isMobile(context);
    final str = AppLocalizations.of(context)!;
    final provider = Provider.of<DataProvider>(context, listen: false);
    return DrawerHeader(
        decoration: BoxDecoration(
          color: ColorManager.primary3,
          borderRadius: lang == 'ar'
              ? const BorderRadius.only(
                  topRight: Radius.circular(8), bottomRight: Radius.circular(8))
              : const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ServiceStatusButton(size: size),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14, 16, 0.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    str.sd_available,
                    style: getSemiBoldtStyle(
                        color: ColorManager.whiteText, fontSize: mob ? 16 : 12),
                  ),
                ],
              ),
            ),
            SerDrawerList(
              id: widget.id ?? 0,
              image: ImageAssets.scooter,
              title: 'Two-Wheeler',
              // isResetSelected: isResetSelected,
              key: UniqueKey(),
            ),
            SerDrawerList(
              id: widget.id ?? 0,
              image: ImageAssets.car,
              title: 'Four-Wheeler',
              // isResetSelected: isResetSelected,
              key: UniqueKey(),
            ),
            // SerDrawerList(
            //   image: ImageAssets.truck,
            //   title: 'Truck',
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16.0, 30, 16, 0.0),
            //   child: Row(
            //     // mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         str.sd_type,
            //         style: getSemiBoldtStyle(
            //             color: ColorManager.whiteText, fontSize: mob ? 16 : 12),
            //       ),
            //     ],
            //   ),
            // ),
            // SerDrawerList(
            //   image: ImageAssets.fuel,
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // SerDrawerList(
            //   image: ImageAssets.disc,
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // SerDrawerList(
            //   image: ImageAssets.repair,
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // SerDrawerList(
            //   image: ImageAssets.engine,
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // SerDrawerList(
            //   image: ImageAssets.truck,
            //   // isResetSelected: isResetSelected,
            //   key: UniqueKey(),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return SerTypeDrawerList(
            //         image: homeData![index].image ?? '',
            //         title: homeData[index].service ?? '',
            //         key: UniqueKey(),
            //       );
            //     },
            //     itemCount: homeData?.length ?? 0,
            //   ),
            // ),
            const Spacer(),
            Padding(
              padding: mob
                  ? const EdgeInsets.fromLTRB(0, 15, 0, 30)
                  : const EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: ElevatedButton(
                  onPressed: () async {
                    await searchServiceMan(
                        context,
                        widget.id.toString(),
                        '',
                        ServiceControllers.stateController.text,
                        ServiceControllers.regionController.text,
                        '',
                        '');

                    setState(() {
                      // isResetSelected = true;
                    });
                    provider.isFourWheelerSelected = false;
                    provider.isTwoWheelerSelected = false;
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.whiteColor,
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0)),
                  child: Text(
                    str.sd_reset,
                    style: getSemiBoldtStyle(
                        color: ColorManager.primary, fontSize: 16),
                  )),
            ),
          ],
        ));
  }
}
