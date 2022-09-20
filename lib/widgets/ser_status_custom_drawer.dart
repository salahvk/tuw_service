import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/widgets/Ser_button.dart';
import 'package:social_media_services/widgets/ser_drawer_list.dart';

class SerDrawer extends StatelessWidget {
  const SerDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DrawerHeader(
        decoration: const BoxDecoration(
          color: ColorManager.primary2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ServiceStatusButton(size: size),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14, 0, 0.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Available Transport:',
                    style: getSemiBoldtStyle(
                        color: ColorManager.whiteText, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SerDrawerList(
              image: ImageAssets.scooter,
            ),
            const SerDrawerList(
              image: ImageAssets.car,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 30, 0, 0.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Service Type:',
                    style: getSemiBoldtStyle(
                        color: ColorManager.whiteText, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SerDrawerList(
              image: ImageAssets.fuel,
            ),
            const SerDrawerList(
              image: ImageAssets.disc,
            ),
            const SerDrawerList(
              image: ImageAssets.repair,
            ),
            const SerDrawerList(
              image: ImageAssets.engine,
            ),
            const SerDrawerList(
              image: ImageAssets.truck,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 30),
              child: ElevatedButton(
                  onPressed: () {
                    // player.stop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.whiteColor,
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0)),
                  child: Text(
                    " Reset ",
                    style: getSemiBoldtStyle(
                        color: ColorManager.primary, fontSize: 16),
                  )),
            ),
          ],
        ));
  }
}
