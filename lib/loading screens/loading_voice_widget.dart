import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';

class LoadingVoice extends StatelessWidget {
  const LoadingVoice({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .66,
      height: size.height * .07,
      child: Row(
        children: [
          SizedBox(
              width: size.width * .06,
              height: size.width * .06,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: ColorManager.primary,
              )),
          SizedBox(
            height: 15,
            width: size.width * .6,
            child: Slider(
              activeColor: ColorManager.primary3,
              inactiveColor: ColorManager.primary,
              value: 0,
              min: 0.0,
              onChanged: (v) {},
            ),
          ),
        ],
      ),
    );
  }
}
