import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class CustomDrawerList extends StatelessWidget {
  final String title;
  const CustomDrawerList({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListTile(
        title: Row(
          children: [
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
                style: getBoldtStyle(color: ColorManager.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
