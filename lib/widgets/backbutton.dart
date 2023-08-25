import 'package:flutter/material.dart';
import 'package:social_media_services/components/color_manager.dart';
import 'package:social_media_services/components/styles_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackButton2 extends StatelessWidget {
  const BackButton2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              String.fromCharCode(Icons.arrow_back_ios_rounded.codePoint),
              style: TextStyle(
                inherit: false,
                color: ColorManager.primary,
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                fontFamily: Icons.search.fontFamily,
                package: Icons.arrow_back_ios_rounded.fontPackage,
              ),
            ),
            Text(
              str.back,
              style: getRegularStyle(color: ColorManager.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
