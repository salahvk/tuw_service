import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:social_media_services/components/assets_manager.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class StatusLIstTile extends StatefulWidget {
  final String title;
  final String checkBoxValue;
  const StatusLIstTile({
    Key? key,
    required this.title,
    required this.checkBoxValue,
  }) : super(key: key);

  @override
  State<StatusLIstTile> createState() => _StatusLIstTileState();
}

class _StatusLIstTileState extends State<StatusLIstTile> {
  String lang = '';
  @override
  void initState() {
    super.initState();
    lang = Hive.box('LocalLan').get(
      'lang',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.all(1.3),
            child: widget.checkBoxValue == widget.title
                ? Image.asset(
                    ImageAssets.blackTick,
                    color: ColorManager.primary,
                  )
                : null,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          widget.title,
          style: getRegularStyle(
              color: ColorManager.whiteColor, fontSize: lang == 'ar' ? 11 : 14),
        )
      ],
    );
  }
}
