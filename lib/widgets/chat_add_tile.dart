import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class ChatAddTile extends StatelessWidget {
  final String title;
  final String image;
  const ChatAddTile({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * .03,
        ),
        SizedBox(
          width: 25,
          height: 25,
          child: Image.asset(
            image,
            color: ColorManager.whiteColor,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: size.width * .025,
        ),
        Text(title,
            style: getBoldtStyle(color: ColorManager.whiteColor, fontSize: 15))
      ],
    );
  }
}
