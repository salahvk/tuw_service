import 'package:flutter/material.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';

class ServicerListTile extends StatelessWidget {
  const ServicerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.shade300,
            offset: const Offset(5, 8.5),
          ),
        ],
      ),
      width: size.width,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorManager.whiteColor),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              width: size.width * 0.3,
              child: ClipRRect(child: Image.asset(ImageAssets.profileIcon)),
            ),
            SizedBox(
              width: size.width * 0.3,
              child: Column(
                children: const [Text('data')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
