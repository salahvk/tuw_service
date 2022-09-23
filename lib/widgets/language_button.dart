import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';

class LanguageButton extends StatelessWidget {
  final String language;
  final Color color;
  const LanguageButton({
    Key? key,
    required this.language,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 6.0,
            color: Colors.grey.shade400,
            offset: const Offset(5, 6.5),
          ),
        ], color: color, borderRadius: BorderRadius.circular(5)),
        height: 32,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Center(
            child: Text(
              language,
              style:
                  getRegularStyle(color: ColorManager.whiteText, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
