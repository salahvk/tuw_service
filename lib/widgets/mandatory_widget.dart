import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/widgets/title_widget.dart';

class MandatoryHeader extends StatelessWidget {
  final String heading;
  const MandatoryHeader({
    Key? key,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        children: [
          TitleWidget(name: heading),
          const Icon(
            Icons.star_outlined,
            size: 10,
            color: ColorManager.errorRed,
          )
        ],
      ),
    );
  }
}
