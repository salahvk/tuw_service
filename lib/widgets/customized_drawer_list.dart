import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class CustomDrawerList extends StatelessWidget {
  final String title;
  GestureTapCallback? onTap;
  CustomDrawerList({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.primary,
      child: InkWell(
        splashColor: ColorManager.whiteColor,
        // hoverColor: ColorManager.whiteColor,
        // customBorder: const CircleBorder(),
        enableFeedback: true,
        excludeFromSemantics: true,
        onTap: onTap,
        child: SizedBox(
          // decoration: BoxDecoration(
          //     color: ColorManager.whiteColor,
          //     border: Border.all(color: ColorManager.black)),
          height: 35,
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  String.fromCharCode(Icons.arrow_forward_ios.codePoint),
                  style: TextStyle(
                    inherit: false,
                    color: ColorManager.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: Icons.arrow_forward_ios.fontFamily,
                    package: Icons.arrow_forward_ios.fontPackage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    title,
                    style:
                        getBoldtStyle(color: ColorManager.black, fontSize: 16),
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
