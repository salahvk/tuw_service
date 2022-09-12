import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class ServiceStatusButton extends StatelessWidget {
  const ServiceStatusButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: size.width * .48,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.white10.withAlpha(80)),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withAlpha(50),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          ),
        ],
        color: Colors.white.withOpacity(0.2),
      ),
      child: Center(
          child: Text(
        "Service Status",
        style: getSemiBoldtStyle(color: ColorManager.whiteText, fontSize: 16),
      )),
    );
  }
}
