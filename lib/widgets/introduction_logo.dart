import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';

class IntroductionLogo extends StatelessWidget {
  const IntroductionLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.primary.withOpacity(0.1),
      radius: 68.5,
      child: CircleAvatar(
        backgroundColor: ColorManager.background,
        radius: 67.5,
        child: CircleAvatar(
          backgroundColor: ColorManager.primary.withOpacity(0.14),
          radius: 59.5,
          child: CircleAvatar(
            backgroundColor: ColorManager.background,
            radius: 58.5,
            child: CircleAvatar(
              backgroundColor: ColorManager.primary..withOpacity(0.2),
              radius: 51.5,
              child: CircleAvatar(
                backgroundColor: ColorManager.background,
                radius: 51,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: ColorManager.primary..withOpacity(0.25),
                    radius: 44.5,
                    child: Center(
                      child: SvgPicture.asset(ImageAssets.logo, height: 55),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
