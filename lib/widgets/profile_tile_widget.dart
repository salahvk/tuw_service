import 'package:social_media_services/components/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:social_media_services/components/styles_manager.dart';

class ProfileTitleWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  const ProfileTitleWidget({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          const SizedBox(
            width: 60,
          ),
          Icon(
            icon,
            color: ColorManager.primary,
            size: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(name,
                style: getRegularStyle(
                    color: ColorManager.serviceHomeGrey, fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
