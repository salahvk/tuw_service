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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
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
        const SizedBox(
          width: 10,
        ),
        Text(title,
            style: getBoldtStyle(color: ColorManager.whiteColor, fontSize: 15))
      ],
    );
  }
}
