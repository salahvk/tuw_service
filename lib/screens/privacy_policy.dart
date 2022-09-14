import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:social_media_services/custom/lorem.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                children: [
                  Container(
                      width: 38,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.primary,
                      ),
                      child: Center(child: Image.asset(ImageAssets.privacy))),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Privacy Policy",
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: 17),
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            const Divider(color: ColorManager.engineWorkerColor, height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: Text(
                lorem,
                style: getRegularStyle(
                    color: ColorManager.engineWorkerColor, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
