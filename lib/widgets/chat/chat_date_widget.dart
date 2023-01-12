import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class ChatDateWidget extends StatelessWidget {
  const ChatDateWidget({
    Key? key,
    required this.localDate,
  }) : super(key: key);

  final String localDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 6),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 130,
          minWidth: 110,
        ),
        height: 30,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(
          localDate,
          style: getSemiBoldtStyle(color: ColorManager.grayDark),
        )),
      ),
    );
  }
}
